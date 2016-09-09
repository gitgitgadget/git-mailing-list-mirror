Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1FD61F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 16:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbcIIQBd (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 12:01:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:57787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbcIIQBc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 12:01:32 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MGAdz-1bndAr3XaJ-00FCQd; Fri, 09 Sep 2016 18:01:23
 +0200
Date:   Fri, 9 Sep 2016 18:01:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] cat-file: introduce the --filters option
In-Reply-To: <xmqqfup9ds9p.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609091800020.129229@virtualbox>
References: <cover.1472041389.git.johannes.schindelin@gmx.de>        <cover.1473415827.git.johannes.schindelin@gmx.de>        <084088ba86c0af3636d960276c0bfdf7f5d2cfde.1473415827.git.johannes.schindelin@gmx.de>
 <xmqqfup9ds9p.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0wke7G191rTd7dzdcdVyKZkIga7OTZqPZzHMBX199QfrzHOxHfu
 S82rf6WOAfEQq1uxH0gVQAIhZbhg+irptRBTMyimZ6pRR1ex6kzdUD9e56omkcF4kE7kdh/
 vwkCvgK+1sEMUh1NQCQUb9OS/Mm4ZIPmS2IP8jEu8u46uNjrsKzhVVn95DTSAyGcxNOzesJ
 aG/5ceo3xpeNi0wdgVPpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0nlhYG3R66s=:SxHFkoe+T18FphH1j4Oedg
 8IM3HgQq+uXkDxp+exSorzo1dolCqqVCG9SNakQFiB6T6tSuTFK4wG6eyAEDdLDgvxJ21hC7u
 ZWhJm1JtDLcin84sw1T7KV0W7BtmNptOEMEBQ06psUzN+Gr7mrzFdA2/M6Fo7hfM7PuT6ZXGE
 qc8xpE/iJpW1eUcxlMZNvzuXeDkGXfL6MzyaZj4cjfGdYsmu/4qgZd+MyCo1bZNzGNg9L+wkD
 65+Ii9IrWDqzfpUlLPPLTTd43p90D7mWPwlxLud1m6lqCqlaq/uiCu9RvP4H1AZPY96cpRjrW
 jTeuEsYEz/cAJp7+yQyl45iofsSpT8DE33ZNkCM7jsniWDbt2gu++fCwueIa4G8UlVjtCodqY
 +KaA2cU21gbSZxTXkaAozedJ0f9cYzqk5Oz+bl/ehqoaN39GHR68SojvLWZZs3P3e2CblWAmd
 c5HE+mBpuG9N8msA2hUezckxoYIrxjLA/iERK2cFrzG82aEGtsxtfJWAidhEh0KWNGogdGkKN
 1ucsE1DQU85afRYRafoH4tsR3W/6JruU1b0M+2BBA1ZfmCUEItOT0eB7pKdjaFQ92NFYa45yv
 gBLUyh6B7CUa6BvGHTppqUu1h1le1N/yKltGIaRaUQnLI8haaLPrWZ9/a7xkiSeaQo8cbXbZo
 9a5MmrZ2K/bbg2S3kTT9Y3aozGCfnr3JYLm/XugRjnJOHYJNGxWkwhQqiBuoP3DzcC7T8rHjY
 bFEbX+2LFSUVzZFeSn+Rcr4NJJD4idSa6HN00+XejzOs1RcI3rZ3MOH+Wma3+jt6qmR5jzhYA
 hrx4373
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 9 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +static int filter_object(const char *path, unsigned mode,
> > +			 const unsigned char *sha1,
> > +			 char **buf, unsigned long *size)
> > +{
> > +	enum object_type type;
> > +
> > +	*buf = read_sha1_file(sha1, &type, size);
> > +	if (!*buf)
> > +		return error(_("cannot read object %s '%s'"),
> > +			sha1_to_hex(sha1), path);
> > +	if (type != OBJ_BLOB) {
> > +		free(*buf);
> > +		return error(_("blob expected for %s '%s'"),
> > +			sha1_to_hex(sha1), path);
> > +	}
> > +	if (S_ISREG(mode)) {
> > +		struct strbuf strbuf = STRBUF_INIT;
> > +		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
> > +			free(*buf);
> > +			*size = strbuf.len;
> > +			*buf = strbuf_detach(&strbuf, NULL);
> > +		}
> > +	}
> 
> This needs to error out when mode is not ISREG just like it errors
> out when type is not BLOB.

Are you sure that this is desirable in batch mode?

Ciao,
Dscho
