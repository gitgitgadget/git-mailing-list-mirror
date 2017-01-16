Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775E520441
	for <e@80x24.org>; Mon, 16 Jan 2017 17:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdAPRHP (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 12:07:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:62630 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdAPRHL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 12:07:11 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx8OH-1cVNa807SL-016iqD; Mon, 16
 Jan 2017 18:06:37 +0100
Date:   Mon, 16 Jan 2017 18:06:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
In-Reply-To: <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701161746200.3469@virtualbox>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com> <257b4175-9879-7814-5d8d-02050792574d@kdbg.org> <alpine.DEB.2.20.1701161251100.3469@virtualbox> <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1g9uDsg+u2eBKhnn9Nrud01jEGFm0XEMCVBqOTnCiOfhkY4x9OC
 L6N6LN6d2kbufA85+X7pfAhdV5UJzm3e7wN8S9QoTzyUtVZ/dHUgQRgzoIY+FtAkf8FULs0
 WXiRuhHydEdc4X7y57yHMWVIFrRBQi7/nzUH7VOtPkECQ5RKeFmmWhu5jHVXAdYaymX9LLn
 iO2yX539zb0RuZSAqa8hQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:trfxza6YqZs=:/NRDNrS0gYPA4UpjZSRJRh
 yqIluvi2PIb8t1dK2dohP+Sax/Mokxpt/N7d6beCEUNU3in69neOLDkstdL298/v/UwrYz29G
 C4ZnEhIAMWebM2r93v+6Sb5Bi4/DT/iZOgpwI31NQ9Kh8osuLlr330ZU1wrSBeUk09k03qd/V
 M9Ns9daEQn6f3PuBt/8jqHlYYNz04ANyXbDQZWRBMg5Zb6qDdKW7FVZoreTPp3gGpS6wIyi18
 RC+XOSCdD1BSlZCNUXAOfKx9oSb64I/Enwd+hesLl5P53SwIioNtI8gJzoj/EyPDsc6WK5hxT
 mi15wH50/cKtewFa/t+Qtklsm94DC5Gm53tuW/Se7pCYC/viSJ6wdhQXtbEQrNDQJh6uVW24x
 2k5/2sGoRhPb8A2fnDu+SsAobYX5+19x3ZLRcclzCVre0D3y5seT94ErzStIQuuguSz5n3f2s
 f2qOXAwdL19Zmw+/CfGLj6kEVeqUAYiN+QkL1uN0/AvtB+mJxpnBKA6uRy+hNxe5bZFXFpOgr
 g3j5qD8Wzg28iJOvcSGXFk91M0Vqtb1969ToPf7qoSf2z1hD3db4dKUJKAMQb7vac095hyxks
 uq+yJ+MBgdunMKMArYLWsNGRZxb/u86+zV72rj0877EfcS0X+Q+vvlduWlpPEXfyRwH7+G2DQ
 JVJG/GviX8nHu78SrYvxVl+yLCBZ/gVzLcIvRH3Iqa54eTuDkf1s3GvxJv96OjfCieZYB7E8A
 BCltW6UlEUzc4akEzjZeuGXSLMGrbgkK3eJaPHhGutaEuGmmCTeFeSqSIYJ40YHCHyQ7zbTT8
 Q8m4C+t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 16 Jan 2017, Jeff King wrote:

> On Mon, Jan 16, 2017 at 01:52:39PM +0100, Johannes Schindelin wrote:
> 
> > > >  An error message with an ASCII control character like '\r' in it
> > > >  can alter the message to hide its early part, which is problematic
> > > >  when a remote side gives such an error message that the local side
> > > >  will relay with a "remote: " prefix.
> > > >
> > > >  Will merge to 'next'.
> > > 
> > > Please be not too hasty with advancing this topic to master. I could imagine
> > > that there is some unwanted fallout on systems where the end-of-line marker
> > > CRLF is common. Though, I haven't tested the topic myself, yet, nor do I
> > > expect regressions in *my* typical workflow.
> > 
> > Thank you for being so attentive.
> > 
> > This topic branch would indeed have caused problems. Worse: it would have
> > caused problems that are not covered by our test suite, as Git for
> > Windows' own utilities do not generate CR/LF line endings. So this
> > regression would have bit our users. Nasty.
> 
> Hmm.  I am not sure to what degree CRLFs are actually a problem here.
> Keep in mind these are error messages generated via error(), and so not
> processing arbitrary data. I can imagine that CRs might come from:

Please note the regression test I added. It uses rev-parse's --abbrev-ref
option which quotes the argument when erroring out. This argument then
gets munged.

So error() (or in this case, die()) *very much* processes arbitrary data.

I *know* that rev-parse --abbrev-ref is an artificial example, it is
highly unlikely that anybody will use

	git rev-parse --abbrev-ref "$(<call an external program here that
		generates CR/LF line endings>)"

However, there are plenty other cases in regular Git usage where arguments
are generated by external programs to which we have no business dictating a
specific line ending style.

