From: Gary Yang <garyyang6@yahoo.com>
Subject: fatal: did you run git update-server-info on the server? mv post-update.sample post-update
Date: Wed, 19 Nov 2008 10:59:41 -0800 (PST)
Message-ID: <155056.88492.qm@web37905.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 20:01:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2sIT-0005mS-8O
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 20:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbYKSS7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 13:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbYKSS7m
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 13:59:42 -0500
Received: from web37905.mail.mud.yahoo.com ([209.191.91.167]:26367 "HELO
	web37905.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754849AbYKSS7m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Nov 2008 13:59:42 -0500
Received: (qmail 88674 invoked by uid 60001); 19 Nov 2008 18:59:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=bwSoM81pQLwTTLrJmGTOczABcpmOffVA9nUsZnTuWlIx9yg07hrNvfGvOU8yYv8xY5393T5qcZeUJJtNldJy1MlxpEL5uH2WjJbmfAYcnKSyQTt+BGXI/gBtoefjuAirKneP/f+qV1j1fNB7LQOc1bRqxGR0lWhN+kRdm/DGFZA=;
X-YMail-OSG: pO2d6TIVM1nFtvi27TbHvUKl8sCuFqg.fLF4KevAxPJ2sjs1bpWSPUT6NRhBEihRtGPX.5HPbi6MqKL1th7lP9xutRd.EHQ8yhrp.EeO0IIAMoiWnx49wuSywmb1Stu_ppH.uUhNzyB.xmeim_Dzz90kBdPx1UxI3hycvBFCL0OTTzFsa1K3wvhD5Tdr
Received: from [76.195.33.70] by web37905.mail.mud.yahoo.com via HTTP; Wed, 19 Nov 2008 10:59:41 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101369>

The doc, http://www.kernel.org/pub/software/scm/git/docs/gitcore-tutorial.html, at the the section, "Working with Others" says that
mv post-update.sample post-update under the $GIT_DIR/hooks directory for the public repository. I did that. The file permission is executable.

ls -alF /pub/git/u-boot.git/hooks/post-update
-rwxr-xr-x  1 garyyang6 engr 189 Nov 18 15:54 /pub/git/u-boot.git/hooks/post-update*

But, I got error, "did you run git update-server-info on the server" when I tried to "git pull". Any idea why I got this error?

I did not run post-update at public repository manually. Do I need to run it for the very first time?

At my private repository, I did:
git pull http://git01.my.com /pub/git/u-boot.git HEAD
fatal: http://git01.my.com/info/refs not found: did you run git update-server-info on the server?

Thank you,

Gary




      
