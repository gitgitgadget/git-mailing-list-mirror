Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77623207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034033AbcIZTo6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:44:58 -0400
Received: from ikke.info ([178.21.113.177]:59212 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbcIZTo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 15:44:57 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id ADB7E4400AA; Mon, 26 Sep 2016 21:44:55 +0200 (CEST)
Date:   Mon, 26 Sep 2016 21:44:55 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] mailinfo: unescape quoted-pair in header fields
Message-ID: <20160926194455.GB19089@ikke.info>
References: <20160919185440.18234-1-me@ikke.info>
 <20160925210808.26424-1-me@ikke.info>
 <20160925210808.26424-2-me@ikke.info>
 <xmqq4m52scg7.fsf@gitster.mtv.corp.google.com>
 <xmqqzimuqx7u.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzimuqx7u.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 12:26:13PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Don't these also need to be downcased if you prefer $data over
> > $DATA, though?
> 
> For now, I'll queue a SQUASH??? that reverts s/DATA/data/ you did to
> 1/2 between your 1/2 and 2/2.
> 

Ugh, thanks. I'd replaced it in the first patch, but forgot it in the
second.