If you absolutely insist, I will spend time to find a plausible example
and use that in the regression test. However, that would not really
improve anything, as the purpose of the regression test is simply to
demonstrate that a user-provided argument's CR/LF does not get munged
incorrectly. And the test I provided serves that purpose perfectly.

>   1. A parameter like a filename or revision name. If I ask for a
>      rev-parse of "foo\r\n", then it's probably useful to mention the
>      "\r" in the error message, rather than ignoring it (or converting
>      it to a line-feed).
> 
>      And I think that would apply to any input parameter we show via
>      error(), etc, if it is connected to a newline (ideally we would
>      show newlines as "?", too, but we cannot tell the difference
>      between ones from parameters, and ones that are part of the error
>      message).

I think it is doing users a really great disservice to munge up CR or LF
into question marks. I *guarantee* you that it confuses users. And not
because they are dumb, but because the code violates the Law of Least
Surprise.

> I am certainly open to loosening the sanitizing for CR to make things
> work seamlessly on Windows. But I am having trouble imagining a case
> that is actually negatively impacted.

Git accepts all kinds of arguments, not just file names. It is totally
legitimate, and you probably can show use cases of that yourself, to
generate those arguments by other programs.

These programs can generate CR/LF line endings.

While well-intentioned, your changes could make things even unreadable.
Certainly confusing.

> > -- snipsnap --
> > Subject: [PATCH] fixup! vreport: sanitize ASCII control chars
> 
> Given the subtlety here, I'd much rather have a patch on top.

Fine.

> > The original patch is incorrect, as it turns carriage returns into
> > question marks.
> > 
> > However, carriage returns should be left alone when preceding a line feed,
> > and simply turned into line feeds otherwise.
> 
> The question of whether to leave CRLFs alone is addressed above. But I
> do not understand why you'd want a lone CR to be converted to a line
> feed. Running:
> 
>   git rev-parse --abbrev-ref "$(printf "foo\r")"
> 
> with my patch gets you:
> 
>   fatal: ambiguous argument 'foo?': unknown revision or path not in the working tree.
> 
> But with yours:
> 
>   fatal: ambiguous argument 'foo
>   ': unknown revision or path not in the working tree.
> 
> Obviously the "?" thing is a lossy transformation,

s/lossy/confusing/

Probably not to you, because you came up with the transformation, but to
literally everybody else.

> but I do not see how a newline is any less confusing (but see below for
> some thoughts).

The more common bug report to be expected would show that multi-line
arguments are converted to ending in question marks. That is not the user
experience for which I am aiming.

> > To make the end result more readable, the logic is inverted so that the
> > common case (no substitution) is handled first.
> > 
> > While at it, let's lose the unnecessary curly braces.
> 
> Please don't. Obviously C treats the "if/else" as a single unit, but
> IMHO it's less error-prone to include the braces any time there are
> multiple visual lines. E.g., something like:
> 
>   while (foo)
> 	if (bar)
> 		one();
> 	else
> 		two();
> 	three();
> 
> is much easier to spot as wrong when you would require braces either
> way (and not relevant here, but I'd say that even an inner block with a
> comment deserves braces for the same reason).

There is no documentation about the preferred coding style.

For years, I saw patches, and provided patches myself, that *avoided*
curly braces when not necessary (in addition to aiming for shorter arms to
come before longer arms in conditionals).

Now all of a sudden Junio *and* you suggest unnecessary curly braces to be
added.

That is inconsistent at best, and confusing. Maybe you two gentle people
can make up your mind and document the final verdict, and for extra
brownie points automate the formatting so that patch reviews are not
dominated by coding style comments that would be better addressed by
machines than by humans.

> > We also add a regression test that verifies that carriage returns are
> > handled properly. And as we expect CR/LF to be handled properly also on
> > platforms other than Windows, this test case is not guarded by the MINGW
> > prerequisite.
> 
> I am not sure what "properly" means here. In your test:
> 
> > +# This test verifies that the error reporting functions handle CR correctly.
> > +# --abbrev-ref is simply used out of convenience, as it reports an error including
> > +# a user-specified argument.
> > +test_expect_success 'error messages treat CR/LF correctly' '
> > +	test_must_fail git rev-parse --abbrev-ref "$(printf "CR/LF\\r\\n")" 2>err &&
> > +	grep "^fatal: .*CR/LF$" err
> > +'
> 
> The "\n" is eaten by the shell, and git sees only "CR/LF\r". So we are
> not testing the CRLF case in vreportf() at all.

True. Should be easy to fix, starting from my patch.

> We do end up with "CR/LF\n" in vreportf(), which is presumably converted
> by fprintf() to "CR/LF\r\n" on Windows. And so perhaps that is why you
> are doing the "convert \r to \n" thing above.
> 
> But I still think it's not doing the right thing. Git _didn't_ see CRLF,
> it saw CR.

You know, I don't care. As long as carriage returns are either left alone
(which conflicts specifically with your stated goal) or at least are
handled gracefully when coming before line feeds.

Converting stray carriage returns to question marks is confusing, and of
course I would take the brunt of the bug reports, so I do not look
favorably on that change.

My patch was just a starter, to help with fixing the patch series before
it hits `next`.

Ciao,
Johannes
