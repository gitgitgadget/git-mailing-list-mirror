Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6267D1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 14:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbcH3Oqp (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 10:46:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:60981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbcH3Oqo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 10:46:44 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Me4Ly-1bTElx291C-00PrTz; Tue, 30 Aug 2016 16:46:27
 +0200
Date:   Tue, 30 Aug 2016 16:46:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] require_clean_work_tree: ensure that the index was
 read
In-Reply-To: <alpine.DEB.2.20.1608301300010.129229@virtualbox>
Message-ID: <alpine.DEB.2.20.1608301645170.129229@virtualbox>
References: <cover.1472137582.git.johannes.schindelin@gmx.de>        <4122fc996a0076c2426d5e1325f2ce2810ef4f9b.1472137582.git.johannes.schindelin@gmx.de>        <xmqqmvjv6uxn.fsf@gitster.mtv.corp.google.com> <xmqq60qj6kmf.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608301300010.129229@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hceg7YZdWbx4XJM81xXoOJFPCWW2Qtin9hdTihOTUDgGJn+DQHr
 MrcYOR+xrERqyL01jWvV4fLvDicIPheMpjtJjw+IV1GtRwRyPs9yiuZ8IE+IS74x+5P0kOg
 swYcCAqlC5XGHS/02eLMRCH63Ssd6+RZqQNoL0NCZMENUv2Do464kQOQxPuCPFnDldpyi2g
 D08B4vX78ScDdhpOmw2ng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/ZPN/we5EWI=:mtC/yJI1LrnUL9vX7Onvxx
 2anKHFKeinedPP9HFtUIzk2ViXZlVtQMxlTVzAMbMmNqJQJI/b2rbRgJX/q/02slU6ZIRLFDt
 RSODDuqMg7mYcNLJFY67Y/U28kUifakIXDvFLf7gqHg9QCE8SZX93tK0nVExGpOUPPvXS9+5x
 GSN40oReioRVHuhmfllcleNvGATzzPjHL6THdt0sVOQaESEbfEFAslHIrEipYZ85jvelPuQ1I
 6Yl2uOkVHuf1KuJx8Six0qCO8ONBUr852GLTmzRTUKqKiqE78vUCDsCHUCDJqYiRhYj7jSXt7
 YRRea7eYguDq9+SJxW9DkkvCiTYHFPqxr3uJjSrwL/YiBOzswgfJgCREIr8WYWaNSBrldqJeP
 UoeWstv1hJEeE1FS/gb5nCWgmYuvO90E7+Li4r1azKZdQlXZ+SEBpivgQf0h3A9+wJI6zMYM/
 +dpS1UeL4rkI8sbWKG8nVSandV6JzNmxi/L7pbTgrCK8eraV9FLg9FpjEtuAb+ZnM62x6Bm+j
 8RC2TiLWa6DYwqe8eRcTAJFy6o0RWD2xf1b5725wCvK57xQojlr8uJet04ER8js/Q8M1BObEm
 bFZ4PIGelme1DMSZ2T25vOVOKydfhB6v0QTUfUVAxh9ZO8OguZ+6sdMlPrIY/OIbHzZWrBnPx
 IgwSf4inneI3YxPQcftDGcyTrmAs//6KjqjO2WpXxruhkpoKC7zDbfIuv9vqZUJT1UWFNG015
 HgKPsuj5pcaIm3rgr/MRB5uEf8HwNqkk4DVnr4x/MMZVf8JDGaOTxeamAa6ReYGWrYHdGoS7E
 7LIeKWP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 30 Aug 2016, Johannes Schindelin wrote:

> On Mon, 29 Aug 2016, Junio C Hamano wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > I am not sure if it should be left as the responsibility of the
> > > caller (i.e. check the_index.initialized to bark at a caller that
> > > forgets to read from an index) ...
> > 
> > Scatch that.  That would not work in a freshly created repository
> > before doing any "git add".  An empty index is a normal state, so it
> > would not just be annoying to warn "You called me without reading
> > the index" but is simply wrong.
> 
> Fine. I changed it to assert that the_index.initialized was set.

Alas, that does not work, either. If no .git/index exists, read_index()
will not set the "initialized" flag.

So it turns out that I can either get distracted in a major way, or drop
the patch. I opt for the latter.

Ciao,
Dscho
