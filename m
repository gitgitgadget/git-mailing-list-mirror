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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1701F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 07:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfJHHtl (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 03:49:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:37305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbfJHHtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 03:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570520977;
        bh=bOegkZxLOmzY6gnpJcBF48vmA0TG0ViRU3QkDxFNvTM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lM9OyyUjzap9lafcEmi8IjqLiTiu5Rbjx4FYvQxOEzayW+7Kl2SoourjvT6MQZILN
         zx4m3oc0unt/EUzcZSVUtXPbIMTZGB4mD/80oyNvw92OCiqWGk6i5rUPkywvnLAqaC
         zkADG98hwUlAoIsl15RHilzf8AxMwSBqKXOrfblY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhuK-1iMdnv2P7i-00DrTf; Tue, 08
 Oct 2019 09:49:37 +0200
Date:   Tue, 8 Oct 2019 09:49:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        git@vger.kernel.org, entwicklung@pengutronix.de
Subject: Re: Regression in v2.23
In-Reply-To: <nycvar.QRO.7.76.6.1910080932560.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1910080947070.46@tvgsbejvaqbjf.bet>
References: <20191007110645.7eljju2h6g7ts7lf@pengutronix.de> <20191007134831.GA74671@cat> <nycvar.QRO.7.76.6.1910080932560.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:i5thB0meLFdnxuHd5ZFnp9aMmSaGHHjQPrz4DcsbOfIyKgMX/xM
 bu0qz/uFT1qzJp0PQ9ha3KHLJrAaKeyUGI7Ni/wgiW1zXyzi8DJcpNm+xD6xWDyZpWPtr4+
 GYdLYjUsHXY+jeqBOFVBRyCN7VAnkB6m94sm8Xj4edLmHyYAJ04P6njr3AOLzDW4oTon2Z/
 IvoE1SHVIHh0tfYCizy8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P1PWlq6qH9Q=:k8MjxMkT7Xrk73U++eEYwF
 7KfK6/pJTo1XacNnBOKgYkzTcPcyT6ruoYkxCqd73U5Yzi2xhd9C8gKK+N9rdAXh+P5+5vSSN
 a2NaHBEinEslOD0RwrGOB3Nye/Q93J3u1SBmcfAbtCcGrCgU7i6FMfeyDyimPDHxA/5T9LLUP
 GHMH2jNJCFGy7q1Ki7G3vXzouslD0/toCJtce781Yho8FhwRCH4jG4HjRuH50QVCMq9lyGnoH
 A03EUhMxYfvnc8IiIUoRpr/HeFaMGbCmFoj/Va9WJOZ4nukfhyMDnRKevlQpGlQBkcA4wf4RS
 ts1HEkLKzkrrr19ej1qqYRFcuSYGgmmLzVHk/KZeKjrN5Hxg4eCcycl7+t+W1L/ix7ZH3ioNp
 IcXWfqH0QrVCPzr3QClKZIv0bd6P9n28Uq6j8eBuI9e1izezWyezcNTH8Zrv4WzezRjOhEVNC
 6hJSbJFWfWcD9OgvmbxV+yapuo2jcIP24JGKIwtmbN4TLkS+qiAjJ/guNhUKErp4ciI7LJwCO
 HrrymmuFriJ+LblqHLEPg67y9BAZdqOxj6F/SAlQCg/pObj5XhiVzsnheneyhxPueKezjhvAs
 6HdCrEpgSPqcOgoXOqW2k9VQzBFZrmhU+Cmj4XI0H78n+QVOqs9fX2MkWO3nLfEwu3L6L45BN
 Qq6mGZLlYKbTKwFVMBRC9d7wmV1vNXNkkJC0C6cL8yiDqrvHSPGjM38lAjKG2vzFiYnykMGow
 +AKTtTJrLXacA9l5GNJmQX1tj9cNHM4WZA1yZ0BCdaSvtZipSnsWXkvsR97mDIADwc2lTqot5
 7nWSP1tdYv79OidJ1yyDXza686UTFCxK6ZoBRiMNUvyq9glSzYt7riPmiKvpEiHttY6uSqmKR
 EccT7FqzospuqL1u3TAlE6gzzhMvcbhDIVf1iOir64tPueifZE3axECSchN++C1rpxbKzLkGC
 UZYu24a8R20BW5V0SvIHbX3JaApwdcj3aS9B5rTAFTrBhRyZlsrgQ0CsVPomHDAbcC2YGh5NH
 OMofogUTr56Ht6I9eTkjkNE/LmV+bS67KfYjcGBAy8o6xWOOfo7ZsAw6FWsD+3J16NL+dKK/5
 a/tOw++YEboUQyddSAc0ZKKcRQ0vWNauABYG7n/ROBP6rq+qLuKCSgltXsKzk79eq4o0WfvR/
 NYdcyH9ha8Laom0bAgslLAxmoiK4a+QHyv5ne3L4hZ103oqGFFHrta5dpI8nFNltZ+AWTt0p/
 bwVoP1p4NTO4/oML0avG9vcYZY4TD1chrYXwscJuRR77lYyFi8dIgUYPIj+Q=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Tue, 8 Oct 2019, Johannes Schindelin wrote:

> On Mon, 7 Oct 2019, Thomas Gummerer wrote:
>
> > Subject: [PATCH] range-diff: don't segfault with mode-only changes
> >
> > If we don't have a new file, deleted file or renamed file in a diff,
> > we currently add 'patch.new_name' to the range-diff header.  This
> > works well for files that are changed.  However if we have a pure mode
> > change, 'patch.new_name' is NULL, and thus range-diff segfaults.
> >
> > We can however rely on 'patch.def_name' in that case, which is
> > extracted from the 'diff --git' line and should be equal to
> > 'patch.new_name'.  Use that instead to avoid the segfault.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  range-diff.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/range-diff.c b/range-diff.c
> > index ba1e9a4265..d8d906b3c6 100644
> > --- a/range-diff.c
> > +++ b/range-diff.c
> > @@ -116,20 +116,20 @@ static int read_patches(const char *range, struc=
t string_list *list)
> >  			if (len < 0)
> >  				die(_("could not parse git header '%.*s'"), (int)len, line);
> >  			strbuf_addstr(&buf, " ## ");
> > -			if (patch.is_new > 0)
> > +			free(current_filename);
> > +			if (patch.is_new > 0) {
> >  				strbuf_addf(&buf, "%s (new)", patch.new_name);
> > -			else if (patch.is_delete > 0)
> > +				current_filename =3D xstrdup(patch.new_name);
> > +			} else if (patch.is_delete > 0) {
> >  				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
> > -			else if (patch.is_rename)
> > -				strbuf_addf(&buf, "%s =3D> %s", patch.old_name, patch.new_name);
> > -			else
> > -				strbuf_addstr(&buf, patch.new_name);
> > -
> > -			free(current_filename);
> > -			if (patch.is_delete > 0)
> >  				current_filename =3D xstrdup(patch.old_name);
> > -			else
> > +			} else if (patch.is_rename) {
> > +				strbuf_addf(&buf, "%s =3D> %s", patch.old_name, patch.new_name);
> >  				current_filename =3D xstrdup(patch.new_name);
> > +			} else {
> > +				strbuf_addstr(&buf, patch.def_name);
> > +				current_filename =3D xstrdup(patch.def_name);
> > +			}
> >
> >  			if (patch.new_mode && patch.old_mode &&
> >  			    patch.old_mode !=3D patch.new_mode)
> > --
>
> I am not quite sure that this fixes it...

Whoops. I should learn to distrust `git apply` claiming success when
running in `t/`. (I tried to apply your patch, but nothing was actually
applied before I ran `make`.)

So it totally fixes the issue (feel free to just pick up the regression
test case).

Having said that, I would agree with Junio that it'd be nicer to make
`parse_git_diff_header()` more useful to all of its callers, including
future ones.

Sorry for the misreport, and thanks for all the patch,
Dscho

> Here is my regression test case:
>
> -- snipsnap --
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index ec548654ce1..6aca7f5a5b1 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -354,4 +354,18 @@ test_expect_success 'format-patch --range-diff as c=
ommentary' '
>  	grep "> 1: .* new message" 0001-*
>  '
>
> +test_expect_success 'range-diff and mode-only changes' '
> +	git switch -c mode-only &&
> +
> +	test_commit mode-only &&
> +
> +	: pretend it is executable &&
> +	git add --chmod=3D+x mode-only.t &&
> +	chmod a+x mode-only.t &&
> +	test_tick &&
> +	git commit -m mode-only &&
> +
> +	git range-diff @^...
> +'
> +
>  test_done
>
>
>
