Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04334202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 00:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752925AbdJUATS (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 20:19:18 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:39905 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752896AbdJUATS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 20:19:18 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 21 Oct 2017 02:19:17 +0200
  id 00000000000000C7.0000000059EA9285.00004917
Date:   Sat, 21 Oct 2017 02:19:16 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/3] t5615: avoid re-using descriptor 4
Message-ID: <20171021001916.bohcqjuxcufxvpam@ruderich.org>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
 <20171019210730.sgm4g4tmor2dgjv7@sigill.intra.peff.net>
 <CAGZ79kYTmUnM+fcf222-cvwB3Fg4+J_xy28E7A3AYryx4qDf_w@mail.gmail.com>
 <20171019232337.zfd7occtjboem7f4@sigill.intra.peff.net>
 <20171020055058.s5dgxyfjnqtlxv4d@sigill.intra.peff.net>
 <CAGZ79kaSu+nHHntFPWbkXk1TC4ys9htesRg9HHXcpK+Y6MwZeg@mail.gmail.com>
 <20171020224608.3ataitvdq5r33iih@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20171020224608.3ataitvdq5r33iih@sigill.intra.peff.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 06:46:08PM -0400, Jeff King wrote:
>> I agree. Maybe just stick with the original patch?
>
> OK. Why don't we live with that for now, then. The only advantage of the
> "999" trickery is that it's less likely to come up again. If it doesn't,
> then we're happy. If it does, then we can always switch then.

I think switching the 4 to 9 (which you already brought up in
this thread) is a good idea. It makes accidental conflicts less
likely (it's rare to use so many file descriptors) and is easy to
implement.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
