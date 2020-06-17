Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7742FC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 11:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54C32098B
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 11:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="SSqT/dg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFQLsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:48:01 -0400
Received: from huan10.mail.rambler.ru ([81.19.78.9]:57388 "EHLO
        huan10.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFQLsA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 07:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=AyL14NekgKVI6j8XEcVO9xuYSVk3PRk9mfvVMMqO9fU=; b=SSqT/dg2jYsTtKenFs3tuVkLT3
        3Nwb3StB279vNOtASBCXFd8qYaO10MzarUqhdw2NG5q1eWtic2ey9SxaY0TAhcUYaU8N9lkG5FkZ6
        /8pkTxsQaPVtiyX58P8AK/u/dMFZc7thJVl12QJokXs1ThoXsLigL7W54gJjZuGSdU/8=;
Received: from [UNAVAILABLE] ([194.190.114.28]:41946 helo=localhost)
        by huan10.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlWXu-0003kj-Ss
        for git@vger.kernel.org; Wed, 17 Jun 2020 14:47:59 +0300
Date:   Wed, 17 Jun 2020 14:49:40 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200617114940.GA8376@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <B67468F4-98BB-4213-9763-1A09EC256769@alastairs-place.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B67468F4-98BB-4213-9763-1A09EC256769@alastairs-place.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 12:34:05PM +0100, Alastair Houghton wrote:
> Just to stick my oar in here, *if* it’s going to change (and I’m yet to be convinced that it should, but I’m also not opposed in principle to a different name), **PLEASE** can we change it to “trunk”, which is what most of us were using before Git became popular anyway?  That at least makes sense in that a tree trunk has branches.

But "master" is not trunk. It just a branch.

-- 
Олег Неманов (Oleg Nemanov)
