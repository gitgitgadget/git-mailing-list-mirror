From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH on ab/i18n] branch: remove lego in i18n tracking info strings
Date: Thu,  3 May 2012 20:12:00 +0700
Message-ID: <1336050720-21200-1-git-send-email-pclouds@gmail.com>
References: <877gwtyalt.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Christian Stimming <stimming@tuhh.de>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 15:16:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPvtL-00056f-81
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 15:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222Ab2ECNQF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 09:16:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44507 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab2ECNQC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 09:16:02 -0400
Received: by pbbrp8 with SMTP id rp8so2474664pbb.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ft0Qlv5hVzuWeL16sD3Ei83s5UyllWRiExskKia+iE4=;
        b=IZBVRID1JOUNYuJtVE5uGsT6wOCIP4rblOGQP8MmH4sXDVMGwaPajgnKmgFLOOQ2ds
         xbKaPL4oxHtFWx3yJiKB2DqOMmDmxZfxdkP9jz0NbngqI91UCQ9sLE06k6KLbOz52M8q
         L4mbP+LrwzI/bK2J1rpWvHRSWipYIEJ2sndxDjGsL/G0tPQQb5AVQk33O0IRyv0/GFi7
         5d18I0rY0ZskhVkc6R6zB3Y9PAIbktblkEaGWVt+/HoiRjn8Z3sG/9cFpbUhtE39HyAA
         fyqcIgVzsMCeQgfF3Sr12HXviXeMaMIwoXdKx5XLeKdSLqhJOyw87Gs/N5BtVgBmIEvj
         VJiw==
Received: by 10.68.225.104 with SMTP id rj8mr7413478pbc.135.1336050961489;
        Thu, 03 May 2012 06:16:01 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id r6sm5294706pbl.24.2012.05.03.06.15.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 May 2012 06:15:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 May 2012 20:12:27 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <877gwtyalt.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196907>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, May 3, 2012 at 2:42 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
 > Christian Stimming <stimming@tuhh.de> writes:
 >
 >> As one of the earlier translators: I agree with most of those as we=
ll. Thanks
 >> a lot. However, one small remark:
 >>
 >> Am Mittwoch, 2. Mai 2012, 15:49:27 schrieb Thomas Rast:
 >>> @@ -676,11 +675,11 @@ msgstr "hinter "
 >>>
 >>>  #: wt-status.c:908 wt-status.c:911
 >>>  msgid "ahead "
 >>> -msgstr "=C3=BCber "
 >>> +msgstr "weiter: "
 >>>
 >>>  #: wt-status.c:913
 >>>  msgid ", behind "
 >>> -msgstr ", hinter "
 >>> +msgstr ", zur=C3=BCckgefallen "
 >>>
 >>>  #: builtin/add.c:62
 >>>  #, c-format
 >>> @@ -903,12 +902,12 @@ msgstr "Zweig '%s' zeigt auf keine Version"
 >>>  #: builtin/branch.c:396
 >>>  #, c-format
 >>>  msgid "behind %d] "
 >>> -msgstr "hinter %d] "
 >>> +msgstr "%d hinterher] "
 >>>
 >>>  #: builtin/branch.c:398
 >>>  #, c-format
 >>>  msgid "ahead %d] "
 >>> -msgstr "vor %d] "
 >>> +msgstr "%d voraus] "
 >>
 >> In the above hunk, you said "ahead =3D weiter" and "behind =3D zur=C3=
=BCckgefallen",
 >> but now you say "ahead =3D voraus" and "behind =3D hinterher". Is i=
t helpful to
 >> use two different translations, or shouldn't those rather be chosen
 >> identically? The second set sounds somewhat better to me, but the m=
ore
 >> important question is whether both hunks should use the same transl=
ations.
 >
 > Yeah, sorry about that.  The whole thing is a mess because of the le=
go
 > going on.  It would probably be better to first patch the code into
 > shape so that it builds the displays in one step, and then translate
 > that.  As it stands, it's very hard to translate because wt-status.c
 > does not even let you reposition the number.

 The translator in me totally agrees with you. I'll look into
 wt-status legos, but we probably need better infrastructure to mix
 color and text. Pseudo html tags to to mark color, like
 "On branch <color1>%s</color1>" is probably not a bad idea.

 builtin/branch.c |   31 ++++++++++++++++++++++---------
 1 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 8813d2e..5011881 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -384,6 +384,7 @@ static void fill_tracking_info(struct strbuf *stat,=
 const char *branch_name,
 		int show_upstream_ref)
 {
 	int ours, theirs;
+	const char *ref =3D NULL;
 	struct branch *branch =3D branch_get(branch_name);
=20
 	if (!stat_tracking_info(branch, &ours, &theirs)) {
@@ -394,16 +395,28 @@ static void fill_tracking_info(struct strbuf *sta=
t, const char *branch_name,
 		return;
 	}
=20
-	strbuf_addch(stat, '[');
 	if (show_upstream_ref)
-		strbuf_addf(stat, "%s: ",
-			shorten_unambiguous_ref(branch->merge[0]->dst, 0));
-	if (!ours)
-		strbuf_addf(stat, _("behind %d] "), theirs);
-	else if (!theirs)
-		strbuf_addf(stat, _("ahead %d] "), ours);
-	else
-		strbuf_addf(stat, _("ahead %d, behind %d] "), ours, theirs);
+		ref =3D shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+	if (!ours) {
+		if (ref)
+			strbuf_addf(stat, _("[%s: behind %d]"), ref, theirs);
+		else
+			strbuf_addf(stat, _("[behind %d]"), theirs);
+
+	} else if (!theirs) {
+		if (ref)
+			strbuf_addf(stat, _("[%s: ahead %d]"), ref, ours);
+		else
+			strbuf_addf(stat, _("[ahead %d]"), ours);
+	} else {
+		if (ref)
+			strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
+				    ref, ours, theirs);
+		else
+			strbuf_addf(stat, _("[ahead %d, behind %d]"),
+				    ours, theirs);
+	}
+	strbuf_addch(stat, ' ');
 }
=20
 static int matches_merge_filter(struct commit *commit)
--=20
1.7.8.36.g69ee2
