From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] user-manual: use standarized quoting
Date: Fri, 25 Dec 2009 15:05:49 +0200
Message-ID: <1261746350-26990-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 25 14:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NO9rv-0006Zq-Qr
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 14:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbZLYNGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 08:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbZLYNF7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 08:05:59 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:44791 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbZLYNF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 08:05:59 -0500
Received: by fxm25 with SMTP id 25so3288144fxm.21
        for <git@vger.kernel.org>; Fri, 25 Dec 2009 05:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=UWI9AxE/gXJCo0tcv3M+G4XxuJMrpOw+H+XPEeFE5is=;
        b=Riui8UZbCZVnLH85Omc/c5tN90DWRF6fPu5gdp/ucELjYNPRJr6uyu9iu6PdObEA5D
         b9Dumoq8cLPW31I2WrpqF0Tkhc6bGRXbCwAj9QEqAn49XIA30H40MHlYg/TCGhZUnv3b
         t6jlvmli39gyGLYtNoSy3VpQqTeTJUuaWDp6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LmKkCqcblz05daYrcENr37gEM3UTmi54R90yC11jh3MbhypXUaZT/DX/eh7uEyYloC
         FixMSss5mhlkFd5STMWZ+jp8jrbkNC96kR00oAmAr2RBBgc0r6/M2gWS9Vg6JbSy/dhj
         PevaRU7IA1SxMJ4GgWWcqvBt0zOiyBDUr28tw=
Received: by 10.223.16.72 with SMTP id n8mr1361311faa.26.1261746356706;
        Fri, 25 Dec 2009 05:05:56 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 15sm3184067fxm.10.2009.12.25.05.05.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Dec 2009 05:05:55 -0800 (PST)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135673>

Hi,

This is a big patch that was sent before, but now I'm explaining my rationale
for the quoting style I used. I noticed a few deviations on my own rules, so I
fixed them.

What do you think?

Felipe Contreras (1):
  user-manual: general quoting improvements

 Documentation/user-manual.txt |  884 ++++++++++++++++++++--------------------
 1 files changed, 442 insertions(+), 442 deletions(-)
