Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300892021E
	for <e@80x24.org>; Sat,  5 Nov 2016 07:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbcKEHnv (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 03:43:51 -0400
Received: from mout.web.de ([212.227.15.14]:64375 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752329AbcKEHnv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 03:43:51 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LilYb-1cYOt420yL-00d0AV; Sat, 05 Nov 2016 08:42:35
 +0100
Date:   Sat, 5 Nov 2016 07:42:31 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, santiago@nyu.edu, gitster@pobox.com,
        peff@peff.net, sunshine@sunshineco.com, walters@verbum.org
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
Message-ID: <20161105074231.GA15803@tb-raspi>
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:iVX9kN/ZMNNVLj+jlp2fYLlgH8okZWjRxO3lbYGGSZ8ata/MNAo
 Zw+SWqQbgc9PLqt6guxnsWqrnF7QNTQ5+FdGigQs21LNoGDNNJetdwc6rVd3ut0lTPNHKIz
 LPQ8Xutc7YcZHRQHzPWqovn4gUBwDHy+Nmuo/YVMUpGDyZxVCX7WBfWZIUu1Ko28c8Isf0b
 xKVxMOJ6JQ53nrIpGFEJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o8FFXy/JZfY=:4tVFH2xPIYmwe0Z6wIdaW+
 8mRE7P5f25G8b4UttOPApp/CdDfEOeNe4s2R51XTvN5ZbGIKZXduee6yMHP+AamzhZSuYQMKq
 rl2DxsJFGy2lwE0oRYFca84c2RFZe546rIe6xooF6dIZycp9ExTKynW9qxyFbJxcJwCK0m3/x
 vmBohtrBHAAeloiZn9Jak/PgSexA36mMSmKWScCQj/E84Dfjd1dub8w5GkEU9MS8RjNyolMnl
 6E8ZUimJairQRyKEgokH/UX74DBqyV66lwG7YXpT/bsJ3tHyFoHfDR92Gkukq2HQwnulZk4Cs
 AUPWVuf2HcebLFrZ7WmJtqvNaMvcS0BsyVDqO1eF16PSg9wJeiMI39Ar8Va31mjokFjwxhfNa
 SVuECUsvNzW43v0eUzeMFJYWadopnhiQ/4q+LL91A5+YAJFTZypDqBsDz19O8BBg2dgH55zDw
 3j4vITFgdLdaFsIMG5DT4+WXUVpma3sNFw5Fy6zgvyVb8vj3qx+KmbNFBRiDAw4mOjPcel24x
 /jUko8q55EfjRgrILNS8xtXC4sweBc9/d16/ipKB4BLiBwBe9+f+IZEsoJ7ZEmzCtSH8Zje4T
 4HjZB1eIbgFbBd7afCUsRBGeRwG38SuciLOvvjUlolmFMzqyGOc9odexm6t7ii4/80ql7JlxU
 ABdPHQPnwx/pUXl0griS8lUnKF5G1fCgL74spjiuQANgUeok/Bheu5a0zlgZWbF5RL23hcNtV
 CEkhPftSE3+wPbuVdNMAr1MnYBh9Dv8bWlZcXA9UNeRXjhpx8aM/JoUwqUI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * st/verify-tag (2016-10-10) 7 commits
>  - t/t7004-tag: Add --format specifier tests
>  - t/t7030-verify-tag: Add --format specifier tests
>  - builtin/tag: add --format argument for tag -v
>  - builtin/verify-tag: add --format to verify-tag
>  - tag: add format specifier to gpg_verify_tag
>  - ref-filter: add function to print single ref_array_item
>  - gpg-interface, tag: add GPG_VERIFY_QUIET flag
> 
>  "git tag" and "git verify-tag" learned to put GPG verification
>  status in their "--format=<placeholders>" output format.
> 
>  Waiting for a reroll.
>  cf. <20161007210721.20437-1-santiago@nyu.edu>

I don't know if this has been reported before:
Some tests needs to be protected by GPG:
+test_expect_success GPG 'verifying a proper tag with --format pass and format accordingly' 

test_expect_success GPG 'verifying a forged tag with --format fail and format accordingly'

test_expect_success GPG 'verifying a forged tag with --format fail and format accordingly'
