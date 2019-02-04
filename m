Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 443471F453
	for <e@80x24.org>; Mon,  4 Feb 2019 12:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfBDMSC (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 07:18:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:36901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbfBDMSC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 07:18:02 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYg42-1ge2Ff3Xne-00VQpm; Mon, 04
 Feb 2019 13:17:37 +0100
Date:   Mon, 4 Feb 2019 13:17:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     William Hubbs <williamh@gentoo.org>, git@vger.kernel.org,
        chutzpah@gentoo.org
Subject: Re: [PATCH v3 1/1] config: allow giving separate author and committer
 idents
In-Reply-To: <xmqqfttb599s.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902041314160.41@tvgsbejvaqbjf.bet>
References: <20190129230806.5295-1-williamh@gentoo.org>        <20190129230806.5295-2-williamh@gentoo.org> <xmqqfttb599s.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OjSHuuIXS2dA5l8smQF4GJScL55z67JSLqGaPlFVDxLFacxkLCT
 oKJ01c0L4KB0ia7C3xI2+N0lkGVsqiikf2Axu87JTbGuFwzq7TYRmH3+h1WI7927KR0wcDg
 bPucuQrSpiTkW6FUCUhMVANWSz1Ok/7/EszJeX8lbw4gh5T8/Y1U4nYeX4N4xfZi26wErtq
 su2/XuUyn1RyqZGZU4oWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cHyXbuwGd7E=:JIEEAUQ8C8s+nVEl0uT+a9
 VNAmUTeXsdXVOQM9CG8lOl18doY2nivI90q9DvT94ChGP+fp2G6LBkoqrmPtkoKI2mzn8EBBu
 Qg7gNlN07WyTXvbXibcUY4YGjlXdDvfCQxpQgmr4XN8MPV4W8cctgsM482SBB/rshn49r5mNq
 kyA3IRV2thHljYKV+DZRu5o8aQ/ESsuOGLrWsei1F76jJYgaUwqtbcknnB3MFZEPyif7p0uI2
 0Xy8rovZv9le/fJ0LzJnJJ1sU2uYgiqvGyNYmSxDcvLqu7ZWKoGTnf5yhcAt3mEk6w1+XA15B
 n0xLN0GqO0gJQc1UQcHHDvRm2KgGh1Yu0Ba66n7ppTLid3+qU5c5fiFRSprHno2NxNI7Jubc8
 zI+vmLDZQdyicSRkEVuJPhT1zdNuFC6ZEtKxnXVkWvu2/mG1aum/WsfbjhlQoc/wQMIdlOtxe
 v1rZl4liEw/V24tT1f26InLxNTJ6YRNjik56DMI1R+weDvhEU5iiiKR1+nhnNnZP4Lj7YCP8/
 SpNtTnMjW1xvHGuaCD5aKKacDfpyW0y/b2NawwU0AJsj1dSorJ305QUZwKyGT71y3QBTcs5Dw
 b9AIvQoVAMuCo7DaO2gPuCk1ixCAJsrdBCCXMUNP9UFzZBekBH1e36plsUIYaHbiAnXKkYywW
 DxJpnd3anwLq7cqhlxkqrWalo8sUk0kQ9XDu5ul9rDvVEL7quGMPui3RWDcpOFjjH+tW0IGmA
 9EnXAJhEnsxP3aHlpLhWvHsgklfvzxahkwlSO9nM27Yf2tN4pPOQPYUSjzbihC9228YQ+IbyF
 t/Wb4B8zAU3JuDwyIJlPE42DIYEl3OIP+oJ7ExX8zC/yyQWus2LcVECX+idT773eYTlD+ybt1
 H7NE2h6jlJUpym8XevIj5UwbQUNoiR3Ar0K95vEJvUpdLjbyPvjREVHR4cm5N5BeTsxt+a+wA
 BZmI9k+l2BQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 29 Jan 2019, Junio C Hamano wrote:

> William Hubbs <williamh@gentoo.org> writes:
> 
> > diff --git a/cache.h b/cache.h
> > index 009e8b3b15..375be1f68b 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1494,10 +1494,19 @@ int date_overflows(timestamp_t date);
> >  #define IDENT_STRICT	       1
> >  #define IDENT_NO_DATE	       2
> >  #define IDENT_NO_NAME	       4
> > +
> > +enum want_ident {
> > +	WANT_BLANK_IDENT,
> > +	WANT_AUTHOR_IDENT,
> > +	WANT_COMMITTER_IDENT,
> 
> I do not recall we crossed the bridge to allow trailing comma here
> at the end of enum definition.

In advice.c:

	enum color_advice {
		ADVICE_COLOR_RESET = 0,
		ADVICE_COLOR_HINT = 1,
	};

In builtin/pack-objects.c:

	enum missing_action {
		MA_ERROR = 0,      /* fail if any missing objects are encountered */
		MA_ALLOW_ANY,      /* silently allow ALL missing objects */
		MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
	};

In builtin/rev-list.c:

	enum missing_action {
		MA_ERROR = 0,    /* fail if any missing objects are encountered */
		MA_ALLOW_ANY,    /* silently allow ALL missing objects */
		MA_PRINT,        /* print ALL missing objects in special section */
		MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
	};

... and I will stop here. You are correct that the majority of our enums
does not let its last item end in a comma. But we did cross that bridge.

Ciao,
Dscho

