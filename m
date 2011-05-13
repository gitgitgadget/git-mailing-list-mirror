From: Osamu OKANO <okano.osamu@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=207/7=5D=20translate=20and=20remove=20fazzy?=
Date: Fri, 13 May 2011 22:14:18 +0900
Message-ID: <1305292458-3920-8-git-send-email-okano.osamu@gmail.com>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Osamu OKANO <okano.osamu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:15:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKsD3-0006sv-PX
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 15:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771Ab1EMNOy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2011 09:14:54 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:51354 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932636Ab1EMNOq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 09:14:46 -0400
Received: by mail-px0-f173.google.com with SMTP id 16so1666762pxi.4
        for <git@vger.kernel.org>; Fri, 13 May 2011 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=mBcSiG8+n6RoHhA2LOSkhvW5xLkNdf8Lbcq4iL4+qMA=;
        b=mmt+B1M8fvhZmTpbC/vx0zghI4yg5cNtgpAHMmhoQLM3L5oDMD1Dm93CQnXpHxC6F0
         nGKnCjEr3yLr1D4AbtMv1h6+SlnS5ZEd+BU3LolD+mjE+VGfY+ZyAY0PkRtABoLPGQ1t
         aD67+dYgHv4MRCvqw0ffzUPkCdtmL5vII+al8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=q9cCKQKqq9zUisVby7fIP4ji1ZKHNZSGADPEQRpKdbfPJkUqVqgs4Bcypj7CR4rNKP
         +FiBgIKQDROqq2BkvdU+jtVZ6ejXkFscW/jFENdiFytdHVFOQZMj5KA9dkwMcEYzirdk
         sHPFKALJPnx1593rTlTc9LLJuRJmHyS+w9x9g=
Received: by 10.68.65.110 with SMTP id w14mr2094122pbs.382.1305292486514;
        Fri, 13 May 2011 06:14:46 -0700 (PDT)
Received: from localhost.localdomain (i118-20-60-90.s04.a013.ap.plala.or.jp [118.20.60.90])
        by mx.google.com with ESMTPS id q20sm1358319pbt.72.2011.05.13.06.14.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 06:14:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.169.g505a1.dirty
In-Reply-To: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173535>

---
 Documentation/ja/git-stage.po |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/ja/git-stage.po b/Documentation/ja/git-stage=
=2Epo
index 697b411..cf45291 100644
--- a/Documentation/ja/git-stage.po
+++ b/Documentation/ja/git-stage.po
@@ -28,9 +28,8 @@ msgstr "NAME\n"
=20
 #. type: delimited block =3D
 #: git-stage.txt:7
-#, fuzzy
 msgid "git-stage - Add your file contents to the staging area"
-msgstr "git-stage - =E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=B3=E3=83=
=B3=E3=83=86=E3=83=B3=E3=83=84=E3=82=92=E3=82=B9=E3=83=86=E3=83=BC=E3=82=
=B8=E3=83=B3=E3=82=B0=E3=82=A8=E3=83=AA=E3=82=A2=E3=81=AB=E8=BF=BD=E5=8A=
=A0=E3=81=99=E3=82=8B"
+msgstr "git-stage - =E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE=E3=83=95=E3=82=
=A1=E3=82=A4=E3=83=AB=E3=82=B3=E3=83=B3=E3=83=86=E3=83=B3=E3=83=84=E3=82=
=92=E3=82=B9=E3=83=86=E3=83=BC=E3=82=B8=E3=83=B3=E3=82=B0=E3=82=A8=E3=83=
=AA=E3=82=A2=E3=81=AB=E8=BF=BD=E5=8A=A0=E3=81=99=E3=82=8B"
=20
 #. type: Title -
 #: git-stage.txt:10
--=20
1.7.5.1.169.g505a1.dirty
