From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: How does receive-pack and pre-receive hook works ?
Date: Sun, 27 Jun 2010 07:54:51 +0530
Message-ID: <AANLkTinYRF2m95MU2c817bK6mfehPt_OMBH45R6laNUe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 27 04:25:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OShYL-0002L2-DG
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 04:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985Ab0F0CY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 22:24:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55121 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab0F0CYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 22:24:55 -0400
Received: by gwaa18 with SMTP id a18so1675033gwa.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=EZfenm0yIryS9ERvm2uT4KTSe3cMIvbomvJS4vNRyug=;
        b=hMrTy7UsmxOBsdCFkgGPJWKpNEjPAxNDYfOnyjhpGYDy6jTWHm22oit7kU+y5tYbSu
         5SA3LEywpZd3xXiyeH8wUeDvR1ulFw2Ke4B4XauJ8gmyapt3ht+k6Vqury/FxmIBMkYj
         dYJaP+f20PTUYHzMVdRTyAOnW1eWqoy6MkBQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pgtyiiXVOMx5wrXUNB4ittBBwgQQ90VWlJIWQxihXKqiFyfkl6Iec3WbxtusK/1yzH
         GI81yy42SwtioG4Bt+6VFNJ01mC9OEN2RLbVs7fICz4nKFY9+Gq4RPX305YminmoNty7
         UE1b5mL1A2oVzVzZSAagWmeaBM7fpolZAotX8=
Received: by 10.91.159.30 with SMTP id l30mr2570952ago.69.1277605491427; Sat, 
	26 Jun 2010 19:24:51 -0700 (PDT)
Received: by 10.90.25.8 with HTTP; Sat, 26 Jun 2010 19:24:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149787>

How does receive-pack and pre-receive hook works ?

I have added following in pre-recieve hook; all works fine. git
rev-list --pretty d6d147f432869037a7ac8bdca3a2d5bc0cdc1e9f
^a3fe19833480023b72350d6e56e939cbd0ba2c8b

I Would like know where does Git saves whatever I am pushing before
exit 0 of this hook; Specifically how does it understand about
'd6d147f432869037a7ac8bdca3a2d5bc0cdc1e9f' which is not part of
destination depot / repo.

Thx/ Mahesh.
