Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5507BC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 07:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiBJHMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 02:12:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiBJHM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 02:12:29 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C234FD6D
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 23:12:31 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 396A017BFEE;
        Thu, 10 Feb 2022 02:12:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H1OMxTLA+GQCrwCOv0R3+wqREgdJCAG9i2KMaR
        A2S6w=; b=Q/icr1iKuK9JC3XcWmY6BHBX33+KvRi8qEynxiM/nYWqTq/Q1ojmss
        7FUNsEs+czg4fDQj1QBSLTi9dosU+wQDIdbiHydz2cRM6mg52fhWufgcfnM3D662
        SeUROuY0F5xU/C0ymXiTyYeQOfUjLnCGQumeJ2q9Hks7l6Cl+uyTQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24CB017BFED;
        Thu, 10 Feb 2022 02:12:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7A09217BFEC;
        Thu, 10 Feb 2022 02:12:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with
 test_path_is_* functions
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
        <20220121102109.433457-2-shaoxuan.yuan02@gmail.com>
        <Yer/oEZK6TBFSsde@nand.local> <xmqqr190g6gd.fsf@gitster.g>
        <CAJyCBORHE2+UMKYFfKArgK68fAT=pKVabVmfifzg--rHAFkaqg@mail.gmail.com>
Date:   Wed, 09 Feb 2022 23:12:27 -0800
In-Reply-To: <CAJyCBORHE2+UMKYFfKArgK68fAT=pKVabVmfifzg--rHAFkaqg@mail.gmail.com>
        (Shaoxuan Yuan's message of "Thu, 10 Feb 2022 11:11:09 +0800")
Message-ID: <xmqqo83fw5yc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE4A44E4-8A40-11EC-AAC1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> Since I didn't see this change in seen or next, do you plan to apply it?

I actually wasn't, as my understanding of it was primarily your
practice.
