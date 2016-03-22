From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 4/4] mingw: skip some tests in t9115 due to file name
 issues
Date: Tue, 22 Mar 2016 23:44:26 +0100
Message-ID: <56F1CACA.5040709@web.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
 <7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
 <56F18F5E.9090301@web.de> <xmqqbn66gs4k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:45:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiV2q-0001rb-1O
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbcCVWoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2016 18:44:54 -0400
Received: from mout.web.de ([212.227.17.12]:61500 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbcCVWox (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:44:53 -0400
Received: from macce.local ([87.146.133.242]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M3SxQ-1ZrUoI1IMi-00r1RF; Tue, 22 Mar 2016 23:44:30
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <xmqqbn66gs4k.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:hRx4OdCmbSlDJHNkMAKLh4X2JMFJ5l5ZEopOOzHqEOKE6Npb1N6
 IfeeLWM5N+y7XvT8/LLMsIc/kGn9hVbhlkKik4EUV6nDsdv2Tt1THCcEPZY0c0dDS4xQb5a
 a/KDYO7rLWTpRZ0+Hsdwxqs8gd6tKDXixXcJblBeDKga283IlyQQMZ95aOwNiq4NTSdW8IC
 UMQiOedMrT5YprWhAo6cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pWKtON2crDg=:Msu32wr5Uhw5WuZcWfg82F
 jCxmxnGp+OBKSyD4bOcj7+3iP0ZPPV0OAiRuRRaVa2GeSJSZveHc+YdXQn5iAikHceHL2ujUc
 gUXYtnBp997VFjTCL0MPgtwJfcvGlTJ1drEKhA5g7hBsZ6Cfk/fgDGHdNmIaR0wzJ/8lu9w9P
 RLIjyavT8AoMiOkRtomx2l+vN75RqldljAZ9PLTBXJyv6Fghzo6RYHJ29rhmNYysTVTzjsipq
 LrZQGlgaMNFAL7aiCS1KaU7XY5HeXKbmJs+1ofXDz2gNPpyC9KszAbaahGM5M/TWmulFYbFCT
 /prSVsd6VdOqQkDjEFS0L9pdIsvJzAENbalqdKJvhvwNWS2Ck5WkSTgwu3lFL8EEzjcCKY42n
 SvaFwjTzsrc/bWCgNT51Dna1Bqpe5SoLxBP/6BuD0LAH8+B17n0R9EMWnHQ/0rBjuwUuVRtlv
 AlKwib//dNLqBtFzxlB2yDd4bS7xpyzRoMJbh/7DAR/cnrAoKrXu4FWDsFTiyecj6OeS5NNo0
 iHUyPKfHjTTzvykcMfluGlMTeBaqFKCbQW5cPp1NgmJz7oqQMhMJ5D5uKyitF0+IM46hs50tF
 YN8w9N3lauzCIueIhEBPTdFlP4MYTKObSrsi9ajqHWM3pS9gWpbfBsKtLboP6vLU1aTNfOm6X
 1+zE+K8zLwDsN7IhgKAf+fcamInRQCB1xcDVS6imZRPplgP+ZWpyysoscBxbTmmeEQk9OB/Iq
 IWfaQDXVeDDxqG5DBoGrgyvOef32IjxeaZy7EDIBJ7i4Vgm0s7GjCtrhndpTH2e2PzF6gTDQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289584>

On 2016-03-22 21.44, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> On 2016-03-22 18.43, Johannes Schindelin wrote:
>>> These two tests wanted to write file names which are incompatible w=
ith
>>> Windows' file naming rules.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Is there a chance to squeeze in a precondition for HFS under Mac OS =
?
>=20
> So you want this squashed into it?
Yes, please.
>=20
>  t/t9115-git-svn-dcommit-funky-renames.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-s=
vn-dcommit-funky-renames.sh
> index 864395e..a87d3d3 100755
> --- a/t/t9115-git-svn-dcommit-funky-renames.sh
> +++ b/t/t9115-git-svn-dcommit-funky-renames.sh
> @@ -93,7 +93,7 @@ test_expect_success 'git svn rebase works inside a =
fresh-cloned repository' '
>  # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
>  # > "Private use area") when creating or accessing files.
>  prepare_a_utf8_locale
> -test_expect_success UTF8,!MINGW 'svn.pathnameencoding=3Dcp932 new fi=
le on dcommit' '
> +test_expect_success UTF8,!MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencodi=
ng=3Dcp932 new file on dcommit' '
>  	LC_ALL=3D$a_utf8_locale &&
>  	export LC_ALL &&
>  	neq=3D$(printf "\201\202") &&
> @@ -105,7 +105,7 @@ test_expect_success UTF8,!MINGW 'svn.pathnameenco=
ding=3Dcp932 new file on dcommit'
>  '
> =20
>  # See the comment on the above test for setting of LC_ALL.
> -test_expect_success !MINGW 'svn.pathnameencoding=3Dcp932 rename on d=
commit' '
> +test_expect_success !MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=3D=
cp932 rename on dcommit' '
>  	LC_ALL=3D$a_utf8_locale &&
>  	export LC_ALL &&
>  	inf=3D$(printf "\201\207") &&
