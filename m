From: Diego Gonzalez <diegog.lagash@gmail.com>
Subject: Log is always empty in OSX
Date: Fri, 27 May 2011 16:38:09 -0300
Message-ID: <BANLkTim4iBtNPm65vTiJYyA4csTHu9gd2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 21:38:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ2rQ-0003db-0r
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 21:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682Ab1E0TiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 15:38:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60943 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab1E0TiK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 15:38:10 -0400
Received: by pwi15 with SMTP id 15so935078pwi.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=P+0B1ol+Xbs+x+Y59RMkZfg3X632PpljVmT1S+dCaYU=;
        b=f21D3cNArAQfQds5MHfzvanNRBVONRcx54EN/bWb8UAksmVnmqa2Am0IOpmZZ4el61
         tHYO/G6VSWYcCTgLljghy6zIiNmK7EcPbw1ObvmBMQ8q1dCLsjVGTXYNFu6UCN6xLuNT
         Ky/q+ovuuPn30nMq91Y0Z5y4h9EGM0E0fxlDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Z5BLdrAGGdzsnqJUryXN6nSfx9Fa5TNJA7RY1f9weHAao/JCs3xsW8swKQBTfy8X6l
         LBLc21urIn69F4BeoDAAmuiHF5QoBTWfgj3Gy19Ypb4wWKTWbBiBSsobWdIwDXjugIJJ
         AiWbWm9n/kBn14NW4IM2B9sw6/V4vHSD5O72o=
Received: by 10.142.5.23 with SMTP id 23mr393207wfe.249.1306525089674; Fri, 27
 May 2011 12:38:09 -0700 (PDT)
Received: by 10.142.250.35 with HTTP; Fri, 27 May 2011 12:38:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174641>

Hi guys,
I'm using GIT in a specific folder on OSX and I'm not able to get any
output from the git log command, do you know what it means? Is this a
bug or just some missconfiguration. I've installed through Homebrew.

$uname -a
Darwin Diego-Gonzalezs-MacBook-Pro.local 10.7.0 Darwin Kernel Version
10.7.0: Sat Jan 29 15:17:16 PST 2011; root:xnu-1504.9.37~1/
RELEASE_I386 i386
$ git version
git version 1.7.5.2
$ git log
$ git commit -a -m "message"
[master 445dab2] message
 2 files changed, 1 insertions(+), 23 deletions(-)
 mode change 100644 => 100755 c
 delete mode 100644 ur.js
$ git log
$

THanks in advance,
DieogG
