Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E01B2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 15:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760004AbcHEPjI (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 11:39:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:65234 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029AbcHEPjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 11:39:07 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M93Jp-1bOFVA2O7h-00CP9K; Fri, 05 Aug 2016 17:39:01
 +0200
Date:	Fri, 5 Aug 2016 17:38:46 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
In-Reply-To: <xmqqoa584eju.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608051736400.5786@virtualbox>
References: <cover.1470326812.git.johannes.schindelin@gmx.de> <57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de> <xmqqoa584eju.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1931477388-1470411541=:5786"
X-Provags-ID: V03:K0:gTUoxhXelA3mFNvMM06U1ShHaIwZsxfojoiRHtK4qXvazrKCaFE
 9cWmxqVOzPlZObrNHeesC7/WOS4NhCdk46km0yRM3ptgzlHpVv2291w8O1/yT+P729/2eFH
 yGE0hq+7r84X4XvYrQws5KKUto2mMOnTKawhm7cFfZ+2gqTGaJx2nPpTwT7rBgFNl+5Bx7O
 oMaMxlC1IUORZIye717QA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:i8/tiF2RPzM=:72EKZ6kEbLhQlr3hXO3GhA
 TfxxW7L5inATPNQvLgODQPLoRgcO3lV0QpjB7URGDig7dJbDqIruGwR4sfOOf82Uurt8MGKJR
 7SfZ9n8u1Ju+yiL9piynvSVTfQvAi2zrO6EuLcDnXBu6B3N5Q9z6oPGw3XvRnjKFphSC7MX30
 lRSvtGEH9UBeIbWL6EORrwt2HtYMhwXuZ9KN3nJlsok2Z88LScKpIQrU3cqOSbM8j8vldw9eO
 uIwdJbxQZSDBD0SXHyd3gtyr6DtFxRf09hU9+eLcET8xP3rfwcnZBcUZQbNkR/+XFRc/lOZyB
 pziYA1HoTZplJwdEwaXvuEpNkQWNshKEqA4WbbK00fCLjCpMF0KrLHFJvilN3yYxPvEfCY2hc
 BUnURC8JYlPiTnRvj+DRESD21AXWa8P2lD02DDCVvdhmOk//pPIkvxydpsdv1OX7a+my6w2tP
 MfVua60EruCKVyDRNnNjE2KJgHUsHhmH65g8v/lY5kTjAMbfaH16QOHvzM55znhLUsw2rVAD4
 mZfGKzpJE7OzjvoKdNXHXujDLXrcoyWwCRSrkc+WJX+6DZnG7og5p27QTynFDI64DPO75m5Lt
 fdg9HRG6qlnP7BUWtjL4ZHHK/1PNPCtWH80bR8kF17ANJ2P/p36jQI8C/6A9XsXCq176t9w5D
 cqMiym3LxMoRXAZpLVy0ocl2DmDfaoBHyrklPRna0NkcV7FLSw4UIbh+aYtGZHiIsTHGaeknP
 MA0clWPYHAEXBUSu4caX0wcJdtByLPdDAdJLxq5kMg8tQYmtgCoARWOw6D1SbLTpktGuOQNgO
 4e2413Z
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1931477388-1470411541=:5786
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Thu, 4 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>=20
> > With GCC 6, the strdup() function is declared with the "nonnull"
> > attribute, stating that it is not allowed to pass a NULL value as
> > parameter.
> >
> > In nedmalloc()'s reimplementation of strdup(), Postel's Law is heeded
> > and NULL parameters are handled gracefully. GCC 6 complains about that
> > now because it thinks that NULL cannot be passed to strdup() anyway.
> >
> > Let's just shut up GCC >=3D 6 in that case and go on with our lives.
> >
> > See https://gcc.gnu.org/gcc-6/porting_to.html for details.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  compat/nedmalloc/nedmalloc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.=
c
> > index 677d1b2..3f28c0b 100644
> > --- a/compat/nedmalloc/nedmalloc.c
> > +++ b/compat/nedmalloc/nedmalloc.c
> > @@ -956,6 +956,9 @@ void **nedpindependent_comalloc(nedpool *p, size_t =
elems, size_t *sizes, void **
> >  char *strdup(const char *s1)
> >  {
> >  =09char *s2 =3D 0;
> > +#if __GNUC__ >=3D 6
> > +#pragma GCC diagnostic ignored "-Wnonnull-compare"
> > +#endif
> >  =09if (s1) {
> >  =09=09size_t len =3D strlen(s1) + 1;
> >  =09=09s2 =3D malloc(len);
>=20
> Is it a common convention to place "#pragma GCC diagnostic"
> immediately before the statement you want to affect, and have the
> same pragma in effect until the end of the compilation unit?

Uh oh. This was a brain fart. I somehow confused the way pragmas work with
the way __attribute__s work. You are correct, of course, that the pragma
affects the entire remainder of the file, not just this statement.

Luckily, Ren=C3=A9 came up with a much more elegant solution, so that Git's
history does not have to shame me eternally.

Ciao,
Dscho
--8323329-1931477388-1470411541=:5786--
