From: Phpbb Git <phpbb_git@yahoo.com>
Subject: [newbe question]: why is git-upload-archive a copy and not hardlink?
Date: Sun, 17 Aug 2008 14:58:19 -0700 (PDT)
Message-ID: <952239.39940.qm@web59503.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 00:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUqNp-0007K5-1A
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 00:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYHQWEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 18:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbYHQWEx
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 18:04:53 -0400
Received: from n3b.bullet.mail.ac4.yahoo.com ([76.13.13.73]:20881 "HELO
	n3b.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752426AbYHQWEw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2008 18:04:52 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Aug 2008 18:04:52 EDT
Received: from [76.13.13.26] by n3.bullet.mail.ac4.yahoo.com with NNFMP; 17 Aug 2008 21:58:20 -0000
Received: from [76.13.10.172] by t3.bullet.mail.ac4.yahoo.com with NNFMP; 17 Aug 2008 21:58:20 -0000
Received: from [127.0.0.1] by omp113.mail.ac4.yahoo.com with NNFMP; 17 Aug 2008 21:58:20 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 192304.93787.bm@omp113.mail.ac4.yahoo.com
Received: (qmail 40172 invoked by uid 60001); 17 Aug 2008 21:58:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=BAYW+2kVXplwuV/bEe5kHmOTDPtvqdbeGhLxXcZPhMp21sr22YJ5+C30QgkiIOJZgUgWrLEBaW5QJLwKXGoeUjCcQLAJDBw1FHeAYSw3uQMHHgidQfHO9OQO4i0Dlm26L/+hw6vfF6SPLAFvLS0b9EZNEwodWA7PpnhzWkueMuA=;
Received: from [209.6.170.96] by web59503.mail.ac4.yahoo.com via HTTP; Sun, 17 Aug 2008 14:58:19 PDT
X-Mailer: YahooMailRC/1042.48 YahooMailWebService/0.7.218
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92667>

When running "make install", the install procedure creates the 
executable "git" in the bin directory, and many dash commands 
in the libexec/git-core are created as hardlinks. however, in the "bin"
directory there's a file named  git-upload-archive which appears to be 
a copy of git instead of a hardlink.
This is not of utmost importance, I was just curious as to the reason for 
this extra copy of git in the bin directory.


      
