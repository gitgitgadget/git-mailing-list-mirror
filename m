Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6C51F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755511AbcHSU45 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:56:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48520 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755378AbcHSU44 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:56:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CA2F71F859;
        Fri, 19 Aug 2016 20:56:41 +0000 (UTC)
Date:   Fri, 19 Aug 2016 20:56:41 +0000
From:   Eric Wong <e@80x24.org>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v3 1/3] diff-highlight: add some tests.
Message-ID: <20160819205641.GA31393@dcvr>
References: <20160819170812.1676-1-henderson.bj@gmail.com>
 <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
 <20160819170812.1676-2-henderson.bj@gmail.com>
 <xmqqh9ag39zk.fsf@gitster.mtv.corp.google.com>
 <20160819193045.GA9262@tci.corp.yp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160819193045.GA9262@tci.corp.yp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> wrote:
> On Fri, Aug 19, 2016 at 11:10:55AM -0700, Junio C Hamano wrote:
> > 
> > > +# vim: set noet
> > 
> > We tend to avoid cluttering the source with editor specific insns
> > like this.
> 
> oops.
> 
> Anyone have any suggestions for project level vim settings?

vim defaults work fine for me on FreeBSD and Debian:

	tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

Generally, we take after the Linux kernel:

	https://kernel.org/doc/Documentation/CodingStyle

Which I'm happy about and largely agree with.
