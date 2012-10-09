From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 8/8] Support "**" wildcard in .gitignore and .gitattributes
Date: Tue, 09 Oct 2012 09:57:51 +0200
Message-ID: <5073D8FF.8080503@alum.mit.edu>
References: <1349752147-13314-1-git-send-email-pclouds@gmail.com> <1349752147-13314-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 09:58:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLUha-0007bT-1U
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 09:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab2JIH54 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2012 03:57:56 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:49006 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751487Ab2JIH5y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2012 03:57:54 -0400
X-AuditID: 1207440f-b7fde6d00000095c-13-5073d9022e8c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A5.32.02396.209D3705; Tue,  9 Oct 2012 03:57:54 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q997vq6U021212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 Oct 2012 03:57:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <1349752147-13314-9-git-send-email-pclouds@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqMt0szjA4EA/l0XXlW4mi+4pbxkd
	mDx2zrrL7vF5k1wAUxS3TVJiSVlwZnqevl0Cd0Z7N1/BXLOK62/eszcwHtHqYuTkkBAwkVj4
	cTEjhC0mceHeerYuRi4OIYHLjBITfnxlhnCOMUlsOLWVBaSKV0Bb4szaVjCbRUBVovf2V7Bu
	NgFdiUU9zUwgtqhAiMSMy5OZIeoFJU7OfAJWLyLgIfFj52bWLkYODmYBcYn+f2BhYQF/ifOb
	t7KB2EIC5RKH3u1iB7E5BZwk5l06wQxRri6xfp4QSJhZQF6ieets5gmMArOQLJiFUDULSdUC
	RuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCEhyr+DsWu9zCFGAQ5GJR7e
	V8HFAUKsiWXFlbmHGCU5mJREeaVvAIX4kvJTKjMSizPii0pzUosPMUpwMCuJ8F5PBMrxpiRW
	VqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR4Z4AMFSxKTU+tSMvMKUFIM3Fw
	ggznkhIpTs1LSS1KLC3JiAfFaHwxMEpBUjxAezNB2nmLCxJzgaIQracYjTk+Ns57yMgx98XC
	h4xCLHn5ealS4rxTQUoFQEozSvPgFsGS0ytGcaC/hXnrQKp4gIkNbt4roFVMQKvuWxWCrCpJ
	REhJNTC2pS195BRcslH17ZeK5ec0A/6ePB62U3ITA6uD3wamBRdsFuz8d4iL/ZLXqjMpJY67
	Dl1V4jKXV5RrY7p34dJSHV6pwBvip5N0Z7QvyjvJ119gd2f/jsc1pkZhr7hihC+/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207308>

I like how this series is going and it's going to be a nice new feature=
=2E
 Some comments...

It would be helpful if you would use

    --subject-prefix=3D'PATCH v3'

etc. to help spectators keep track of the different versions of your
patch series.

On 10/09/2012 05:09 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/gitignore.txt        | 19 +++++++++++++++++++
>  attr.c                             |  4 +++-
>  dir.c                              |  4 +++-
>  t/t0003-attributes.sh              | 38 ++++++++++++++++++++++++++++=
++++++++++
>  t/t3001-ls-files-others-exclude.sh | 19 +++++++++++++++++++
>  5 files changed, 82 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.tx=
t
> index 96639e0..5a9c9f7 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -104,6 +104,25 @@ PATTERN FORMAT
>     For example, "/{asterisk}.c" matches "cat-file.c" but not
>     "mozilla-sha1/sha1.c".
> =20
> +Two consecutive asterisks ("`**`") in patterns matched against
> +full pathname may have special meaning:
> +
> + - A leading "`**`" followed by a slash means match in all
> +   directories. For example, "`**/foo`" matches file or directory
> +   "`foo`" anywhere, the same as pattern "`foo`". "**/foo/bar"
> +   matches file or directory "`bar`" anywhere that is directly
> +   under directory "`foo`".
> +
> + - A trailing "/**" matches everything inside. For example,
> +   "abc/**" is equivalent to "`/abc/`".

It seems odd that you add a leading slash in this example.  I assume
that is because of the rule that a pattern containing a slash is
considered anchored at the current directory.  But I find it confusing
because the addition of the leading slash is not part of the rule you
are trying to illustrate here, and is therefore a distraction.  I
suggest that you write either

- A trailing "/**" matches everything inside. For example,
  "/abc/**" is equivalent to "`/abc/`".

or

- A trailing "/**" matches everything inside. For example,
  "abc/**" is equivalent to "`abc/`" (which is also equivalent
  to "`/abc/`").

> +
> + - A slash followed by two consecutive asterisks then a slash
> +   matches zero or more directories. For example, "`a/**/b`"
> +   matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
> +
> + - Consecutive asterisks otherwise are treated like normal
> +   asterisk wildcards.
> +

