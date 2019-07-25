Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266AE1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 09:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390282AbfGYJNT (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 05:13:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:56299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390276AbfGYJNT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 05:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564045990;
        bh=yRkPcW9CKJE3KIagaMoGzUUTXseC5vp0XmRuyFAt6m0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WG59yQ/MrryT2UknnPZP5CqgVwTMU6mTsNIhUGl+RtufDa0vNio2k+lk+PrITYYIx
         azWvgRozihPUAVA/lXOTmkMPov0juelkn+Lnj/rZQ3dLBUumbr61pkgdqcVCl5Par7
         YcCg2b8j3inXCJ+XnnWKloDEe8CoizLlHaJcswOE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCpb-1iRI0H0OD1-00bJuG; Thu, 25
 Jul 2019 11:13:10 +0200
Date:   Thu, 25 Jul 2019 11:13:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Beat Bolli <dev+git@drbeat.li>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH] grep: print the pcre2_jit_on value
In-Reply-To: <c85bcde8-2bef-3345-ec43-9ab44e587e39@drbeat.li>
Message-ID: <nycvar.QRO.7.76.6.1907251111140.21907@tvgsbejvaqbjf.bet>
References: <20190722181923.21572-1-dev+git@drbeat.li> <nycvar.QRO.7.76.6.1907232118460.21907@tvgsbejvaqbjf.bet> <c85bcde8-2bef-3345-ec43-9ab44e587e39@drbeat.li>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1795818162-1564045989=:21907"
X-Provags-ID: V03:K1:Sd9teL0HvR0kvruk2FtHaUWYiRJLU+vBVzeBp/03CVwrRQDlUzY
 73h15fZ4w5lOLpCU9uASiebeNfHzAMNGAemzkEDlni+TxIpdgk0kuBfid9vvZ7fchJg2BkY
 kSZoKvmpaIFu7mzHrtJQqFY8X4FClN0TZpOll/y3+C+BzQ2aGc01/D7o5tcmW3QU+8WNJEV
 j7/fGxnlkAUCgKkBSrJAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZuETkU0SjaU=:deR8T0L5glg67bBj4x2pAy
 iItLsOA4wE6+Xate8q2VVVLYkpUYbexSRJV160/oEHsvUPxuNBUK4oHgWd5HULJ4uvNCAmphb
 UvyV/zQbZEOu324k2Qbcah0i47C+lSqT89eLsMPWh9n13ExYFowkFtsKdN2ThRKtTc6zUAPip
 8Vxh+WL1ffldlPRGnwiS6H4ufw2k5EP/Ho2cWh6UR6aS7HlmptE28UzXo+O9AI2SmbFoVuV/H
 omFn4AZAhC32s/2gBEilCl18svNjR96YPOp+skHhlZlQcGUk6ohcxKtCeq7ewl5aF2B2Czp6Y
 fhEOVZgZWOBFy5X94ybuvqdm9fNB3/S4a4HE1sI0g3W/YBR+UFMI1iPzBZ1N6ASpHQ+mRjOjl
 wZsFoJTG5sh87xRNSM3XdcDt8ZUr6THwWOI19dtgkbwLhs+07SJP/gb/s7U9gIhMz0dodYRJ9
 dtzihSGUuTo0kcJmb14Y/TfhAEtT2uqEJlLWocdi4HRyK+fmMX+8r2nbHoSmRA2uPZWlGMBde
 B28Uf/yP4VTGtM/PuPn2Hus0ezMTAP0Td6Q0FvEShmcqncTWTXhMwia/ihRS+1LNpGM4BQoGC
 tLo1mVTrt13feEuiG+5DmcYMKH0M3NMlADgICd55BhtWoNFQ4xFOeAfakq0CzHVZ6T30DTOiP
 orKl6dRGjWNs3ErFmUZfmCLjwcyY7CoVwTYUL6/q0cFMvMyXG1KQ/A3spxA7++XX//PRKTw42
 hZYU2cRRNRQFJeTuxtB8Y3ce4LXszg1ulAJUY8nRfn0X15EwDp4iSp+ivq/VD2t7NvBYhwNE0
 U7DBWBWVj/l2JdwgkR7O33rrkGstDaMp6ShKW8fOGOzOlWFxNgr3bONcHSkzkXdvdLmhv+7vC
 ZtA4osR31BAcL9Rfk6AZTsNuy4T0XGwrkmxwdkPZYtc1dhbJU+Gk6fZtA2GC5p2GOLWgyfkfb
 agXeSuj0tFhKSJsREYjgdnUDjo1ioKnAiePveScXCutFXPevx8vhlCzfTSVnUAXpYpq/JyTLd
 pAWdZm2g9V0rc+SjRdBWzwzVXmBb2Ks8BmkBHgOdgMc3i2P1G96J8pfiYz1P0y9WyXn0nhhLb
 7s9JQdHH8qx/2wi1wlDruPqnKhrBk4DKAbC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1795818162-1564045989=:21907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Beat,

