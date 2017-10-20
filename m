Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD6C11FF72
	for <e@80x24.org>; Fri, 20 Oct 2017 07:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbdJTHX4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 03:23:56 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:45409 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdJTHX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 03:23:56 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Fri, 20 Oct 2017 09:23:55 +0200
  id 000000000000006D.0000000059E9A48C.0000066E
Date:   Fri, 20 Oct 2017 09:23:54 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        orgads@gmail.com
Subject: Re: [PATCH 4/5] diff: fix whitespace-skipping with --color-moved
Message-ID: <20171020072354.seqloliweseotuos@ruderich.org>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
 <20171019202926.irldca42wqosmxrd@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20171019202926.irldca42wqosmxrd@sigill.intra.peff.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 04:29:26PM -0400, Jeff King wrote:
> [snip]
>
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1463,6 +1463,73 @@ test_expect_success 'move detection ignoring whitespace changes' '
>  	test_cmp expected actual
>  '
>
> +test_expect_failure 'move detection ignoring whitespace at eol' '

Shouldn't this be test_expect_success? According to the commit
message "and a new "--ignore-space-at-eol" shows off the breakage
we're fixing.". I didn't actually run the code so I don't know if
the test fails or not.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
