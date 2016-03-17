From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Thu, 17 Mar 2016 06:16:45 +0100
Message-ID: <56EA3DBD.2070105@web.de>
References: <20160208225806.GA3487@dcvr.yhbt.net>
 <1456597724-26497-1-git-send-email-tboegi@web.de>
 <20160228045945.GA14289@dcvr.yhbt.net> <56D333F1.9050905@web.de>
 <20160315015954.GB25295@dcvr.yhbt.net> <56E79C54.8000606@web.de>
 <20160315070930.GA24036@dcvr.yhbt.net> <56E999C3.4040802@f2.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 17 06:17:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agQJE-00079Z-Di
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 06:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbcCQFRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 01:17:08 -0400
Received: from mout.web.de ([212.227.15.4]:63203 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbcCQFRG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 01:17:06 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LZeou-1ZxPqs02yS-00lV2C; Thu, 17 Mar 2016 06:16:54
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <56E999C3.4040802@f2.dion.ne.jp>
X-Provags-ID: V03:K0:Fg9KzA0VIfBTfVR5rWE0osQnk+L+ASN1c4KYHBsJXOQZ3NcPfQu
 SH45I1hLatcx/AtaTw84+FCP+o1xQoOwBe/eTFi8uijQnnECw6U2RZEZ/lsTA3gFD2NZ00g
 TlusQEo8B52geetB/hF23wRakr9acjWCNZCFVJoV2DGpGB+rPX5eYwjHMVTv9/oRKBHz70v
 J0fuLHdacapL3kAaUGp3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HlJN+hDyr98=:DZz3AqeeGJFW6d8qPCin3C
 3B6QCoSnFAWKoD2dqHKyqHfSenZx3Z1jQDB4ROxIKbC75uw7s3/RNOAVLIAR21eVpv0VCrI1X
 RUG1FQN0SdbTu4pWLZ6GD7L/gwQSjl56jMxXosv8oML+it1FyrTvnnxGw9m6J7gIkK/FvA2c9
 0xlx+4526JIATbNdYeGdFCOafBX2BN7QmgKAZayNIepxCLozTkow8Vg121IkrF/9BMysu6i3i
 fukMHWwwmZac6b2QkQMIr/9YGIO39HLWGTFxR93k5RqdCITAM9ANj+Pplq481Zy3X1bMtgjNo
 a3C+8JV8NVv7Ot9045iU0r/T3rj+U1KtMf1/X006BpcXhkW/BitzESWi0wpYy7JJC5YAVVSXr
 VWtR40BMgfXF+Oz5zXX2b2JXWYj145iNGcExFffZ4/6IpuJFzJ/r0RWKa3ieiqt6T2oD/wbNh
 4NH2WBWL+OjUOfimX1zPXu3jX98kB3JX37nKp6bMBUvAvR7agQtZHTAZaibtiaiqRw9mJ/bqg
 EIH2fUgSzwOQ35ILSglOh187tcah9bf5ya54riqozoZnCBcc3pHhEtGC0wLqXmqBeXTr6WC8M
 KLHtiH0OMC+R7tOd4JGM2SimdDpULPnnr1gknyMf3TRXkMQ3gDuxdUm3v0WA8nYFhSLuiOueq
 1sF3Mjm6aemJGxtnN/fXZ/XdaNaW89K4YT+kxKZG9Oe/ysEJrsUb8Tf+7xPYs31sLKJ1oRcq8
 YizOTBHOuQc5owjfyaZt0Z4lf+XUOdWTrKiCB/Ql9O7Fbe6+AhQ+oaWPMOK3GNaGtOj8Pz7D 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289073>

On 2016-03-16 18.37, Kazutoshi Satoda wrote:
> "funcky" looks a typo.
>=20
>>>     Don't use funky file names, that can not be created under
>>>     HFS or NTFS.
>=20
> The file can be created on my Cygnus environment, which is under FONT=
S.
> So it looks a bit inaccurate.
>=20
> I think a quote from the actual error message may be useful. It will
> likely tell what was wrong, accurately. And also, someone may search =
for
> that message.
>=20
>>> -       neq=3D$(printf "\201\202") &&
>>> -       git config svn.pathnameencoding cp932 &&
>>> +       neq=3D$(printf "\303\244") &&
>>> +       git config svn.pathnameencoding ISO8859-1 &&
>=20
> The variable name "new" was for "NOT EQUAL TO" (0x8182 in cp932 =3D U=
+2260).
> http://unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP932.TXT
> Then it should be changed, too. A more abstract one may be appropriat=
e.
>=20
>>> -       inf=3D$(printf "\201\207") &&
>>> -       git config svn.pathnameencoding cp932 &&
>>> +       inf=3D$(printf "\303\226") &&
>>> +       git config svn.pathnameencoding ISO8859-1 &&
>=20
> Ditto. (0x8187 in cp932 =3D U+221E, INFINITY)
>=20

Agreed with all your comments, thanks for that.
A better version is here:
<https://github.com/tboegi/git/commit/7ea2fa1ffaeb1c05669a837d7fed9c60b=
8a0d3cb>


commit 7ea2fa1ffaeb1c05669a837d7fed9c60b8a0d3cb
Author: Torsten B=C3=B6gershausen <tboegi@web.de>
Date:   Thu Mar 17 06:08:14 2016 +0100

    t9115: Use prereq for funky file name

    Some file systems like HFS don't allow file names outside unicode.
    Add a precondition FS_CP932 and use it in t9115#11 and #12

diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh
b/t/t9115-git-svn-dcommit-funky-renames.sh
index 0990f8d..5a6525c 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -93,7 +93,7 @@ test_expect_success 'git svn rebase works inside a
fresh-cloned repository' '
 # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
 # > "Private use area") when creating or accessing files.
 prepare_a_utf8_locale
-test_expect_success UTF8 'svn.pathnameencoding=3Dcp932 new file on dco=
mmit' '
+test_expect_success UTF8,FS_CP932 'svn.pathnameencoding=3Dcp932 new fi=
le on
dcommit' '
 	LC_ALL=3D$a_utf8_locale &&
 	export LC_ALL &&
 	neq=3D$(printf "\201\202") &&
@@ -105,7 +105,7 @@ test_expect_success UTF8 'svn.pathnameencoding=3Dcp=
932 new
file on dcommit' '
 '

 # See the comment on the above test for setting of LC_ALL.
-test_expect_success 'svn.pathnameencoding=3Dcp932 rename on dcommit' '
+test_expect_success UTF8,FS_CP932 'svn.pathnameencoding=3Dcp932 rename=
 on dcommit' '
 	LC_ALL=3D$a_utf8_locale &&
 	export LC_ALL &&
 	inf=3D$(printf "\201\207") &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0b47eb6..7bb1262 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1037,6 +1037,18 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
 	esac
 '

+test_lazy_prereq FS_CP932 '
+	# check whether FS allows filenames from cp932
+	neq=3D$(printf "\201\202")
+	>"$neq" &&
+	case "$(echo *)" in
+	"neq")
+		true ;;
+	*)
+		false ;;
+	esac
+'
+
 test_lazy_prereq AUTOIDENT '
 	sane_unset GIT_AUTHOR_NAME &&
 	sane_unset GIT_AUTHOR_EMAIL &&
