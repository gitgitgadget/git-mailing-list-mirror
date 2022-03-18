Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064ABC433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 16:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbiCRQcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbiCRQcN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 12:32:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B701A847E
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 09:30:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3ABE18EFEB;
        Fri, 18 Mar 2022 12:30:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3Ji5VGj1s34+ImX72bWO+kWcAlE32x3P5gu4JS
        dU31o=; b=cVT9WW7SFZqcidFDhsoNxYEvhRQVAThxiEURlj/id0Q9r/Sy533sdc
        QMQhdkqWqdOIZc5mIbQtl+9eO+KNgxHmC5ytSUY8uvTnIVbZDiiCXflZr+SWSOks
        xkJXCeTc7zrjZ88J2wlWgJyOMji7Yrgl8hDAEFTbK+//Z5C7QA/Cw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDFCF18EFEA;
        Fri, 18 Mar 2022 12:30:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3437518EFE9;
        Fri, 18 Mar 2022 12:30:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, vdye@github.com, git@vger.kernel.org,
        newren@gmail.com
Subject: Re: [PATCH v4 0/1] Documentation/git-sparse-checkout.txt: add an
 OPTIONS section
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
        <20220317123718.480093-1-shaoxuan.yuan02@gmail.com>
Date:   Fri, 18 Mar 2022 09:30:37 -0700
In-Reply-To: <20220317123718.480093-1-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Thu, 17 Mar 2022 20:37:17 +0800")
Message-ID: <xmqqmthnb4uq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE96453E-A6D8-11EC-A28E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> == Updates Log ==
>
> Changes since v3 (based on v3's single patch):
>
>  * changes according to Derrick [1]
>
> == Overview ==
>
> Add an OPTIONS section to the manual and move the descriptions/explanations for 
> these options from below COMMANDS to OPTIONS. 
>
> [1] https://lore.kernel.org/git/307ac60d-b0a1-ea90-8118-a4e02b809102@github.com/
>
>
> Shaoxuan Yuan (1):
>   Documentation/git-sparse-checkout.txt: add an OPTIONS section
>
>  Documentation/git-sparse-checkout.txt | 44 +++++++++------------------
>  1 file changed, 15 insertions(+), 29 deletions(-)
>
> base-commit: eb129e532a7c58ea34afeec70b0e2e029c0d5fee

It is not very helpful to give the name of an object that is not
publicly available.  Basing a patch on some topics in flight is
fine, but please clearly state what it is based on in a cover letter
(if the topic is a multi-patch series) or below the three-dash line
(if it is a single patch).

