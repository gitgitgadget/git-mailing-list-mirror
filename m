From: Bill Priest <priestwilliaml@yahoo.com>
Subject: git 1.5.4.1 svn fetch stops fetching w/ "Last fetch revision ..."
Date: Tue, 12 Feb 2008 05:42:57 -0800 (PST)
Message-ID: <883188.51167.qm@web55015.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 14:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOvWa-0005rZ-2B
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 14:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757460AbYBLNtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 08:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757554AbYBLNtl
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 08:49:41 -0500
Received: from web55015.mail.re4.yahoo.com ([206.190.58.149]:20568 "HELO
	web55015.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755128AbYBLNtk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 08:49:40 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2008 08:49:40 EST
Received: (qmail 55533 invoked by uid 60001); 12 Feb 2008 13:42:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=6tMWg+dJFMUXl1QvLKzLL6SpXT/mKCSLH4egPnGkJDHSKzT17as0OROG5yuYhmt2176zqXmO7Inl7gvoW2Qr04NL9nUDGDbn0s6r+r3OvnFPSUPeHN8A5dYrPDhmKtIvOrsgMjgapA5YdBkzsaaFoMjiLIQPS8zT6mmXn1xxiMo=;
X-YMail-OSG: dTJ8_gQVM1nYuTmY7oG4B3QhCA21Bwgpw0QCWKoX
Received: from [12.44.137.148] by web55015.mail.re4.yahoo.com via HTTP; Tue, 12 Feb 2008 05:42:57 PST
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73661>

All,
    I upgraded from git 1.5.3.4.452.g09149 to git
1.5.4.1 and upon a subsequent git svn fetch I started
receiving the following:
Index mismatch:
d1437ce54ff0e90f4023ee653761c28626a8295a !=
f567f1f12e7d7ddf1d18e3889061aa9a783dfbba
rereading 1c3d0737f3eb78241eb508e7da6b80e3f3b7fa85
        M       src/foo.c
        M       src/bar.c
Last fetched revision of refs/remotes/release was
r2990, but we are about to fetch: r2985!

git svn fetch w/ 1.5.3 worked correctly and subsequent
fetches "do nothing" as expected.

Is this a known issue?  Is there a work-around? I can
try to track down which change caused the breakage if
needed.

Thanks,

Bill



      ____________________________________________________________________________________
Looking for last minute shopping deals?  
Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping
