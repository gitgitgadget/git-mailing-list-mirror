Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5A920A26
	for <e@80x24.org>; Sat, 16 Sep 2017 08:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbdIPIyE (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:54:04 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:42543 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdIPIyE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:54:04 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 16 Sep 2017 10:54:03 +0200
  id 000000000000010A.0000000059BCE6AB.00002227
Date:   Sat, 16 Sep 2017 10:54:02 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Are the 'How to' documents present as man pages?
Message-ID: <20170916085402.pc2vnimymien355n@ruderich.org>
References: <1505538043.21890.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1505538043.21890.4.camel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 16, 2017 at 10:30:43AM +0530, Kaartic Sivaraam wrote:
> I was reading the 'git revert' documentation and found the following
> line in it,
>
>     -m parent-number
>     --mainline parent-number
>
>         ...
>
>         See the revert-a-faulty-merge How-To[1] for more details.

Square brackets indicate links, you should have a NOTES section
at the bottom of the man page which contains something like this:

        1. revert-a-faulty-merge How-To
           file:///usr/share/doc/git/html/howto/revert-a-faulty-merge.html

To my knowledge those are not available as man pages.

> It says that the 'How-To' is present in the first section of the man
> page. I tried to access it to get this,

References to other man pages generally use round brackets, for
example git-merge(1).

I checked the git-scm.com website [1] and interestingly they use
square brackets for these references which confused me a little.
Not sure if it's worth changing though.

Regards
Simon

[1]: https://git-scm.com/docs/git-revert
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
