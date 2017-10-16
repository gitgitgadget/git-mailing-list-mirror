Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475B420469
	for <e@80x24.org>; Mon, 16 Oct 2017 23:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933001AbdJPXxy (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 19:53:54 -0400
Received: from ikke.info ([178.21.113.177]:54048 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932519AbdJPXxx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 19:53:53 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id CCACC440392; Tue, 17 Oct 2017 01:53:51 +0200 (CEST)
Date:   Tue, 17 Oct 2017 01:53:51 +0200
From:   Kevin Daudt <me@ikke.info>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 00/25] object_id part 10
Message-ID: <20171016235351.GB19335@alpha.vpn.ikke.info>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
 <xmqq8tgbu9bt.fsf@gitster.mtv.corp.google.com>
 <20171016234912.6r7fqkxugn43wji5@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016234912.6r7fqkxugn43wji5@genre.crustytoothpaste.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 16, 2017 at 11:49:13PM +0000, brian m. carlson wrote:
> On Mon, Oct 16, 2017 at 11:15:34AM +0900, Junio C Hamano wrote:
> > With a hope that this might help other reviewers, here is the
> > interdiff between "the previous one merged with v2.15-rc1" and "this
> > round applied on v2.15-rc1 directly".  
> > 
> > The changes all looked sensible to me.  Thanks.
> 
> Is there a reasonably straightforward tool or workflow to generate
> interdiffs?  If so, I can include them in the future.
> -- 
> brian m. carlson / brian with sandals: Houston, Texas, US
> https://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: https://keybase.io/bk2204

tbdiff: https://github.com/trast/tbdiff
