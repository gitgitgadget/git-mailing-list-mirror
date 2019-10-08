Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D00E61F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 07:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfJHHok (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 03:44:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:43149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730222AbfJHHoj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 03:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570520677;
        bh=RptoCJ47W+UOruxaGNjJd3k2k0RnylqmwifHjdfMFb8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dguZ8qj99WUhsgFgdFs2d7ShjDxijN49M9VhRJj4VSKUQe8wnKogBv1s60ud2EX46
         pI2uECVj9TgEnsM1bj6JAEny5ZqDPe++wnNgfqus1qJqBaFCYEQ5UQBMoeAYuitaZn
         Gt+P20Mbu725LLO5AEaXofcBTSdPi/xqDCy/6Y7k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsUp-1iJbRq0FjT-00HNJN; Tue, 08
 Oct 2019 09:44:37 +0200
Date:   Tue, 8 Oct 2019 09:44:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        git@vger.kernel.org, entwicklung@pengutronix.de
Subject: Re: Regression in v2.23
In-Reply-To: <20191007134831.GA74671@cat>
Message-ID: <nycvar.QRO.7.76.6.1910080932560.46@tvgsbejvaqbjf.bet>
References: <20191007110645.7eljju2h6g7ts7lf@pengutronix.de> <20191007134831.GA74671@cat>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Y1FWKpU/mUp0ZoMlqEncjoJQSM4uguTKxHkI0s0gaDoUEHNc12e
 jmSh2hBs7kN9HU1kdL7654uHLeCNs3yXMNAK3FLWo55miIETQRXjKLQbOD+5xd19289EcUs
 fmCZgGuEZf7qGqX1F+ieOrwTjVWf2UKge37FGm9YbuKyi5p+6pJU4SMnDEPFfTjP2asR7pE
 hhKnysVHa0jj/8b742Adg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yhglFWrN/54=:svHjMcqwPwd6uwGA9qbFlB
 RrBTpp51cztOzxSaLwoygKHInGsT//1oZc1kt1BHf8KiacJ19agl235m++fI3W/G/z2YOApUC
 qqy1V8Cz5frvd5APbxK60t7G30HN9is8Tafr1Ewn3fENN/OobGbqgbvFrK64zYE7Xa1WC3TQi
 nGZCX/MtV5i7VYkYzUA5cmauZ3DL7pW36fYqoWpQ9I3bv9q2e+de78kQVQsY2SaRv270d/Ofk
 VOEcYdTKKtyvz/zUtbMn6lpG1UDMcRF3xYb3dPSYE1ujHSymRgKBSQhQUMYKYPfdkOXeoO8QM
 8CnFkQqOUMgnpE9DpKKCsd82V4Vq4MXeSGerdSYT/UABXQ1nixfqu9bxuplt8bG9vNDlcJ8tN
 AwwPbUkEmlLjdp96JxaU5zgRZenBVdQseKytE7ReIkXVO7m2XtdN5gQ5IvlWfX8kD+W5DxIY/
 ay+4s5hPebJBOZO375C3Q7h5Waanry80+iVQyk8AcrNA4JVtVnXA+QhHz8i/zsT9FH8kaayDd
 iTEzkygYF30imbcD00AC4eUw1J2SYgJ0Xc33Pkrk5RAdisk9cARIzFDjANVr9KBSUSjlfVaPL
 eHWMRZSDfNo8F3sGY6bkuOmFY04SgiKFbT9YYaIiDzzH3GzKTyrWteRFjc3b5KcKKln1Bn2SH
 mgtG3Ff1XVMeDjjUVbZTr062t2gAiNIKcB17+TuY4rBDGJ8qGIXgVr3NLMQc3/nqdLlkphCox
 3l2NdqCsvLbpdufudzkAHr+0w4s79/7BMN6IvBzzgHSU7tgpT5UML+yXpNLHyItM8+JWBcHdQ
 BtpYVlBRcC4S9X6yMOXaGWmrDVaD3yIa++wXY1/hbUgPLh4R2t/BFgjQFCQeNzoClV/i/j4QW
 BZvK/OnxiMGapNoKZZQz9ki7oYhFgWcKPIHw6ggyX1XDsDrSvWSXcHFXLmCmLB4XopgXaLu3Z
 OBPlXhkk1oGqP7eidC5Wew852tc+aicu10F6z3DtKG31LZdE1hgQ71/5umetv4t6HrnmI64bg
 0hrrmDZ1N1jIQJfFT1A6QF2cCLVXMr3qZrwjmy6KVeqqu37MfXCj7H27skrkGnVQe2hcgqtOB
 eG+A+ESg+nxF+18hkncWDw8iHw01WNea5tmiiSXzCroGrcKzFczp2ddtiU9ewIp7h7XsY/5hj
 ZUrvtHAGwoJKFV1bsrUGo9FdsFJtVa5kDwpI0PIESXiED2+9pTminGNls9frqjD0xW5EZutEd
 MumsOfA4JwQCcqZAOvYed1HoNT+nHJFvE0872M2WGv1Hb38kAgV2ybJYbF58=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Mon, 7 Oct 2019, Thomas Gummerer wrote:

> Subject: [PATCH] range-diff: don't segfault with mode-only changes
>
> If we don't have a new file, deleted file or renamed file in a diff,
> we currently add 'patch.new_name' to the range-diff header.  This
> works well for files that are changed.  However if we have a pure mode
> change, 'patch.new_name' is NULL, and thus range-diff segfaults.
>
> We can however rely on 'patch.def_name' in that case, which is
> extracted from the 'diff --git' line and should be equal to
> 'patch.new_name'.  Use that instead to avoid the segfault.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  range-diff.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index ba1e9a4265..d8d906b3c6 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -116,20 +116,20 @@ static int read_patches(const char *range, struct =
string_list *list)
>  			if (len < 0)
>  				die(_("could not parse git header '%.*s'"), (int)len, line);
>  			strbuf_addstr(&buf, " ## ");
> -			if (patch.is_new > 0)
> +			free(current_filename);
> +			if (patch.is_new > 0) {
>  				strbuf_addf(&buf, "%s (new)", patch.new_name);
> -			else if (patch.is_delete > 0)
> +				current_filename =3D xstrdup(patch.new_name);
> +			} else if (patch.is_delete > 0) {
>  				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
> -			else if (patch.is_rename)
> -				strbuf_addf(&buf, "%s =3D> %s", patch.old_name, patch.new_name);
> -			else
> -				strbuf_addstr(&buf, patch.new_name);
> -
> -			free(current_filename);
> -			if (patch.is_delete > 0)
>  				current_filename =3D xstrdup(patch.old_name);
> -			else
> +			} else if (patch.is_rename) {
> +				strbuf_addf(&buf, "%s =3D> %s", patch.old_name, patch.new_name);
>  				current_filename =3D xstrdup(patch.new_name);
> +			} else {
> +				strbuf_addstr(&buf, patch.def_name);
> +				current_filename =3D xstrdup(patch.def_name);
> +			}
>
>  			if (patch.new_mode && patch.old_mode &&
>  			    patch.old_mode !=3D patch.new_mode)
> --

I am not quite sure that this fixes it... Here is my regression test case:

=2D- snipsnap --
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index ec548654ce1..6aca7f5a5b1 100755
=2D-- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -354,4 +354,18 @@ test_expect_success 'format-patch --range-diff as com=
mentary' '
 	grep "> 1: .* new message" 0001-*
 '

+test_expect_success 'range-diff and mode-only changes' '
+	git switch -c mode-only &&
+
+	test_commit mode-only &&
+
+	: pretend it is executable &&
+	git add --chmod=3D+x mode-only.t &&
+	chmod a+x mode-only.t &&
+	test_tick &&
+	git commit -m mode-only &&
+
+	git range-diff @^...
+'
+
 test_done


