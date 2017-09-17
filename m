Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251BD2047F
	for <e@80x24.org>; Sun, 17 Sep 2017 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdIQTkQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 15:40:16 -0400
Received: from ikke.info ([178.21.113.177]:58038 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751254AbdIQTkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 15:40:16 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 05A3744012D; Sun, 17 Sep 2017 21:22:28 +0200 (CEST)
Date:   Sun, 17 Sep 2017 21:22:27 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t2018: remove unwanted empty line
Message-ID: <20170917192227.GD21499@alpha.vpn.ikke.info>
References: <0102015e8f599df4-6e3b45f3-b3ea-4483-ad62-08119e29b1cd-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102015e8f599df4-6e3b45f3-b3ea-4483-ad62-08119e29b1cd-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 17, 2017 at 10:19:28AM +0000, Kaartic Sivaraam wrote:
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  t/t2018-checkout-branch.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index 2131fb2a5682c..e0a52334a22dd 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh
> @@ -192,7 +192,6 @@ test_expect_success 'checkout -b <describe>' '
>  test_expect_success 'checkout -B to the current branch works' '
>  	git checkout branch1 &&
>  	git checkout -B branch1-scratch &&
> -
>  	setup_dirty_mergeable &&
>  	git checkout -B branch1-scratch initial &&
>  	test_dirty_mergeable
> 
> --
> https://github.com/git/git/pull/403

Why is this empty line unwanted? This kind of whitespace can help
separate logical sections, just like paragraphs would.

Kevin.
