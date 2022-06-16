Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A567C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 18:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378036AbiFPSxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 14:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiFPSxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 14:53:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9268C2CCB9
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 11:53:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F2E81AF78B;
        Thu, 16 Jun 2022 14:53:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9n+r8LtpeovLQFNUFKMUc5QJUVHoO67GazRIBf
        Ws8FA=; b=FosVdTAl1vJAEdDcxcF2F6jWwo8DcHjMRaW5KQNziicnVDVEZmsrpM
        beHC8U7vqH1kU0mOFmS2DqkZMuefoajN3M9pJhlVvGZAiRDWHgfsm41p/+QZ8viz
        GVvOV9EVwRdbI6rYtt+oUf5mHM/GDfuevNosQJaJVIphsULBEG31s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 176481AF78A;
        Thu, 16 Jun 2022 14:53:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FCD61AF787;
        Thu, 16 Jun 2022 14:53:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v4 0/3] bitmap-format.txt: fix some formatting issues
 and include checksum info
References: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
        <pull.1246.v4.git.1655355834.gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 11:53:27 -0700
In-Reply-To: <pull.1246.v4.git.1655355834.gitgitgadget@gmail.com> (Abhradeep
        Chakraborty via GitGitGadget's message of "Thu, 16 Jun 2022 05:03:51
        +0000")
Message-ID: <xmqq35g4tp7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C254338-EDA5-11EC-8FAA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version looks good and seems to format well.  Well done.

Thanks.  Will queue.