On Wed, 24 Jul 2019, Beat Bolli wrote:

> On 23.07.19 21:19, Johannes Schindelin wrote:
> >
> > On Mon, 22 Jul 2019, Beat Bolli wrote:
> >
> >> When pcre2_jit_on is neither 1 nor 0, the BUG() call printed the valu=
e
> >> of pcre1_jit_on.
> >>
> >> Print the value of pcre2_jit_on instead.
> >>
> >> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> >> ---
> >>  grep.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/grep.c b/grep.c
> >> index f7c3a5803e..cd952ef5d3 100644
> >> --- a/grep.c
> >> +++ b/grep.c
> >> @@ -559,7 +559,7 @@ static void compile_pcre2_pattern(struct grep_pat=
 *p, const struct grep_opt *opt
> >>  		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_=
stack);
> >>  	} else if (p->pcre2_jit_on !=3D 0) {
> >>  		BUG("The pcre2_jit_on variable should be 0 or 1, not %d",
> >> -		    p->pcre1_jit_on);
> >> +		    p->pcre2_jit_on);
> >
> > Seems obviously good.
> >
> > Maybe while you're in the vicinity, you can add that information to th=
e
> > `--debug` output?
>
> Do you mean something like this?

Yes!

> diff --git a/grep.c b/grep.c
> index cd952ef5d3..8a57ba998f 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -406,6 +406,8 @@ static void compile_pcre1_regexp(struct grep_pat *p,
> const struct grep_opt *opt)
>
>  #ifdef GIT_PCRE1_USE_JIT
>         pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
> +       if (opt->debug)
> +               fprintf(stderr, "pcre1_jit_on=3D%d\n", p->pcre1_jit_on);
>         if (p->pcre1_jit_on =3D=3D 1) {
>                 p->pcre1_jit_stack =3D pcre_jit_stack_alloc(1, 1024 * 10=
24);
>                 if (!p->pcre1_jit_stack)
> @@ -522,6 +524,8 @@ static void compile_pcre2_pattern(struct grep_pat
> *p, const struct grep_opt *opt
>         }
>
>         pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
> +       if (opt->debug)
> +               fprintf(stderr, "pcre2_jit_on=3D%d\n", p->pcre2_jit_on);
>         if (p->pcre2_jit_on =3D=3D 1) {
>                 jitret =3D pcre2_jit_compile(p->pcre2_pattern,
> PCRE2_JIT_COMPLETE);
>                 if (jitret)
>
> If so, I'll wait a bit until it's clear whether =C3=86var's series [1] o=
r my
> patch is going to be applied.

Sounds fair.

However, my reading of those patches is that they still keep support for
JIT'ed and non-JIT'ed PCRE2 invocations (preferring the former if
available, without any UI to change Git's behavior in that respect), so
I would be surprised if this patch wasn't applicable after =C3=86var's
patches.

Thanks,
Dscho

>
> If this is missing your intentions, I need more guidance ;-)
>
> [1] https://public-inbox.org/git/20190724151415.3698-1-avarab@gmail.com/
>
>
> >
> > Thanks,
> > Dscho
> >
> >>  	}
> >>  }
> >>
>
> Cheers,
> Beat
>

--8323328-1795818162-1564045989=:21907--
