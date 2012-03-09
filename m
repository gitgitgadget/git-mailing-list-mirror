From: Junio C Hamano <gitster@pobox.com>
Subject: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Fri, 09 Mar 2012 14:30:47 -0800
Message-ID: <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org>
References: <201203052039.16893.tboegi@web.de>
 <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
 <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
 <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
 <7v4nu0m5tb.fsf@alter.siamese.dyndns.org>
 <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com>
 <7vd38okmp0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 23:31:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68L1-0001kV-TM
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 23:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193Ab2CIWa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 17:30:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758078Ab2CIWav convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 17:30:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A7E57030;
	Fri,  9 Mar 2012 17:30:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gR+GzeQfMNQJ
	m5VJR20Ghgecynk=; b=aCT+j7QyhZHjp1VitJtvuJlsDV8la6OcFol2rzghuFQN
	/ksOPxI17XtoXhL5DOy6sTt/YA4PrMcl+wl90W+m5ewDRLurCx978C/2+1EcS/rz
	zbnQETjIWWNbDTdVGRLDZSgnolqsndi8wvOz6ycMlfGCaX55ZvPAiBOBZfoj+30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gp2X90
	vlHGTctRUCGE0lRozZWIBqFaEBGwIWwqgTRiFqcIS55KjeSgVDx1tDUkDxMbVctf
	PvS49EHBj06VdjhJZiy/3LlcVnruRJh5kOK0PHUUrwYCAQC5cXiFz2mCtmaxQ2uq
	qdT91guzNK51vIMbWQB3s3ueb9g0P6PiiRUqk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 522A8702F;
	Fri,  9 Mar 2012 17:30:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24697702D; Fri,  9 Mar 2012
 17:30:49 -0500 (EST)
In-Reply-To: <7vd38okmp0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 07 Mar 2012 15:36:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8565C4F8-6A37-11E1-9338-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192747>

Junio C Hamano <gitster@pobox.com> writes:

> I would be OK if the patch read like the attached, but I do not
> think treating the "show key" and "stuff with ?" case differently
> like the original code did makes any sense.

Ok, here is a re-roll with proper-ish log message.  I've tested this
only in one of my VMs with is_IS locale (which happened to be Fedora
15).

-- >8 --
Subject: [PATCH] t0204: clarify the "observe undefined behaviour" test

This test asks for an impossible conversion to the system by
preparing an UTF-8 translation with characters that cannot be
expressed in ISO-8859-1, and then asking the message shown in
ISO-8859-1.  Even though the behaviour against such a request is
undefined, it may be interesting to see what the system does, and
the purpose of this test is to see if there are platforms that
exhibit behaviour that we haven't seen.

The original recognized two known modes of behaviour:

 - the key used to query the message catalog ("TEST: Old English
   Runes"), saying "I cannot do that i18n".
 - impossible characters replaced with ASCII "?", saying "I punt".

but they were treated totally differently.  The test simply issued
an informational message "Your system punts on this one" for the
first error mode, while it diagnosed the latter as "Your system is
good; you pass!".

It turns out that Mac OS X exhibits a third mode of error behaviour,
to spew out the raw value stored in the message catalog.  The test
diagnosed this behaviour as "broken", but it is merely trying to do
its best to respond to an impossible request by saying "I punt" in a
way that is slightly different from the second one.

Update the offending test to make it clear what is (and is not)
being tested, update the code structure so that newly discovered
error mode can easily be added to it later, and reword the message
that comes from a failing case to clarify that it is not the system
that is broken when it fails, but merely that the behaviour is not
something we have seen.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0204-gettext-reencode-sanity.sh |   37 ++++++++++++++++++++++------=
--------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reenc=
ode-sanity.sh
index 189af90..8437e51 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -7,6 +7,10 @@ test_description=3D"Gettext reencoding of our *.po/*.m=
o files works"
=20
 . ./lib-gettext.sh
=20
+# The constants used in a tricky observation for undefined behaviour
+RUNES=3D"TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=9A=
=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=E1=
=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=9A=
=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=A6=
=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=B9=
=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=9A=
=AB"
+PUNTS=3D"TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? ?? =
????"
+MSGKEY=3D"TEST: Old English Runes"
=20
 test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from our U=
TF-8 *.mo files / Icelandic' '
     printf "TILRAUN: Hall=C3=B3 Heimur!" >expect &&
@@ -15,8 +19,8 @@ test_expect_success GETTEXT_LOCALE 'gettext: Emitting=
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
-    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: Old English =
Runes" >actual &&
+    printf "%s" "$RUNES" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "$MSGKEY" >actual &=
&
     test_cmp expect actual
 '
=20
@@ -26,18 +30,23 @@ test_expect_success GETTEXT_ISO_LOCALE 'gettext: Em=
itting ISO-8859-1 from our UT
     test_cmp expect actual
 '
=20
-test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-1 f=
rom our UTF-8 *.mo files / Runes' '
-    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Old Engl=
ish Runes" >runes &&
-
-	if grep "^TEST: Old English Runes$" runes
-	then
-		say "Your system can not handle this complexity and returns the stri=
ng as-is"
-	else
-		# Both Solaris and GNU libintl will return this stream of
-		# question marks, so it is s probably portable enough
-		printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? ??=
 ????" >runes-expect &&
-		test_cmp runes-expect runes
-	fi
+test_expect_success GETTEXT_ISO_LOCALE 'gettext: impossible ISO-8859-1=
 output' '
+	LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "$MSGKEY" >runes &=
&
+	case "$(cat runes)" in
+	"$MSGKEY")
+		say "Your system gives back the key to message catalog"
+		;;
+	"$PUNTS")
+		say "Your system replaces an impossible character with ?"
+		;;
+	"$RUNES")
+		say "Your system gives back the raw message for an impossible reques=
t"
+		;;
+	*)
+		say "We never saw the error behaviour your system exhibits"
+		false
+		;;
+	esac
 '
=20
 test_expect_success GETTEXT_LOCALE 'gettext: Fetching a UTF-8 msgid ->=
 UTF-8' '
--=20
1.7.10.rc0.32.g00187
