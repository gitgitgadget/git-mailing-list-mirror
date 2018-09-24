Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16F71F453
	for <e@80x24.org>; Mon, 24 Sep 2018 00:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeIXGzp (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 02:55:45 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37867 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbeIXGzp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Sep 2018 02:55:45 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 442E23CD;
        Sun, 23 Sep 2018 20:56:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 23 Sep 2018 20:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=7w7Z3dNgoRpftDqoaDUMP8eaSJC4i
        PEmP6LKGEKiMxs=; b=ZsTBaVM3G8v+eoQOEe2fnD9ELR15JMnG78MaIK9VIKSJo
        gTZDOC2RLUEhixOiAL/ZO1nQa6kCvqE6cqP6trz6N8af+BPpcIBiCNUIhj8ORfCG
        tlfgws5MyLJTKLsqmZzeWv9kadU1XyzMe3R1McBw/hFnT+KrAQPCrgzytx9Tb5ph
        7rtQwKv5tgEaASYT7QbRGvw8h+xzWsvsNdJqNTg+rH4qysuJnhX+B6yC1Oe3qfsd
        beMz21L9oITE3FqF4ULbrspGtVFf35SGflZHmzDIDm47vnVB74GI0PHh2zajemVn
        ZK7Zmn/+gS6/ogG03JWLkpE+UuyvPVTglELCaR0HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7w7Z3d
        NgoRpftDqoaDUMP8eaSJC4iPEmP6LKGEKiMxs=; b=TdnCQdp24QsXrHw0z6uJLM
        sl7m9yvZ9ZD1BUmRcv3H7M4LA+Hv/xYFkyKt0pHxa64K171uVx0dKJ8PTeffV6JG
        KXmG6kZWevAjbuA1UAKYX1GEjXFopMoEBigZkVnNRMPAhR85WOVcy7EmKSUPT1qg
        gr+U97+FrIybnIwBs4DTcvFbbBRaxQ03T6/LS9wc6FJQELYEzMw9JuBCla8WOgxJ
        0x/Je5xOB7s36jUlJ8bYNco+IfsqLe5zuAfCQj4LZIgffBoOMBUsnSnsrruUZbX7
        i33kP6t+ED+qQ0FZuWxJtpim8jU10IAlrelh9zwte4bZCENPUpSK8UMnNpBqARkA
        ==
X-ME-Proxy: <xmx:JTaoW3h_VLV3AbQ4Zp0sIe6EPtWSZvt8C5cmgXaH6YscyoOmbZnxRQ>
    <xmx:JTaoW9ytalFaHTd1345GLs6rU8CYvUFCJ0bGfsDdvIy6GkNGXS7DDw>
    <xmx:JTaoW0CiQSdDEqhlMqG0bmeg1XrO0YfHsMRcIYpgjBJLfQ4PO8zhlQ>
    <xmx:JTaoW1OS59uHkzM18y7Z6_c0zySsaHvvYPzqlFd0xaF7YXy8xXv4rA>
    <xmx:JTaoW6j0mdzGvUZrzkxeIItG_h7MDvWgBQZm2XrppSSQaTHEwlKS7w>
    <xmx:JTaoW9pVkIhyxslpYO1Z_jX_hKksut5XEy7DkPrRyPM2qWynmsjTEQ>
X-ME-Sender: <xms:JTaoW78nJANfSesVdfGtXz_4FELEA411P-Wk4G9NxElEHiLHD2YU9A>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id DAC82102D6;
        Sun, 23 Sep 2018 20:56:04 -0400 (EDT)
Subject: Re: git diff-tree ignores --textconv
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <41cd358c-d900-2996-b78a-b9d897a2ba2b@stason.org>
 <20180924004307.GA26103@sigill.intra.peff.net>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <13dec8d3-b164-dc24-45e0-8e1bbd550524@stason.org>
Date:   Sun, 23 Sep 2018 17:56:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924004307.GA26103@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-23 05:43 PM, Jeff King wrote:
> On Sun, Sep 23, 2018 at 03:41:45PM -0700, Stas Bekman wrote:
> 
>> $ git config --get diff.jupyternotebook.command
>> git-nbdiffdriver diff
> 
> That's an "external diff driver", not a textconv driver.
> 
> So here:
> 
>> $ GIT_TRACE=1 git diff-tree -p HEAD --textconv test/test.ipynb
>> <shows normal diff, ignoring nbdiff>
> 
> You probably want "--ext-diff", not "--textconv".
> 
> There's some discussion in the gitattributes manpage, but the short of
> it is that textconv converts binary input to text, which is then fed
> through the normal diff mechanism. Whereas an external diff driver is
> given both sides and can produce whatever output it wants. Textconv is
> less flexible, but generally way easier to write.

Thank you, Jeff, for explaining my misunderstanding and how to fix it.

Would it be safe to ask the maintainer of the application to include
both --textconv and --ext-diff in that 'git diff-tree' call? I only need
the latter, but someone needed --textconv there as it's in the code.

This is for this package:
https://github.com/rsmmr/git-notifier

It was added here:
https://github.com/rsmmr/git-notifier/search?q=textconv&unscoped_q=textconv

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
