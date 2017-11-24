Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C5B72036D
	for <e@80x24.org>; Fri, 24 Nov 2017 18:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbdKXS73 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 13:59:29 -0500
Received: from mout.web.de ([212.227.15.4]:63633 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752530AbdKXS73 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 13:59:29 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LyftH-1fFTty42nn-016Bhw; Fri, 24
 Nov 2017 19:59:26 +0100
Date:   Fri, 24 Nov 2017 19:59:05 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, ashishnegi33@gmail.com
Subject: Re: [PATCH 1/1] convert: tighten the safe autocrlf handling
Message-ID: <20171124185905.GA9736@tor.lan>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <20171124161407.30698-1-tboegi@web.de>
 <CAPig+cT7=yLUVpmtutmTep5NBbSRNOL17dsOuVvn_Scu7_+p_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cT7=yLUVpmtutmTep5NBbSRNOL17dsOuVvn_Scu7_+p_w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:7Rt4/+ci8gsV2RISeXfVrnxmtxX2D8wL5EGw4rF7Lo0g3GCSCip
 47R6NIL6otNpBnMR+6rCD01oTKs1MSgQ6G6pyanobtMhG69Q8AY28xpDWtk/NnpZB+Q8B/o
 MmQcsODl4a4TIq7Rrq2lq6KESwIw6kyJqsj9K8lATUiJG5WN1VwF2BXegF3unmBcGGHf7q+
 Cmq5yTXRYnKFlHr2FRTRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0eFSl11qNCY=:/aLwcnzV6frkbWNKJ/LKtK
 qQQKC1qOFXCCJxRLHyb9m9MwNsKGXtCztLDFfqCviogjROb/vGMvj7VO//+0m7K1wMYsQcLL8
 s0lFb5q8q8N+LBJWCBEzUso6WcEC3RRgj+fXG2+0qvlga7kCoB1MdQJjekp2df/xWt9q+3MSy
 AakrnRDpDnNfydjdmDz2YYNQ6m/9zDA6vN3C3PPTjvULcOzfBEz0JSYCHBes/VnPFMGqUym4Q
 caEI6QzGs7sBx1VX4K1fTtf3/f6rgpaSBhbJXEkofcrvqBKDmGyzEtFBZxOI1OATHuBNs2O2a
 PPXCI4X9En+zJoI1ozDqk/+ciSVXVQHvww8YI9eMHpFWc7iw070xCker/uv/mOpR77QkdG4wp
 Y8HOj2uGsnZfJWlitnTZrLWaZOwrLck9t8P0rKtw6RL+Ji/ILD2LgnpqvY5Kzi/v4kcKz4z8p
 dpJF9UOgFvwNzCrVgSfxhdGKMlpRGtKR934AeWnkz42R69eqUY2K80lfOZG3y9ePeha5gVk3l
 HtnS4ulY/uwAJ+b7oWLyD6p1LSUnqJt8aW6CpxHHAJP2v6CTcI18xUgrXa1SZpXZuA/0YgokD
 BzIMhl2qAzmA/duSxFq2P7u3Ewc/6SR1+uGzgHDKCFwNPiy7SovVgzS5/1MV+M30AQjelKXQp
 7+Be/afkIwcxj9lv2E2GRffC8G9lSypk+o1TwHifT5+v+iVU6A9PNZafzXsEvwDYTWOgiHwCu
 m8waNtCZ33aNmwrEscRth1uiKPlKuNxZJHZdgEu62ND6X9DjGdxYcASbeWm5oaleP48EJZSuy
 ARFq58pX2x9exFviqIIlVxRyHyZhH6Q1Sfwd5vmoDMnPH3PdEM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 24, 2017 at 12:24:48PM -0500, Eric Sunshine wrote:
> On Fri, Nov 24, 2017 at 11:14 AM,  <tboegi@web.de> wrote:
> > When a text file had been commited with CRLF and the file is commited
> > again, the CRLF are kept if .gitattributs has "text=auto".
> > This is done by analyzing the content of the blob stored in the index:
> > If a '\r' is found, Git assumes that the blob was commited with CRLF.
> >
> > The simple search for a '\r' does not always work as expected:
> > A file is encoded in UTF-16 with CRLF and commited. Git treats it as binary.
> > Now the content is converted into UTF-8. At the next commit Git treats the
> > file as text, the CRLF should be converted into LF, but isn't.
> >
> > Solution:
> > Replace has_cr_in_index() with has_crlf_in_index(). When no '\r' is found,
> > 0 is returned directly, this is the most common case.
> > If a '\r' is found, the content is analyzed more deeply.
> >
> > Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> > ---
> > diff --git a/convert.c b/convert.c
> > @@ -220,18 +220,27 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
> > -static int has_cr_in_index(const struct index_state *istate, const char *path)
> > +static int has_crlf_in_index(const struct index_state *istate, const char *path)
> >  {
> >         unsigned long sz;
> >         void *data;
> > -       int has_cr;
> > +       const char *crp;
> > +       int has_crlf = 0;
> >
> >         data = read_blob_data_from_index(istate, path, &sz);
> >         if (!data)
> >                 return 0;
> > -       has_cr = memchr(data, '\r', sz) != NULL;
> > +
> > +       crp = memchr(data, '\r', sz);
> > +       if (crp && (crp[1] == '\n')) {
> 
> If I understand correctly, this isn't a NUL-terminated string and it
> might be a binary blob, so if the lone CR in a file resides at the end
> of the file, won't this try looking for LF out-of-bounds? I would have
> expected the conditional to be:
> 
>     if (crp && crp - data + 1 < sz && crp[1] == '\n') {
> 
> or any equivalent variation.
> 

The read_blob_data_from_index() function should always append a '\0',
regardless if the blob is binary or not.
