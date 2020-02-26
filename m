Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A43FC4BA13
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0086C206E6
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mawOcb5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgBZQdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:33:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51003 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgBZQdL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 11:33:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6517E5772D;
        Wed, 26 Feb 2020 11:33:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+t5hsMxWDl1CB6NxZM5g8TtKHxY=; b=mawOcb
        5K6G1uOZIJpCYZxYcqqbyrTyf1y3v90y3VoExG3XOcmcQGeZxL97ET+WddNPeUjg
        WG2yRVN5uY/xaGeuTSbN3rbzlhWfvbulCRCeRI4LxOp5H4CjIyaQ9bHmcHa7V2/V
        YC3ryTEltVkCPJMc4sgtoEfjLTKzT56WbW144=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UoiOvAhgnjge0zVTdQbbUKaxe3lCoSAV
        F6aY/tDkTMOdDb+n60Fpmc7e2YYyjw/R7HSSkFizjiy7ofHPruTVfFQcCOTmo2u4
        HDJ5EfGq71v7GAB+XkH9RcweId3sf/fvG9mFoxLl8vH3e3+hZpd8xoXvp8OyZzhM
        tiR5fsbMdAg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F2B35772C;
        Wed, 26 Feb 2020 11:33:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F6C55772A;
        Wed, 26 Feb 2020 11:33:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2020, #05; Tue, 25)
References: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
        <fa83b4d6-4db4-bae2-e07b-a67cee501fa2@gmail.com>
Date:   Wed, 26 Feb 2020 08:33:06 -0800
In-Reply-To: <fa83b4d6-4db4-bae2-e07b-a67cee501fa2@gmail.com> (Alban Gruin's
        message of "Wed, 26 Feb 2020 11:38:47 +0100")
Message-ID: <xmqqv9ntjol9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABEA8C24-58B5-11EA-A766-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Sorry to insist, but I did not see
> <20200121193226.24297-1-alban.gruin@gmail.com> making it into your
> tree... did it fell through the cracks?

Quite possibly.  Going back to the archive, I see Dscho Acked it, so
let's queue it.

Thanks for pinging.
