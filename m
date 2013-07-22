From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: Dead link
Date: Mon, 22 Jul 2013 10:02:17 +0200
Message-ID: <20130722080217.GB15550@domone>
References: <20130720192238.GA30833@domone>
 <CALkWK0ktWTcgNSjTtkjJ5ogjE5YAVRdq+HZpQ51-DFObsCjQrQ@mail.gmail.com>
 <20130720194655.GA30946@domone>
 <7vppubr19m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 10:02:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1B4w-0004uL-HL
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 10:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab3GVICl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 04:02:41 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:59452 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab3GVICh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 04:02:37 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 7C2D76828D;
	Mon, 22 Jul 2013 10:02:32 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id 4321E601E0; Mon, 22 Jul 2013 10:02:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vppubr19m.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230966>

On Sun, Jul 21, 2013 at 03:33:57PM -0700, Junio C Hamano wrote:
> Thanks; the patch seems to cover all the instances.
>=20
> Sign off?
ok
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Signed-off-by: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>
---

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index e364007..fe723e4 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4675,5 +4675,5 @@ Write a chapter on using plumbing and writing scr=
ipts.
 Alternates, clone -reference, etc.
=20
 More on recovery from repository corruption.  See:
-	http://marc.theaimsgroup.com/?l=3Dgit&m=3D117263864820799&w=3D2
-	http://marc.theaimsgroup.com/?l=3Dgit&m=3D117147855503798&w=3D2
+	http://marc.info/?l=3Dgit&m=3D117263864820799&w=3D2
+	http://marc.info/?l=3Dgit&m=3D117147855503798&w=3D2
diff --git a/builtin/apply.c b/builtin/apply.c
index 541dc6b..82049c7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -473,7 +473,7 @@ static char *find_name_gnu(const char *line, const =
char *def, int p_value)
=20
 	/*
 	 * Proposed "new-style" GNU patch/diff format; see
-	 * http://marc.theaimsgroup.com/?l=3Dgit&m=3D112927316408690&w=3D2
+	 * http://marc.info/?l=3Dgit&m=3D112927316408690&w=3D2
 	 */
 	if (unquote_c_style(&name, line, NULL)) {
 		strbuf_release(&name);
diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.s=
h
index 331b9b0..d15b313 100755
--- a/t/t6021-merge-criss-cross.sh
+++ b/t/t6021-merge-criss-cross.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Fredrik Kuivinen
 #
=20
-# See http://marc.theaimsgroup.com/?l=3Dgit&m=3D111463358500362&w=3D2 =
for a
+# See http://marc.info/?l=3Dgit&m=3D111463358500362&w=3D2 for a
 # nice description of what this is about.
=20
=20
