Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE1BEE4993
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 19:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjHUTCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 15:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjHUTCW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 15:02:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBC730DD
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 12:01:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3C2F1BAC64;
        Mon, 21 Aug 2023 15:01:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FPy3XC/Ld/a6J7aFQtzBejNHMyza1QPC1PPHEK
        EE9pY=; b=D+ZHbT431VGIl9JXB2WnpnjQMfsYs30jHxJI9K2sXuAMLT1sWUBhRk
        hoLCUAOl5WKfajYTeFJqeaug3o7vgp5mU1AP0mZSQ7ee+vOXk4yL1TyhcTZ7s39/
        cxNy698E9dX03VgaRJ0RFW3IQK89yJJtLgfHE6SigXYcoEE82Ym+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9A401BAC63;
        Mon, 21 Aug 2023 15:01:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 36DC71BAC62;
        Mon, 21 Aug 2023 15:01:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     git@vger.kernel.org, glencbz@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 0/8] pretty: add %(decorate[:<options>]) format
References: <20230810211619.19055-1-andy.koppe@gmail.com>
        <20230820085336.8615-1-andy.koppe@gmail.com>
Date:   Mon, 21 Aug 2023 12:01:22 -0700
In-Reply-To: <20230820085336.8615-1-andy.koppe@gmail.com> (Andy Koppe's
        message of "Sun, 20 Aug 2023 09:53:28 +0100")
Message-ID: <xmqqbkf0p6d9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F0CC228-4055-11EE-958A-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> Compared to v3, this avoids introducing a compound literal, and splits
> part of patch 5 into an additional patch 8.

Thanks, will requeue.
