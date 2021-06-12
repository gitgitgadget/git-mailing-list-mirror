Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45671C48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 23:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1145C60FDB
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 23:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFLX0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 19:26:14 -0400
Received: from mout01.posteo.de ([185.67.36.65]:39333 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFLX0O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 19:26:14 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 54F37240027
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 01:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1623540252; bh=IJsKLs+hKH8bv4OoKNOxIM/2+6+bDkRKjI505TdEI90=;
        h=Date:From:To:Cc:Subject:From;
        b=HTjVq+WplQoMSELZ7Iu5BgAR9LDn1PAVCZoYDOJqCuz/JYofakSjoEV/6R2DpI/e2
         FHZrc9/yK+x/fFG/GjRCHwhkiczWpzQpqCv0HYhCK/o8TeHpCrImpKWWdBO7FT2dFy
         l29OrCn8WIOIqP7xcGecHwSX/55+DkrZi3xrRmMjR1mIQIiJdEWgWKkn87pJU7oKVR
         7ZxuhkT6R6WAygqd+vSGUZKLsJZsNSfL5+2u0Cpy39BlZOLB02j+Y5wJMORSFQD5ln
         TWGTZGSOkdXQqiPxeZe7rh9tc5k5f9Vomrh3j06p69b3dyGdLfxnNGb7U8rawelCXP
         qBDvMQglSBArA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4G2Ygt4MSDz9rxL;
        Sun, 13 Jun 2021 01:24:10 +0200 (CEST)
Date:   Sat, 12 Jun 2021 23:24:09 +0000
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Robert Karszniewicz <avoidr@posteo.de>
Subject: Re: [PATCH 0/2] Avoid gender pronouns
Message-ID: <YMVCGYoyadOtA0Iu@BDZ>
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611202819.47077-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 11, 2021 at 03:28:17PM -0500, Felipe Contreras wrote:
> The latest solution looking for a problem [1] is to use the actively
> debated among linguists singular "they" [2].
> 
> Leaving aside the linguistic intricacies that not all singular "they" are
> equal [3], and the overwhelming sentiment that these kinds of political
> discussions don't provide value for this community [4], the "issue" can
> be easily solved by simply using different wording.
> 
>   - The reviewer herself
>   + The reviewers themselves
> 
> Problem solved.
> 
> Cheers.

Perfect, I like this. This style is clearer, more neutral, and more on
point.

Thanks,
Robert
