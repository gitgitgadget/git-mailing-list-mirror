Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C522D1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 13:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfA3Npj (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 08:45:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:38829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfA3Npj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 08:45:39 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mc8Pz-1gYgk33v1z-00JaJ9; Wed, 30
 Jan 2019 14:45:29 +0100
Date:   Wed, 30 Jan 2019 14:45:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 07/13] HTML documentation is not provided
 with Apple's git. Make the error message more on point.
In-Reply-To: <xmqqsgxb5ard.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901301444220.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com>        <20190129193818.8645-8-jeremyhu@apple.com> <xmqqsgxb5ard.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JwiOzZj2OEkTjLIuZyjnTQz1anUJpXh+SLXEvjiZ8DgKl4CR6/i
 U94b6rMoce0IldRGIeqK4duKRGSpyk5yNaZ0nAt/rKSgC8bocvebRTlr/kvysO5iIky9yUs
 xKboRkOxLFXFGM2WLMEOMx25sIQ8xdXVN8VW/vEn6uY778MdGH7gCzhk1p7RR7MkW2raguJ
 MQZqpYh1w+ix88mKppZbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3btock3MMzA=:0hql8tB8lgz8Dm6tERMLeF
 ZxaSr1Ct3OHt6ZhmNL/bv31jbu4tB/9Tw9yYZWVFE9LaeTs9TNR7tDWeLX4y7NF52ez2UHaVh
 96yKAj/ExXCHu4v5NgkNrtHuseXdmJi1qZzgTOALgsUH6bTSBoqkMGRD/if6aWAori0dfl4x9
 cGMPtDfnX31zhQrLPXx+eONt2dFFGZCoOZRiintHg8OeATsFuqp0YYqvkKpXMngPKVhIBXENw
 RNnF0RBoSsiJuIO8qFpAQtgOc81N/23kktQaOfvYGDgO0Www0JqSV0JPxvN9JDxUE2Rz5Wh38
 ZLziIdoMwuhwcQP/EdG+b/C0UDf6X0PjrydrtoOtGwSgRXfqeuNzVvCJGfJxa57Ho7YquAgWw
 rLoNLEpKF28TX8Dn8W6PNsqFNqrqXzNdNKSTX+i9+G27h2701JiA11kINrdcBQEGzUYsY9GoR
 jb5O8Z1xsuA7LcyirrMHYeN3U4b2FCM6KdZhjYdilnFgI3hM89/C6e72Erq4/8eLruQvZM9uw
 JDz1VhBJUkcwzoqFsHbPPGnOJnGTJIP0qFuhrB4MeQhwNj3EtHE6xYYXTqHGo+dyQCF+brIbe
 149hM/HzPjMAT01qD/CrvD8FJ4LQmrAObufPYxgW7SUrCyr3D/5+mTQoG4UrdY19U6v496UZN
 kEFWg6jKjvYPakma8AAjlV3l/wWv8GPlSDY/rpZtt4Cl6OqwNbYzkZbFYUdC7kJCdwxDamZ/2
 HovQk+G0TxL4NLfXvVVwdY0L9EWdyog+IKH//w9hq22IZjrKoGvxfhV+lnY9BNtakX6547XVw
 xz4mV8u/cU/iSRwVYOjNKMi+HHUx/Dliu0EV/eX5ic+8cEhtplD2FRPl1SXcZpGzRgCfc+pD3
 zoLkSyyB/ShtmzvyrR4u3fk1EecpGhcz845xMFfmnDmskDTNxnUpwu0Z9+bqjJkDSBlL23P/6
 s8F0nLJYSDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 29 Jan 2019, Junio C Hamano wrote:

> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
> 
> > Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> > ---
> >  builtin/help.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/help.c b/builtin/help.c
> > index 7739a5c155..e001b6157c 100644
> > --- a/builtin/help.c
> > +++ b/builtin/help.c
> > @@ -383,7 +383,7 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
> >  	if (!strstr(html_path, "://")) {
> >  		if (stat(mkpath("%s/git.html", html_path), &st)
> >  		    || !S_ISREG(st.st_mode))
> > -			die("'%s': not a documentation directory.", html_path);
> > +			die("HTML documentation is not provided by this distribution of git.");
> 
> Mentioning HTML in the message may be a good idea, but I feel that
> "distribution of git" is not something we should say in the source
> for those who are building from the source.  Distributors are free
> to munge before they generate their binary distribution, of course
> ;-).

So maybe something like

#ifdef MISSING_HTML_MESSAGE
			die(_(MISSING_HTML_MESSAGE));
#else
			die("'%s': not a documentation directory.", html_path);
#endif

?

Ciao,
Johannes

> 
> >  	}
> >  
> >  	strbuf_init(page_path, 0);
> 
