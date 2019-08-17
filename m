Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6DA41F45A
	for <e@80x24.org>; Sat, 17 Aug 2019 14:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfHQOAO (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 10:00:14 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:34913 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfHQOAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 10:00:14 -0400
X-Originating-IP: 1.186.12.58
Received: from localhost (unknown [1.186.12.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0D93740008;
        Sat, 17 Aug 2019 14:00:11 +0000 (UTC)
Date:   Sat, 17 Aug 2019 19:30:09 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: completion: checkout.* not being completed in zsh
Message-ID: <20190817140009.4kelg4yiybb4xphn@localhost.localdomain>
References: <20190815185901.btf4d7c4ewsccxuu@localhost.localdomain>
 <20190816023649.GB365197@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816023649.GB365197@genre.crustytoothpaste.net>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/08/19 02:36AM, brian m. carlson wrote:
> On 2019-08-15 at 19:50:27, Pratyush Yadav wrote:
> > I tried looking at contrib/completion, and I can see that zsh completion
> > works on top of bash completion, so I don't know why exactly it works
> > for bash but not for zsh.
> > 
> > I am not too familiar with how these auto completion scripts work, so if
> > someone can point me in the right direction, I'll see if I can figure
> > out a fix and submit it here.
> 
> zsh uses its own completion system which is substantially different from
> the bash one and includes definitions for most programs shipped with it.
> Are you sure you're using the Git-shipped completions and not the ones
> shipped with zsh?

Yes, you are correct. I was using the zsh shipped completion. Using the 
git shipped completion fixes this. Thanks.

-- 
Regards,
Pratyush Yadav