I don't like the last rule.  (1) This construct is superfluous; why
wouldn't the user just use a single asterisk?  (2) Allowing this
construct means that it could appear in .gitignore files, creating
unnecessary confusion: extrapolating from the other meanings of "**"
users would expect that it would somehow match slashes.  (3) It is
conceivable (though admittedly unlikely) that we might want to assign a
distinct meaning to this construct in the future, and accepting it now
as a different way to spell "*" would prevent such a change.

Perhaps this rule was intended for backwards compatibility?

I think it would be preferable to say that other uses of consecutive
asterisks are undefined, and probably make them trigger a warning.

>  NOTES
>  -----
> =20
> diff --git a/attr.c b/attr.c
> index 887a9ae..e85e5ed 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -12,6 +12,7 @@
>  #include "exec_cmd.h"
>  #include "attr.h"
>  #include "dir.h"
> +#include "wildmatch.h"
> =20
>  const char git_attr__true[] =3D "(builtin)true";
>  const char git_attr__false[] =3D "\0(builtin)false";
> @@ -666,7 +667,8 @@ static int path_matches(const char *pathname, int=
 pathlen,
>  		return 0;
>  	if (baselen !=3D 0)
>  		baselen++;
> -	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) =3D=
=3D 0;
> +	return wildmatch(pattern, pathname + baselen,
> +			 ignore_case ? FNM_CASEFOLD : 0);
>  }
> =20
>  static int macroexpand_one(int attr_nr, int rem);
> diff --git a/dir.c b/dir.c
> index 4868339..dc721c0 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -8,6 +8,7 @@
>  #include "cache.h"
>  #include "dir.h"
>  #include "refs.h"
> +#include "wildmatch.h"
> =20
>  struct path_simplify {
>  	int len;
> @@ -575,7 +576,8 @@ int excluded_from_list(const char *pathname,
>  			namelen -=3D prefix;
>  		}
> =20
> -		if (!namelen || !fnmatch_icase(exclude, name, FNM_PATHNAME))
> +		if (!namelen ||
> +		    wildmatch(exclude, name, ignore_case ? FNM_CASEFOLD : 0))
>  			return to_exclude;
>  	}
>  	return -1; /* undecided */
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index febc45c..67a5694 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -232,4 +232,42 @@ test_expect_success 'bare repository: test info/=
attributes' '
>  	attr_check subdir/a/i unspecified
>  '
> =20
> +test_expect_success '"**" test' '
> +	cd .. &&
> +	echo "**/f foo=3Dbar" >.gitattributes &&
> +	cat <<\EOF >expect &&
> +f: foo: bar
> +a/f: foo: bar
> +a/b/f: foo: bar
> +a/b/c/f: foo: bar
> +EOF
> +	git check-attr foo -- "f" >actual 2>err &&
> +	git check-attr foo -- "a/f" >>actual 2>>err &&
> +	git check-attr foo -- "a/b/f" >>actual 2>>err &&
> +	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
> +	test_cmp expect actual &&
> +	test_line_count =3D 0 err
> +'
> +
> +test_expect_success '"**" with no slashes test' '
> +	echo "a**f foo=3Dbar" >.gitattributes &&
> +	git check-attr foo -- "f" >actual &&
> +	cat <<\EOF >expect &&
> +f: foo: unspecified
> +af: foo: bar
> +axf: foo: bar
> +a/f: foo: unspecified
> +a/b/f: foo: unspecified
> +a/b/c/f: foo: unspecified
> +EOF
> +	git check-attr foo -- "f" >actual 2>err &&
> +	git check-attr foo -- "af" >>actual 2>err &&
> +	git check-attr foo -- "axf" >>actual 2>err &&
> +	git check-attr foo -- "a/f" >>actual 2>>err &&
> +	git check-attr foo -- "a/b/f" >>actual 2>>err &&
> +	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
> +	test_cmp expect actual &&
> +	test_line_count =3D 0 err
> +'
> +
>  test_done
> diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-ot=
hers-exclude.sh
> index c8fe978..278315d 100755
> --- a/t/t3001-ls-files-others-exclude.sh
> +++ b/t/t3001-ls-files-others-exclude.sh
> @@ -214,4 +214,23 @@ test_expect_success 'subdirectory ignore (l1)' '
>  	test_cmp expect actual
>  '
> =20
> +
> +test_expect_success 'ls-files with "**" patterns' '
> +	cat <<\EOF >expect &&
> +a.1
> +one/a.1
> +one/two/a.1
> +three/a.1
> +EOF
> +	git ls-files -o -i --exclude "**/a.1" >actual
> +	test_cmp expect actual
> +'
> +
> +
> +test_expect_success 'ls-files with "**" patterns and no slashes' '
> +	: >expect &&
> +	git ls-files -o -i --exclude "one**a.1" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
>=20

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
