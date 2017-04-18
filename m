Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025C21FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 11:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757021AbdDRL2r (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 07:28:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:55541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756350AbdDRL2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 07:28:44 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MH07e-1cnjzX0DCM-00DlGJ; Tue, 18
 Apr 2017 13:28:33 +0200
Date:   Tue, 18 Apr 2017 13:28:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/7] Makefile: optionally compile with both SHA1DC and
 SHA1_OPENSSL
In-Reply-To: <xmqq37du7n9p.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704181325390.8522@virtualbox>
References: <cover.1490397869.git.johannes.schindelin@gmx.de> <7a2444f08dea1b2fe497ae7498eba44626414d29.1490397869.git.johannes.schindelin@gmx.de> <xmqq37du7n9p.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R5pEvnHh508rndCryzJwYblZDAEWJZ/AgLKT32GFDsFssnXeLd9
 4WMnI6RJ65dS6JmocBCqZYb8SLQEnS1+a1iR2FfH7DxAnvWlaKduaktctsM8xMeGrZKnK4t
 WP9p3eezwYuNlAzIU9LZFgdFXxZUQVmh5xh3Dymrtub50MRsIl6/vgeDTPzHz9UUMCwWQu2
 7TJwuVaYxqdXoJu3jkYLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NqhD87sRpXI=:X7RYK59q9s50CCJzYScAdO
 XDqlT/TWLqe6NEpCYfGDXyUwZ9pN2GhTKa8EAFYawCjsrVuFhcOEWRj/JeW+5kW4oq6Hz9mKc
 iXUZ4xOvkVj3Y40YdF2KN/ruhc9oRYHMULfmrMsVO4IlK9/EKPO5I1t7NgNEfak2mF3Yt8Q2p
 CMxmc46pn2C2SUb/sp9KzbiTPeSulSAK/I6TQUdkk2CN1UfrC4dDgGtS0gvUnYQLrZ9pXVrxv
 Ism42QTwCAjCDckc92jbf+OD+dWn/8R3JhHLpf+Nj7YYUkJdC3IIJ+Vj12jp7MiGHLx6vhdVi
 IXUOST7qdEVwGcYXxlyGz2zkBCZnsF7UIdlyWJg9HqBMelG2swddR7rt69neb/+bsqNR5uP9R
 eCcq3puEePvmu6AC+hYFebmpjDHNKikUMVzm73CQWzOKfVykRMmiLoLQPpGeg0R5NCTLGke3S
 sk2bghpe6bKkkB2PSnTzdXQpWV+VETOvMT5Ps3Aj/1y1UbPCjW+rn4yodElpSISvuC5XAR9dH
 V68tbWDo1Bi8JXI3dJgeU4CU/dYfshkZBbfv3GnxyaR5OJYolwwCPJfvG2MLI31/bEq6pqL9Y
 suytJBYKRStTjj2ZD4zyZgkjFDWJXRdvF0i41NdExToksgYhZdpArtFB68ISwTNb41X0u0jCz
 jrCaYWkkttc7U3bC+SkeJRQp+Ja6/yDe757MxLc30nzS3oGRNe1nOTLHTl/zHrxwmZM/bEYzN
 f9SzWuwJHMz5ifFvSSvBUJTq4Vv3tCwNsuI61m+Qa0+9ZDBRe20ULCEbusioIgX+GHpTTDTHe
 e7wV0/I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 30 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +#ifdef SHA1_DC_AND_OPENSSL
> > +void (*SHA1_Init_func)(SHA_CTX_union *ctx) = (void *)SHA1DCInit;
> > +void (*SHA1_Update_func)(SHA_CTX_union *ctx, const void *pointer, size_t size) =
> > +	(void *)git_SHA1DCUpdate;
> > +int (*SHA1_Final_func)(unsigned char sha1[20], SHA_CTX_union *ctx) =
> > +	(void *)git_SHA1DCFinal;
> > +
> > +void toggle_sha1dc(int enable)
> > +{
> > +	if (enable) {
> > +		SHA1_Init_func = (void *)SHA1DCInit;
> > +		SHA1_Update_func = (void *)git_SHA1DCUpdate;
> > +		SHA1_Final_func = (void *)git_SHA1DCFinal;
> > +	} else {
> > +		SHA1_Init_func = (void *)SHA1_Init;
> > +		SHA1_Update_func = (void *)SHA1_Update;
> > +		SHA1_Final_func = (void *)SHA1_Final;
> > +	}
> > +}
> > +#endif
> 
> As I understand that this is a demonstration series, the approach
> above is OK as an expedite way to illustrate one way how run-time
> switching could be done.  The approach however is not very thread
> friendly, though.

Indeed. However, the toggle is meant to be coarse, heavy-handed. I have to
protect my time as Git for Windows maintainer, so I have to keep this as
simple to maintain as possible while also benefitting my users. This
toggle is intended to be run very, very early in the cmd_main() functions.
As in: right when the config is read.

> > diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
> > index bd8bd928fb3..243c2fe0b6b 100644
> > --- a/sha1dc/sha1.h
> > +++ b/sha1dc/sha1.h
> > @@ -110,10 +110,26 @@ void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
> >   */
> >  void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
> >  
> > +#ifdef SHA1_DC_AND_OPENSSL
> > +extern void toggle_sha1dc(int enable);
> > +
> > +typedef union {
> > +	SHA1_CTX dc;
> > +	SHA_CTX openssl;
> > +} SHA_CTX_union;
> 
> The use of union is a good ingredient for a solution.  I would have
> chosen to do this slightly differently if I were doing it.
> 
>         typedef struct {
>                 int safe;
>                 union {
>                         SHA1_CTX_SAFE safe;
>                         SHA1_CTX_FAST fast;
>                 } u;
>         } git_SHA_CTX;
> 
>         void git_SHA1_Init(git_SHA_CTX *ctx, int safe);
> 	void git_SHA1_Update(git_SHA_CTX *ctx, const void *, unsigned long);
> 	git_SHA1_Final(uchar [20], git_SHA_CTX *ctx);
> 
> where SHA1_CTX_FAST may be chosen from the Makefile just like we
> currently choose platform_SHA_CTX.  SHA1_CTX_SAFE could also be made
> configurable but it may be OK to hardcode it to refer to SHA1_CTX of
> DC's.
> 
> As you already know, I am assuming that each codepath pretty much
> knows if it needs safe or fast one (e.g. the one used in csum-file.c
> knows it does not have to), so each git_SHA_CTX is told which one to
> use when it gets initialized.

Thanks, at this stage it is pretty clear, though, that I will have to
maintain this. I am not willing to make this as configurable as you
suggested, as these patches will have to stay in git-for-windows/git.

Ciao,
Dscho
