Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3B9207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 11:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999471AbdDZLer (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 07:34:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:58822 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2999463AbdDZLep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 07:34:45 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIdTM-1d5Y8W2mca-002GVP; Wed, 26
 Apr 2017 13:34:32 +0200
Date:   Wed, 26 Apr 2017 13:34:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 1/9] rebase -i: generate the script via
 rebase--helper
In-Reply-To: <20170426104511.nuk3fcxofhrtxsma@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1704261333480.3480@virtualbox>
References: <cover.1472833365.git.johannes.schindelin@gmx.de> <cover.1493128210.git.johannes.schindelin@gmx.de> <361682a84f421ff16a8c6b7120f132cd6b61f1fa.1493128210.git.johannes.schindelin@gmx.de> <20170426104511.nuk3fcxofhrtxsma@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HidhJHkg/wuK5jHkSgDLPYe7L2LClwi9RsOS7bMcVj7L73HNrI3
 hiV+mw5lIDUXyJkDVMoigZC1MC8JR3wRvoadeOL9a98U3JJSrXIi9n6puk7uVQah07+j3bt
 ocSjJbWE4+SUwebui4l1/8SMeTtAz9JS+gePaBnSgsUcGDmaXyH1N5SjvbgdThSmnF+Ylgd
 oWcoOL9v8wXGYdbhvP1cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mgqylhs2VTY=://3sub3ocGSDMhXNmKfLrF
 x2bzf38MM4Jnr4epyLk0ytfzZSWqCy/j2DYyXF6dc8rqX6XRAy37BqFi9KU0sRFhYsIOcccrT
 Kr5E4YhE2SvkYttPxCxZ0nGbIYJ68hNPUIpopMDG8s4+8gfsnrQ6nrGbsUyypGoDI8EWzDq9I
 p3E+HIKGo4JcGB3LG33eGEfrLNCa/o+3XHG+KRnhYyadHuXJc3O5NEGzSp4jxSy4uSmcxHoom
 cV52/sNa/2x5u5SQnFxQk4CXDAISEYoa9OZZc+NQ1lcsmw9FqaK+rkR/Aqw7QWWaVhSKKhzQs
 QABJilFcB3o5e/nSUJVGcEZOzHJ2FtxZv+cUG3CSD7YNhYhggNoyvUeJPDf1seqJ33sw82awY
 xY9/o4mABhbecB+LyJcurkX7XFyJB2VgRpbNH5hDsZLUjdk6CSVMZrFZrTl4GdAyOWefS76FM
 R3WroysvN/dISca9jRxkz70i0A4ckCmY+8YflI1zsR0Kqx6FFjiV/cWij3BzhdXx7GNqdvs57
 wAfZxuy/YsNTogUskfg86XDs2tEzbIdZJQ1U35uvDtJ3bnMlKolo1ms6zvmeroFlrLE8+pnLA
 jjLgwarWTbXr3jfNO8sp7wA+wce9cKV2d8vUKK6+UuQLesD9VLNJrPbDc7lAyQd6xQkhn/9r7
 FfBOpVanqoeJ5TKBSoxFPPTuc/ziNx7rX1uucXm2laNpqs+ge4AzRY8CeAbs1yZmJVD9Rl/d6
 MGvtYDkd60mB9T7qHK902RCmgXjSrVu7t513o7C30dSuCa/N9iiky3reeXtAlvvsGAhBN8sd8
 vP2xpt+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 26 Apr 2017, Jeff King wrote:

> On Tue, Apr 25, 2017 at 03:51:49PM +0200, Johannes Schindelin wrote:
> 
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > [...]
> > +int sequencer_make_script(int keep_empty, FILE *out,
> > +		int argc, const char **argv)
> > +{
> > +	char *format = "%s";
> 
> I'm surprised the compiler doesn't complain about assigning a string
> literal to a non-const pointer. It makes me worried that we would call
> free() on it later. We don't, but that means...
> 
> > +	git_config_get_string("rebase.instructionFormat", &format);
> 
> ...that this assignment to "format" leaks.
> 
> So perhaps you'd want to xstrdup the literal, and then make sure the
> result is freed? Or alternatively use an extra level of indirection (a
> to_free pointer to store the config value, and then a const pointer for
> "format").

Good suggestion. Will be part of v3,
Dscho
