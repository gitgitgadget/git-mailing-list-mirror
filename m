Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E5D1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbfA3TfG (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:35:06 -0500
Received: from mout.gmx.net ([212.227.15.19]:40907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfA3TfG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:35:06 -0500
Received: from MININT-6BKU6QN ([62.119.166.9]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYfre-1gcA2v2hms-00VQVu; Wed, 30
 Jan 2019 20:34:56 +0100
Date:   Wed, 30 Jan 2019 20:34:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 07/13] HTML documentation is not provided
 with Apple's git. Make the error message more on point.
In-Reply-To: <xmqqtvhq3x9i.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901302034120.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-8-jeremyhu@apple.com> <xmqqsgxb5ard.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1901301444220.41@tvgsbejvaqbjf.bet> <xmqqtvhq3x9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6R8B9bVb8MquymuU88t7+1JwLLm6cSYPNx3yged9Wh95hn4QNKD
 hHiHqTJepAFpkplKj/808lC43e3nCTg+VbdNviGsDq3YVw/SQhgokBsREW4A+iULf4YNQ0J
 U6WGNRuavwyvAii19lEKuRPpO6ICiirzLz7MT+2yRycS2O6lcgCAL/wnO6Y9fyDjok6hTLF
 a0GSkZQKsvwMimRglYB3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:laTSrbgJiZ4=:WxhhDFLPqu9Dlh9coQHBzI
 wV/uSVl8HceZSJhHE6roXqFgHL1voy2Ynvsx1NXqvXRfujLzwn0VcEaGn1rX2ua9iqZvKQtlM
 OImJnvHxjT2FJ2AzBmSa3c5/Ifw9x+fZgnitUm5xOxIuAYVzJb6/o7N7rutu8aMru2YnwHoKU
 u0NkntwPMcl1kZliQ3rN7bYiEORY0SD/U+i7CZ25PQiMZ5+z5zA1n6s9TZVZ/55Msp1pnXFHd
 WUfHGyKC3Bf8qcEuZq0YTgiY32vz5wNId/YJuW48S4juv9tg/rfS5uZfFncBxGFNhu9dZIDlV
 Bmd2ss2D3kCU0dJdwKqWvp9C7jitfMeCoU6x2L1YeegNN4z3QWVtI15XEY2xNrTpiSoCTG69j
 Nlkat/TSr0eUiWapfaQ85YMkpiUM+ZuJC3fGlnqWVvF+DjLAKSqrhNeJWaDCivtX0QRoUGvkm
 Nu1TcBov/saULThkOhBmj1aOG0Fk7xSmDCL67dC9CHtykWQtxwBNFfrX09/3WbooFe2+RmgFH
 zZdA1yX6atBfZZlCeOdfvPF1hxH/1yZcEcZDTwzP38FRtJhhJbt+AoQBEPjMX6d1Qy3nx0Hy4
 6ux6XxDPUyhlaQ9PUInKbkZ7ck9DuuVRjoEnw6ziJGVq6rJUyw2/I4YbCx2KlZpQ7HRIyoIpS
 1e/+Ladxr4vKgHcs++HEB0f08L78qFxOUVLiQ5qOvRl5Auvljq8754DTsvtBV1wtUq75uKkMc
 F5oMuFkWkKH6UkWkXmKn35ROCb6Yc8kRA2iG6RMnffiQH7IMy7tRaqhxY755RUxWt9DaDDxb4
 h5QqPrTzvIWeIp5s9N1e3zilB1UKNrICiUKaqh+dSxONGVR6MNNzPBv1g8autEzDKQcYipDQs
 bwZ7GRHyXp9FhPigXT8lwp+7i9KqCvMOVx9ApMkN/ayTtEIUcqCRYzij5CKLwukJ8Yi8jbTZy
 RlOoaJKAP8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 30 Jan 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 29 Jan 2019, Junio C Hamano wrote:
> >
> >> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
> >> 
> >> > Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> >> > ---
> >> >  builtin/help.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/builtin/help.c b/builtin/help.c
> >> > index 7739a5c155..e001b6157c 100644
> >> > --- a/builtin/help.c
> >> > +++ b/builtin/help.c
> >> > @@ -383,7 +383,7 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
> >> >  	if (!strstr(html_path, "://")) {
> >> >  		if (stat(mkpath("%s/git.html", html_path), &st)
> >> >  		    || !S_ISREG(st.st_mode))
> >> > -			die("'%s': not a documentation directory.", html_path);
> >> > +			die("HTML documentation is not provided by this distribution of git.");
> >> 
> >> Mentioning HTML in the message may be a good idea, but I feel that
> >> "distribution of git" is not something we should say in the source
> >> for those who are building from the source.  Distributors are free
> >> to munge before they generate their binary distribution, of course
> >> ;-).
> >
> > So maybe something like
> >
> > #ifdef MISSING_HTML_MESSAGE
> > 			die(_(MISSING_HTML_MESSAGE));
> > #else
> > 			die("'%s': not a documentation directory.", html_path);
> > #endif
> >
> > ?
> 
> No, distributors can fork and build from patched source.  What I
> meant was along these lines:
> 
>     die(_("HTML documentation not installed in '%s'."), html_path));
>     die(_("The installer chose to omit HTML docs from '%s''.", html_path));

Thanks for the clarification. I think your rationale makes a total lot of
sense.

Thank you,
Dscho
