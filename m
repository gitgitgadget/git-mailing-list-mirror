Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E64C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 22:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471D3207DD
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 22:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WWuoZpuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgFRWeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:34:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53053 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgFRWeA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 18:34:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE7DE7659B;
        Thu, 18 Jun 2020 18:33:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MrmCz1f00HzOWlHh+x09eAL/XoY=; b=WWuoZp
        uKFWvigNiHclcEy5dstuZlej8qfNFj2y5xOAkEB3TFytca+Yu4CBTIUGzmczqfmf
        JcL0b4LCZZ9MvFiaaVDhISqbiMDBWNXxe4yEg209WwPxooc/tT1/LRsL5B/ajIR+
        PcF2U6HzNiHpvY4eVin99xatNNL+c0wGrm2ZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EMtUlDTGUQEiebEjmnlzj5Zze543lYhD
        wHpPwd68nx1ARlxzb6HkTkwVR0d4yRNKm4IaVJ4ImkzEh5sG9JfuAs/vhueZ8jKS
        hOVLKFGnC6+vqCAp5/TdEDAkOVIMo5dps6EkbgT2VEZDer83SO44yBDAfgc8KUL5
        dePjEHQFN7Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C692E7659A;
        Thu, 18 Jun 2020 18:33:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CBE476599;
        Thu, 18 Jun 2020 18:33:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-files: treat "i-t-a" files as "not-in-index"
References: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
        <xmqq4krhjql1.fsf@gitster.c.googlers.com>
        <20200611232851.GA55419@death-star>
        <20200618175808.GA36733@mail.clickyotomy.dev>
Date:   Thu, 18 Jun 2020 15:33:56 -0700
In-Reply-To: <20200618175808.GA36733@mail.clickyotomy.dev> (Srinidhi Kaushik's
        message of "Thu, 18 Jun 2020 23:28:08 +0530")
Message-ID: <xmqqftasknqj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC505FC8-B1B3-11EA-AF05-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Hello,
> Is there any update on this patch?
> Please let me know if I missed anything.

Sorry, the patch totally fell through the cracks.

I just sent out a brief review on the part I didn't review during
the first round.

Thanks.
