From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v6 43/44] builtin/apply: add a cli option for be_silent
Date: Fri, 10 Jun 2016 22:59:26 +0200
Message-ID: <575B2A2E.3000403@web.de>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
 <20160610201118.13813-44-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 22:59:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBTX1-0003D2-UI
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbcFJU7w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 16:59:52 -0400
Received: from mout.web.de ([212.227.15.4]:61301 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932296AbcFJU7v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:59:51 -0400
Received: from [192.168.178.36] ([79.237.61.24]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lxwjk-1bYlev0w0C-015KHW; Fri, 10 Jun 2016 22:59:29
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <20160610201118.13813-44-chriscool@tuxfamily.org>
X-Provags-ID: V03:K0:9sEV+/Dyr6ZPRyypdZoJ13ws3IzOASJaQnHJR6hrZ4638KJ4tTa
 DysThUwDVTuGvnwiyvZ5h3iYCvqjBpNJeZghGjJLzU2Xgza3u/I98IEC5VVLvw7+4PIW3jC
 Ph2DA+qrkIshMVdVSJUPWHj/Vaw8xLUM4lC+yY21BerF2xvLkeAQZDHFWgTeO6M14Wk7Mu0
 bVrzOz/f7f6ECB2q8GSJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ul8QynSqbvQ=:kCAevwHmdpyhCfBVX1T69O
 IOm5yqHRgZpIhYswBSfiikZwqpIUawke5f75ajamqi0+UVOXh74FKp+DADrCJMjvkPCEQV6jI
 M4UgBFsniYJDN6LhXQt0d0N6/GSsMZRs1YmU10RTOryyaXphNuwDWtD7r2FGt3sCiMPoUwgDV
 KIZjjI/Bdkh//G98gf7b+gC+ird4FtKeV2UrMkPd1FH23WU/f/C3M3rjP1fYGWOjX4KtCWma0
 DAg//5VUnhoeekdT6sRSYH0EfQH+YLj5nOZviR3C9+rV9W6dvIWsbWAiw0jVlErOWMDxYUrRv
 V7khcS0Icq9ZdYaPcUoyH355ZjvITQR53CizqcebV9lBWkYYVlWlkrY55jTQ9TaMD5K4WFrLU
 DWhfSqbQNtgsLLFvQs8FdF5Y4D69WFCQOO7QYnbYUQijB5HUxmACN/d19+nwGt4YYziurOQVW
 sbWC1N5LVMhkuoEyirlrskc4QsTrkYXtciKpT1hu6rAVm/lWZIPRlnMZ97B5qEWKsQHeIHRl+
 UPhBfaLH0Wy4WB37M+oh+kJe9mc5DvEUffY1Hi2mqLrwH3DZD46XY3pf6uVShWHPAOb6Ilq0+
 3t4OUsMwtVKSy3zRSVKXq9bmkb9UWbe8QnaMqfOHT5dGUsFc+PHOxIfQxiTtv8xQQOLaFPx8A
 nuWxESHzqnaBJl75atRUKqsnOyjuQaUm8R+VKLJL3aYgIlJBtlV+j2XcHvshaG2zpKcudYg8Z
 Ikt9ccAk5PzlW6mwkFYHkUX68t6tJHiLTIL2QDcVPd1jm6ItoVXevUT0bCRwe1NE6LPJoo29 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297074>

Am 10.06.2016 um 22:11 schrieb Christian Couder:
> Let's make it possible to request a silent operation on the
> command line.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>   builtin/apply.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index ddd61de..93744f8 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -74,6 +74,8 @@ int cmd_apply(int argc, const char **argv, const ch=
ar *prefix)
>   		OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
>   			N_("allow overlapping hunks")),
>   		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
> +		OPT_BOOL(0, "silent", &state.be_silent,
> +			N_("do not print any output")),
>   		OPT_BIT(0, "inaccurate-eof", &options,
>   			N_("tolerate incorrectly detected missing new-line at the end of=
 file"),
>   			APPLY_OPT_INACCURATE_EOF),

Why not -q/--quiet as for most other commands?

=46urthermore, you could use OPT__VERBOSITY, which causes -v and -q to=20
update the same variable variable and thus lets parseopt handle their=20
interaction.  Perhaps verbosity =3D=3D 1 could mean verbose, 0 normal, =
-1 no=20
infos, -2 no warnings and -3 no errors?

And if you add the ability to silence the apply functions before using=20
them you don't have to export and unexport dup_devnull().

Ren=E9
