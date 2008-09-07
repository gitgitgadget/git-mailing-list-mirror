From: dhruva <xshelf@yahoo.com>
Subject: git-p4
Date: Sun, 7 Sep 2008 18:47:47 +0530 (IST)
Message-ID: <180211.13539.qm@web95002.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 15:25:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcKGo-0001Be-Cq
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 15:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbYIGNYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 09:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbYIGNYb
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 09:24:31 -0400
Received: from n8a.bullet.mail.tp2.yahoo.com ([203.188.202.107]:47263 "HELO
	n8a.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753255AbYIGNYb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 09:24:31 -0400
Received: from [203.188.202.76] by n8.bullet.mail.tp2.yahoo.com with NNFMP; 07 Sep 2008 13:24:29 -0000
Received: from [202.43.196.225] by t2.bullet.mail.tp2.yahoo.com with NNFMP; 07 Sep 2008 13:24:29 -0000
Received: from [203.212.168.61] by t2.bullet.tpe.yahoo.com with NNFMP; 07 Sep 2008 13:24:29 -0000
Received: from [203.104.18.54] by t2.bullet.kr1.yahoo.com with NNFMP; 07 Sep 2008 13:24:29 -0000
Received: from [127.0.0.1] by omp106.mail.in2.yahoo.com with NNFMP; 07 Sep 2008 13:24:28 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 500467.81976.bm@omp106.mail.in2.yahoo.com
Received: (qmail 13753 invoked by uid 60001); 7 Sep 2008 13:17:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=SkMVK/PTqYmEjRoSLofDx5qr262juXWPCbJEwKh/ZByAQ8ju/H4+OJqKMp4beaDesrIEl+cAKnYYa/abrZGz36f3ObUxZFReAEzWbC/p0vQ64DQG1FWNI6QymTe04VZ46AG1eME0A89yEA2MXyXwnECtfHRT1xvSTtMG6tSFYrU=;
X-YMail-OSG: bHsOa0IVM1l5DXoXoggajqVbLs0gtIr2MqLJ7VTi71JGZi1taM7.zfrdh97j4lA9iHP31ez17SKyNKZjAkj8iAzkyn0F6WsePGY8GuVDTqkrmOBAnOxuiTBG6E_I9W4-
Received: from [59.92.137.244] by web95002.mail.in2.yahoo.com via HTTP; Sun, 07 Sep 2008 18:47:47 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95138>

Hi,
 I am eager to have a full blown git-p4 with ability to _seamlessly_ submit to perforce. The one way pulling of p4 changesets to git works fine except for the un-expanding of RCS keywords like "$Id: ......$" to "$Id$". When submiting back to p4, the file would not have recorded any diff in the keyword which would have changed in p4 due to modifications. Applying the patch during the submission process fails. Also, the 'git-p4 submit --continue' fails saying that '--continue' is an invalid argument.
 I can work on fixing these issues but need help from someone with knowledge of this script 'git-p4'. I have basic expereince in git and am a newbie in p4. I am willing to invest my time in this area. I have written a p4 to hg converter in perl which I have been using. I feel git-p4 is more complete than the script I have written especially in handling file mode.

-dhruva


      Unlimited freedom, unlimited storage. Get it now, on http://help.yahoo..com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
