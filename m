From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: =?UTF-8?B?xazFrSBsZXR0ZXI=?=
Date: Wed, 31 Oct 2012 15:57:28 +0100
Message-ID: <50913C58.2000200@drmicha.warpmail.net>
References: <CAG+H+KTc9trmR9VBgGsdHfAUFW8VMwa218O3yM_nyNWtrySXyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VXNpZXZhxYJhZCDEjG9ybnk=?= <eratyk@tut.by>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:57:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTZjj-0005CG-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 15:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965564Ab2JaO5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2012 10:57:30 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47260 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964937Ab2JaO5a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2012 10:57:30 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 74506204D7;
	Wed, 31 Oct 2012 10:57:29 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 31 Oct 2012 10:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=v0qmy8G4cn2uGPbM2WJK0V
	9+HUs=; b=RbVcN5dx5C49V1HKFn0NFafNxlOhDktj2GgwjX33oPzmTqB7HvaEGM
	K1xBwoo+zHxeTr4WbX0AwIgpHvJayR0lINtC9MAjjz+TEjZbj1ovfR064AvomQzY
	AnqA3awvfSvT2oWfLx3tc170WQqnz7j9NKeBCmLtJ0aTjO8chRpYA=
X-Sasl-enc: H+dg+wTSEeSL9B0q5lxHjGDvkBheUdtmeenng62i1OIr 1351695449
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EA4A448265C;
	Wed, 31 Oct 2012 10:57:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAG+H+KTc9trmR9VBgGsdHfAUFW8VMwa218O3yM_nyNWtrySXyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208829>

Usieva=C5=82ad =C4=8Corny venit, vidit, dixit 31.10.2012 15:39:
> Hello!
>=20
> When I type comment message in Git Gui (1.8.0 and previous), I can't
> use =C5=AC=C5=AD letter (U+016C, U+016D) =E2=80=94 it just transforms=
 into simple Uu.
> Please fix it.

Can you tell us more about your environment (LANG setting, OS)? I just
made two commits (1 with git-gui, one with git-commit on command line),
and both come out fine (LANG=3Dde_DE.UTF-8, git version 1.8.0.226.gba44=
ac5
on Fedora 16):

git log -2 -p
commit 36de49231639eb9edccb1ebad595056d395141c7
Author: Michael J Gruber <git@drmicha.warpmail.net>
Date:   Wed Oct 31 15:54:04 2012 +0100

    =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD

diff --git a/a b/a
index 1074042..677c385 100644
--- a/a
+++ b/a
@@ -1 +1,2 @@
 =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
+=C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD

commit cfcf8f021a53c1bf5ae018a723fbcfad8649a02b
Author: Michael J Gruber <git@drmicha.warpmail.net>
Date:   Wed Oct 31 15:52:52 2012 +0100

    =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD

diff --git a/a b/a
new file mode 100644
index 0000000..1074042
--- /dev/null
+++ b/a
@@ -0,0 +1 @@
+=C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
