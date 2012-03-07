From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Wed, 07 Mar 2012 15:36:59 -0800
Message-ID: <7vd38okmp0.fsf@alter.siamese.dyndns.org>
References: <201203052039.16893.tboegi@web.de>
 <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
 <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
 <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
 <7v4nu0m5tb.fsf@alter.siamese.dyndns.org>
 <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:37:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5QPx-0005Hu-Al
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 00:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814Ab2CGXhG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 18:37:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755537Ab2CGXhE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 18:37:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40BB46698;
	Wed,  7 Mar 2012 18:37:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LNsnZx3DAPEU
	8sm0rSbOTV5ju3U=; b=u+FRMyQg1gQJpAOgp/sgLj0M09NFfeGo6/GDhv58WWBk
	A4siTxMkvF7kmnzPdENS5KTnfa8pFkaF1AYYnSaY9ZqihIVeNCbB/YiFjnMTMZ65
	NqzYsmfjOiNU2iPU4kZXBxjLTOsgJLlZjC/YfKEUAjLauwDqouo7aiwAOBEDjs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gsp8Ke
	SO7syGuvcaRDYa1InWIlWgJc4quEbMF80SSvydYsbzlwTOmSr2JIzdRKe2VfyCVZ
	54p01EFarjK1VpXiGctcOjOVv6KJy6VQQ+kNupqM4TuvkPpHr1qq9rai5pRR6TUX
	Qbjv7HTIU6sKkIDg1TWNCBAN+6GAO+00NKKow=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 384836697;
	Wed,  7 Mar 2012 18:37:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 831716696; Wed,  7 Mar 2012
 18:37:00 -0500 (EST)
In-Reply-To: <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 7 Mar
 2012 23:04:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FB3EA7A-68AE-11E1-8C47-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192503>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Having that information doesn't cost us a lot, in this case we can
> just amend the test to assert that on OSX the output should be the
> same as under the UTF-8 output.

Known modes of error behaviour are to show:

 - runs of "?", saying "I dunno";

 - the key used to query the message catalog ("TEST: Old English
   Runes"), saying "I don't do i18n"; or

 - the raw value stored in the message catalog (runes in UTF-8).

and each makes sort-of sense in its own way.

I would be OK if the patch read like the attached, but I do not
think treating the "show key" and "stuff with ?" case differently
like the original code did makes any sense.

It may be better to clarify in the "say" comment that this test is
not about finding if the user's system is *broken* but about seeing
if the "undefined" behaviour upon user error is one that we
recognize, though.

 t/t0204-gettext-reencode-sanity.sh |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reenc=
ode-sanity.sh
index 189af90..8911e93 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -7,6 +7,7 @@ test_description=3D"Gettext reencoding of our *.po/*.mo=
 files works"
=20
 . ./lib-gettext.sh
=20
+RUNES=3D"TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=9A=
=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=E1=
=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=9A=
=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=A6=
=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=B9=
=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=9A=
=AB"
=20
 test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from our U=
TF-8 *.mo files / Icelandic' '
     printf "TILRAUN: Hall=C3=B3 Heimur!" >expect &&
@@ -15,7 +16,7 @@ test_expect_success GETTEXT_LOCALE 'gettext: Emitting=
 UTF-8 from our UTF-8 *.mo
 '
=20
 test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from our U=
TF-8 *.mo files / Runes' '
-    printf "TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=
=9A=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=
=E1=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=
=9A=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=
=A6=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=
=B9=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=
=9A=AB" >expect &&
+    printf "%s" "$RUNES" >expect &&
     LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: Old English =
Runes" >actual &&
     test_cmp expect actual
 '
@@ -28,15 +29,19 @@ test_expect_success GETTEXT_ISO_LOCALE 'gettext: Em=
itting ISO-8859-1 from our UT
=20
 test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-1 f=
rom our UTF-8 *.mo files / Runes' '
     LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Old Engl=
ish Runes" >runes &&
-
-	if grep "^TEST: Old English Runes$" runes
+	runes=3D$(cat runes) &&
+	if test "z$runes" =3D "zTEST: Old English Runes"
+	then
+		say "Your system gives back the key to message catalog for an imposs=
ible request"
+	elif test "z$runes" =3D "zTILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ?=
?????????? ??? ?? ????"
+	then
+		say "Your system replaces an impossible character with ?"
+ 	elif test "z$runes" =3D "z$RUNES"
 	then
-		say "Your system can not handle this complexity and returns the stri=
ng as-is"
+		say "Your system gives back the raw message for an impossible reques=
t"
 	else
-		# Both Solaris and GNU libintl will return this stream of
-		# question marks, so it is s probably portable enough
-		printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? ??=
 ????" >runes-expect &&
-		test_cmp runes-expect runes
+		say "We error behaviour your system shows"
+		false
 	fi
 '
=20
