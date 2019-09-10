Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E84E1F463
	for <e@80x24.org>; Tue, 10 Sep 2019 20:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfIJUfB (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 16:35:01 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41029 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfIJUfB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 16:35:01 -0400
X-Originating-IP: 1.186.12.58
Received: from localhost (unknown [1.186.12.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 28DF6FF802;
        Tue, 10 Sep 2019 20:34:58 +0000 (UTC)
Date:   Wed, 11 Sep 2019 02:04:57 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
Message-ID: <20190910203456.te2onnr3eibw2pjn@yadavpratyush.com>
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/19 10:10PM, Bert Wesarg wrote:
> The commit message widget does not wrap the next and has a configurable
> fixed width to avoid creating too wide commit messages. Though this was
> only enforced in the GUI. Now we also check the commit message at commit
> time for long lines and ask the author for confirmation if it exceeds the
> configured line length.

Thanks for the patch, but I'm not a big fan of this. I agree with Eric 
that more dialogs are annoying. Even as a temporary change until we have 
word wrap support, I don't like it. I hope you don't mind if I only take 
the scrollbar change and drop this.

-- 
Regards,
Pratyush Yadav
