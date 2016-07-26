Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA645203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 12:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbcGZMZb (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 08:25:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:49435 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbcGZMZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 08:25:29 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M0gww-1bB2le3OhS-00unNR; Tue, 26 Jul 2016 14:25:08
 +0200
Date:	Tue, 26 Jul 2016 14:24:59 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 02/16] Report bugs consistently
In-Reply-To: <xmqqlh0p2vmn.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607261421310.14111@virtualbox>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de> <72d1d530bb0e3c96d3affd6679cb7c26026d8321.1469187652.git.johannes.schindelin@gmx.de> <xmqqfuqx4cli.fsf@gitster.mtv.corp.google.com>
 <20160725221700.GB14131@sigill.intra.peff.net> <xmqqlh0p2vmn.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xgDmNuoNUkuxmxfvEefZBsGuHNhB8Q2dY8jpXKZK/62aGaVBL02
 75kSdjc5PwBlGa+ik5V8GPEl0QXW0J3SmGgWDYZzL9ENfYYvGhy/ljSV2TELgZ4Jm7qrOSf
 rdlUFVPCe4wqw/i9W46xy5GEbc+BCnatgcGmrxpchhx9djnmxKpgOaZmu8GBCfL/hFJXjUV
 Tw0+/OIybdv96ovwxNV6w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:iBpPdN1FuAY=:WX/mP5xVRoejNagPqxgZD6
 dRXSQGpGz/yHd4E2Xvb1mvwXsYgAtNoNaAuWlkEPc9Fvs/jObYFmKosar4hgxT/TYazOurumu
 C3QTZbLLbcLuifsIWMzTmx5wufHvejx6QezsDtUws/lyuqrNm9ql20thySVWlIrieMIHV67xI
 C2Ysi1HR4Sf2fqmCV8uQGKPrSdkVD+c04hf5wFaXk0mha/FtNz/JLWO3NQjAFzMkH9tjhQAnx
 Xj1JKT4F347bVY8wiD4KOEbKO9dLBg5QhNV1B0iw25phBsiUh5YwKMCV5DC67sAgAGIT4/sqI
 5TIXuZvIlkr+DEAlZhHNfaN8EWz1x52FtRG5FLfz+BLUNCM45BoTwCAa6gcJDbaueEzneMdgf
 +YuhNo3/alRwFR7g6/T8KxyEmIgGN3akttYd+nJXjXPnOFVLj6Wysdf8K8SrBlOEWb/fg6s9R
 A1bLTcDuOxgoGojAoXCc3ekJHp9vE0ICpnlQB8EkmQR22eFu3NBAQOIQc1wqezPmLz7BOg6L+
 tCguPpDw9Y5K/4xTO7KyGiODyOh6w64G/AdyOuIg99RVfjKkPqbPqpfwPJI2RT2NXWZEUcWq4
 0KotbK9f5WXVHoG/ZNYtIIOjJHQOEXro7xDOPw2bkVg3FmxhmhhrH+kuD+VvpSzM1y7V20O28
 Yw7qYVL4b2BNJsNWw+Y8lxxdgMMqo2UIzDWJyi/65uqBnYnbZbz7SviDgks35NeMQABa9L9bQ
 u+IDdtXwwkiBJHE0NuKcuNpUdMUTr6sF/QHYJuLeOgAB0Lu0sD4eSb9z82PGMc82miSo19DHl
 ny/sFIKCBvwm6tTkavUSkOCjHy2qGt0N4W854iaswVuFgdFd7Oy/5AwyczBV+2P07GGqMeodi
 U0IF7onJIR3BAy8HKjMmmolqDGTdPi1Ps2HvHsKMkKyXUC+QT7z/8uDmKKNssn6FQtJcn0T32
 4zSWZkHLXHvbWhAbN7HZu/uXRbyS1mkQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio & Peff,

On Mon, 25 Jul 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Jul 25, 2016 at 02:44:25PM -0700, Junio C Hamano wrote:
> >
> >> > diff --git a/imap-send.c b/imap-send.c
> >> > index db0fafe..67d67f8 100644
> >> > --- a/imap-send.c
> >> > +++ b/imap-send.c
> >> > @@ -506,12 +506,12 @@ static char *next_arg(char **s)
> >> >  
> >> >  static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
> >> >  {
> >> > -	int ret;
> >> > +	int ret = -1;
> >> >  	va_list va;
> >> >  
> >> >  	va_start(va, fmt);
> >> >  	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
> >> > -		die("Fatal: buffer too small. Please report a bug.");
> >> > +		die("BUG: buffer too small (%d < %d)", ret, blen);
> >> >  	va_end(va);
> >> >  	return ret;
> >> >  }
> >> 
> >> If "you gave me this size but you need at least this much" is truly
> >> worth reporting, then this is misleading (ret is shown as -1 but you
> >> do not even know how much is necessary).  In any case, this should
> >> be done as a separate step anyway.
> >
> > Hrm, isn't "ret" going to be the necessary size? According to the
> > standard, it should tell us how many bytes were needed, not "-1" (this
> > is the "your vsnprintf is broken" case handled by the strbuf code).
> 
> Yes.  If blen <= 0, we do not even do vsnprintf() and that is why
> Dscho added "int ret = -1" initialization; otherwise his new die()
> would end up referencing uninitialized ret.

Exactly. While I was fixing this bug message, it occurred to me that it
makes little sense to ask a user to report a bug when it is unknown how
small the buffer was and what would have been the desired buffer size. So
I did a fly-by fix.

However, it is true that this is completely outside the purpose of this
patch series (in fact, most of this patch is completely outside the
purpose, and I am regretting that dearly, as the patch series' submission
already takes almost a month, and I only now get people to review the
critical parts of the changes).

So I simply backed out the more verbose message and *only* do the obvious
thing: replace the "Fatal:" prefix by a "BUG:" one.

> > I do think the numbers are reversed, though. It should be "blen < ret".
> 
> That, too ;-)

True. All the better that I reverted that part of the patch ;-)

Ciao,
Dscho
