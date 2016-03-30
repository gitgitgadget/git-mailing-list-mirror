From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v1 6/7] correct blame for files commited with CRLF
Date: Wed, 30 Mar 2016 19:48:52 +0200
Message-ID: <56FC1184.7010802@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1459257938-17389-1-git-send-email-tboegi@web.de>
 <xmqqa8lhyzbq.fsf@gitster.mtv.corp.google.com> <56FADCAB.1010201@web.de>
 <xmqqio05vxo9.fsf@gitster.mtv.corp.google.com>
 <xmqqa8lhvxd4.fsf@gitster.mtv.corp.google.com>
 <xmqq60w5vwj9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:50:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alKFj-0002Nm-Bb
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbcC3Rty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2016 13:49:54 -0400
Received: from mout.web.de ([212.227.15.3]:62409 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbcC3Rtx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:49:53 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0M3Bv5-1ZuSuS1csZ-00swmo; Wed, 30 Mar 2016 19:49:31
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <xmqq60w5vwj9.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:s1TM1sgoW7RVOHOP/O9mSFuPCLIoBd+zijwdFXZV4/0FGSi5PBa
 iQHu/YL0HlFJoaF508zqFfjWFwCmlwSD4Mg2tm3Fw3bvbIlICE1u3w+rhps13vs4tson99z
 X9nb4k/KSjuILKac3to8wmyNw5GV92zA1dbOTqVggmIjaBHko6rc/IhtB0UdE1XHAHswS2V
 MKx4GPIa1VAN7wNTkWD8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C0psHDY/O8g=:aj5wDq/2rurV1i8+62usTz
 3mwWe7BJyrqJabnkdYtevFg3hseXgI7i1ujgQ7Y3FsEuvKypXThaUHa6kOv8X0sylfCnYMCuo
 Npp8ci4KJyJAk+EPHYRCCT9oIRSiVSLljyMRy9WqstLi+ksJq8tzKm4X2bj+uWxRW38x67Mcs
 8kRZJVzXr0qKiBOQrdw+q0c8GZT2y95kXGOQAHGteJXYghOSloSgxum4Ga5wYE4WEeTkt9u8s
 mYGm/st+wGJmz+th56Vu8SVbfkmOlD5MHj00wh8B2CIGkZ2M26RAddmU33/yJnW2HQYUrMj5b
 sL7m3orCkqtkHHVTMtD/5v7NimJx+B1dFTGlpr0i4HnD2klYtcmb0QL+LoGfz13umsDeKqFfH
 DAC6onhKVnsArat6/OR91BmQKy4Qe12zf707wTc71YmuZfsrRJJVjidEtW+ymBdVDpx0bDqkF
 jFdVbw75U9qAByHFbc2WYfME8EX45h3Y6IQGWCNFTDz9T+ZzJHa/24Y5ee408I4rPafSGcuaM
 guIBUUOzsK1R00OQl3LNXOmDCecjpFsA4f4i6L/OeJJctaVcIJvk6LFRh9RXAMrvFOQQAR75Q
 fHUPQi1XB3FUoN9V/KgrMtSNL3AHpURMbtsWH0FD5a+cvqAuzppqQ0ohz57KjOrQpIjzFEfyU
 ujge7hurAVFefJPEADiup+YwoV1h8rGVJnJuEr4BFcz69xwlpyJSI3OzH8Wrpy1x5AtpMq77l
 j/bFrgJjCuBJbl7m+Z7L6gbtPLS8WugTtSQl/i1+2a4cGyOm4SSjnzXOxq1s0RxId5fa+8fa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290332>

7/7 needs to be amended with something like this,
and the documentation needs an update.

In any case, the user can normalize the repo like this:
$ echo "* text=3Dauto" >>.gitattributes
$ rm .git/index     # Remove the index to force Git to
$ git reset         # re-scan the working directory
$ git status        # Show files that will be normalized
$ git add -u
$ git add .gitattributes
$ git commit -m "Introduce end-of-line normalization"

(or run "dos2unix" filename)

----------------


commit a604db36bb946000776514c220964f32979c8756
Author: Torsten B=C3=B6gershausen <tboegi@web.de>
Date:   Wed Mar 30 15:53:52 2016 +0200

    convert.c: add warning when eol are wrong after checkout
   =20
    When line endings are not normalized, they may be different after t=
he
    next checkout to what is configured.
    Add a warning, similar to the CRLF-LF replacement, when a file is c=
ommited,
    and the line endings are not converted at commit or checkout.

diff --git a/convert.c b/convert.c
index 8266d87..1fddbe8 100644
--- a/convert.c
+++ b/convert.c
@@ -18,6 +18,8 @@
 #define CONVERT_STAT_BITS_TXT_CRLF  0x2
 #define CONVERT_STAT_BITS_BIN       0x4
=20
+#define CONVERT_STAT_BITS_MIXED (CONVERT_STAT_BITS_TXT_LF | CONVERT_ST=
AT_BITS_TXT_CRLF)
+
 enum crlf_action {
 	CRLF_UNDEFINED,
 	CRLF_BINARY,
@@ -279,6 +281,8 @@ static void check_safe_crlf(const char *path, enum =
crlf_action crlf_action,
 			    enum safe_crlf checksafe,
 			    unsigned convert_stats, unsigned new_convert_stats)
 {
+	enum eol new_eol =3D output_eol(crlf_action);
+	const char *err_warn_msg =3D NULL;
 	if (!checksafe)
 		return;
 	if (convert_stats & CONVERT_STAT_BITS_TXT_CRLF &&
@@ -303,6 +307,19 @@ static void check_safe_crlf(const char *path, enum=
 crlf_action crlf_action,
 		else /* i.e. SAFE_CRLF_FAIL */
 			die("LF would be replaced by CRLF in %s", path);
 	}
+	if ((new_convert_stats & CONVERT_STAT_BITS_MIXED) =3D=3D CONVERT_STAT=
_BITS_MIXED)
+		err_warn_msg =3D "mixed eol";
+	else if (new_eol =3D=3D EOL_LF && new_convert_stats & CONVERT_STAT_BI=
TS_TXT_CRLF)
+		err_warn_msg =3D "CRLF";
+
+	if (err_warn_msg) {
+		if (checksafe =3D=3D SAFE_CRLF_WARN)
+			warning("%s will be present after commit and checkout in %s.",
+				err_warn_msg, path);
+		else
+			die("%s will be present after commit and checkout in %s",
+			    err_warn_msg, path);
+	}
 }
=20
[snip changes in t0027]=20
