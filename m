Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1880C2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 23:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbcISXzz (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 19:55:55 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44919 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbcISXzy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 19:55:54 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 64F34172094;
        Tue, 20 Sep 2016 01:55:51 +0200 (CEST)
Date:   Mon, 19 Sep 2016 16:55:50 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] format-patch: Add --rfc for the common case of [RFC
 PATCH]
Message-ID: <20160919235550.GC29421@cloud>
References: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
 <3df15bbb-7eac-86ec-2ccb-74a973482e8c@au1.ibm.com>
 <xmqqa8f3g4pu.fsf@gitster.mtv.corp.google.com>
 <20160919204408.GA28962@cloud>
 <20160919233434.fhkikksi4cxzrzb5@sigill.intra.peff.net>
 <20160919234022.GA29421@cloud>
 <CA+P7+xp-CupfFwQv+U-KNh4bxG9Mxkbfip5RJebKX9gjffoOsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xp-CupfFwQv+U-KNh4bxG9Mxkbfip5RJebKX9gjffoOsw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 04:46:06PM -0700, Jacob Keller wrote:
> On Mon, Sep 19, 2016 at 4:40 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > On Mon, Sep 19, 2016 at 04:34:35PM -0700, Jeff King wrote:
> >> As far as your patch goes, I'd be OK with defining:
> >>
> >>   --rfc::
> >>       Pretend as if `--subject-prefix='RFC PATCH'` was given.
> >>
> 
> Would:
> 
> Shorthand for `--subject-prefix='RFC PATCH'`
> 
> be a better reading? I feel like using "pretend" is a bit weird here.

My patch used "Alias for"; if you prefer "Shorthand for" I'm
indifferent. :)
