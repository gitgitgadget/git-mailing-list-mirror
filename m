From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 0/8] gettextize: git-pull
Date: Mon, 13 Sep 2010 19:35:50 +0000
Message-ID: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 21:37:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvEqX-0005kC-RZ
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 21:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214Ab0IMTgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 15:36:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49809 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab0IMTgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 15:36:10 -0400
Received: by wyf22 with SMTP id 22so6574868wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=lPCdxZalU6pFmLxuqn2oOPNiBv0IQkzjabdOL/+GiRs=;
        b=LZH26iPZruKewdGIfBlVRLHhCVS76luRMdvEpWdCIOs+DAtcDaKchx6f14HzPu8BJI
         kTH3otaeEV+ji0OrUNOashu+MaYfqQ45gahTOeKsGV54VlUXrSiD04x1mtxVz+a8wJmN
         nfg9IU3Gp7XYs5LntIzs+Ld0tdYfC17OAGsHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=jLN10UKkUr0QXLLAACnY2Sy1OtrkZCnKpH5kuklR3N2yLdvLhibZ8LBWAuIaPx5Y0c
         kbqh5j8YIC73GWjPiUhvVkl5wdQLRhpNWCt2y9r0wKl/Ij5PEjozRSyTsZVtyPpq5rUw
         wmH8reMtryHL1e1qG3Y6Hwprx1BbGx7sIOzeY=
Received: by 10.216.159.195 with SMTP id s45mr4768634wek.43.1284406568519;
        Mon, 13 Sep 2010 12:36:08 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm4178195wej.2.2010.09.13.12.36.07
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 12:36:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.110.g6776a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156123>

This is an RFC on a series that makes git-pull.sh translatable. With
this git-bisect/rebase/stash/submodule are the only mainporcelain
commands that aren't translatable.

I'll be folding this into the next version of the ab/i18n series I'll
be sending to Junio. No need to apply it to the current one.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
  gettextize: git-pull add git-sh-i18n
  gettextize: git-pull die messages
  gettextize: git-pull eval_gettext + die message
  gettextize: git-pull eval_gettext + warning message
  gettextize: git-pull split up "no candidate" message
  gettextize: git-pull "You asked to pull" message
  gettextize: git-pull "[...] not currently on a branch" message
  gettextize: git-pull "rebase against" / "merge with" messages

 git-pull.sh |  149 ++++++++++++++++++++++++++++++++++-----------------=
-------
 1 files changed, 87 insertions(+), 62 deletions(-)

--=20
1.7.3.rc1.110.g6776a.dirty
