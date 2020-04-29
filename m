Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF6C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB6120731
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sorrel.sh header.i=@sorrel.sh header.b="M6zmkboi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgD2MNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgD2MNe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 08:13:34 -0400
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267ACC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 05:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sorrel.sh;
         s=mythic-beasts-k1; h=Date:To:From:Subject;
        bh=xQzTpN3xBxnZnYdl5kEhiFUo8zxV10xW218gBDl/h/A=; b=M6zmkboiLFgjBamxsq0bg05Jlw
        vdwuL9INaA+CBF53S8H98euxodtBya/SrkSNXCe/e9A83o6wX3dkzRAdYoOOFeBRNIGUxN9SDwZ37
        0ruUjb8eFlItmky0RWdtqsK/jU3K3eO1G/ib7xVsefxdiFWvQmw/Owq1dN9E6r7e6aTv1XGInTEs8
        5JCeqsA9VPNOJhT58wYJMeOKtbd8d47iRwxNtbe1Zj5EMPSVGh8hy96vj4O+yNmq3QybeJ5j8tK+S
        kpcAnSdc3514Y8SNjwp44mlfjgglBaYb+ttHNpU6xMW8xS4GW/z2qRRYKhLjPBK61SN4KAHU0+N/g
        untgs4Rg==;
Received: from [212.56.100.202] (port=54701 helo=localhost)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <ash@sorrel.sh>)
        id 1jTlak-0003hm-So; Wed, 29 Apr 2020 13:13:31 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Emma Brooks" <me@pluvano.com>, <git@vger.kernel.org>,
        "Boxuan Li" <liboxuan@connect.hku.hk>,
        "Alban Gruin" <alban.gruin@gmail.com>
Subject: Re: [PATCH] userdiff: support Markdown
From:   "Ash Holland" <ash@sorrel.sh>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Wed, 29 Apr 2020 13:12:18 +0100
Message-Id: <C2DOKA77RJGH.3JJO8GPAGG9IN@what>
In-Reply-To: <xmqqv9ljz32g.fsf@gitster.c.googlers.com>
X-BlackCat-Spam-Score: 39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue Apr 28, 2020 at 3:57 PM BST, Junio C Hamano wrote:
> "Ash Holland" <ash@sorrel.sh> writes:
>
> > On Tue Apr 21, 2020 at 2:22 AM, Emma Brooks wrote:
> >> Since Markdown can have raw HTML tags in many variants, it may make
> >> sense to extend the word pattern to "[^<>=3D \t]+" like HTML's pattern=
 so
> >> tags starting/ending will not be considered part of a word.
> >
> > Good point, I'll update the pattern to that, thanks!
>
> I just marked the topic as "expecting a reroll" in the "What's
> cooking" report I have been preparing, but has something happened
> after this exchange?

You've not missed anything, sorry, I've been busy with exams -- I'll
prepare a v2 later today.
