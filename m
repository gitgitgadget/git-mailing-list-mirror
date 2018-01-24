Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987481F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932874AbeAXWa7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:30:59 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:59070 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932072AbeAXWa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:30:58 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.90)
        (envelope-from <mh@glandium.org>)
        id 1eeTZB-0005zN-2w; Thu, 25 Jan 2018 07:30:49 +0900
Date:   Thu, 25 Jan 2018 07:30:49 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-15?Q?=C6var_Arnfj=F6r=F0?= Bjarmason 
        <avarab@gmail.com>, Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: Git packs friendly to block-level deduplication
Message-ID: <20180124223047.iwi2ju7wvh7bptg2@glandium.org>
References: <87bmhiykvw.fsf@evledraar.gmail.com>
 <20180124221932.v6up7j67llwhjox4@glandium.org>
 <xmqq607qc2v6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq607qc2v6.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20171215
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 02:23:57PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > FWIW, I sidestep the problem entirely by using alternatives.
> 
> That's a funny way to use the word "side-step", I would say, as the
> alternate object store support is there exactly for this use case.

It's footgunny, though.

Mike
