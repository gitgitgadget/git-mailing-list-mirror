Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AAFC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 17:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377211AbiATREq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 12:04:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54459 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243979AbiATREd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 12:04:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D53717F133;
        Thu, 20 Jan 2022 12:04:32 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=dflXi20j1PMqFffm2saUU96wNjLapR4kS5Cpb09
        +DIc=; b=SvqOZVs8RvLc4e3N/B0bgSttaIoNdx+JWNdW1zumH0Ra6nGT9LWNIEF
        c+FmiGgimtmiA+03XPxdKNf0L5fItaO7xaxk63K8MBla8Nfs2XT3q1XIGGlk6u8t
        clex3r2fv7ZYZsxIgc3N9quBytE0ZVM4Q1XAYq4HBOfALFmmqdDE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9677D17F132;
        Thu, 20 Jan 2022 12:04:32 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A5DD17F131;
        Thu, 20 Jan 2022 12:04:28 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 20 Jan 2022 12:04:25 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Subject: Re: [BUG] builtin/checkout.c:1098: should be able to skip past
 'refs/heads/'
Message-ID: <YemWGf1Rc+uOF3UJ@pobox.com>
References: <YemTGQZ97vAPUPY0@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YemTGQZ97vAPUPY0@pobox.com>
X-Pobox-Relay-ID: 07ACA198-7A13-11EC-801F-CBA7845BAAA9-09356542!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote:
> A bug was filed in the Fedora/Red Hat bugzilla today for the
> git 2.35.0 rc (rc1, but it's the same in rc2).

For completeness, https://bugzilla.redhat.com/2042920 is the
ticket.

(It's apparently too early for me, despite the clock's claim
of noon).

-- 
Todd
