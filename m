Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F61C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 06:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350528AbiDOGil (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 02:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbiDOGik (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 02:38:40 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC0C4578D
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 23:36:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B75E0114B82;
        Fri, 15 Apr 2022 02:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kTQwaXTr3taICxPoNQu6FQw4qq/OUC2PfdSOnt
        LnJUw=; b=EwFk7DhcqQCG1G0BSaMZFdHt8TOUj3F2BcYcMnieYUjBY/QRNWYj1E
        PW9kFbkWxc/xr8pdfvFuZOv5eWkbDI8svkAqZ5Lvw1VKZePVHmdOaDrXL45jxD41
        Zy6vwP/mAFPfhLjyWZZgfm5ucMbpMtZgnzMerF447JZVao4DSxGws=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF6B8114B81;
        Fri, 15 Apr 2022 02:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19031114B7E;
        Fri, 15 Apr 2022 02:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Makefile: add a prerequisite to the
 coverage-report target
References: <20220415024738.9239-1-gitter.spiros@gmail.com>
Date:   Thu, 14 Apr 2022 23:36:08 -0700
In-Reply-To: <20220415024738.9239-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Fri, 15 Apr 2022 02:47:38 +0000")
Message-ID: <xmqqczhig8fb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56E59FC0-BC86-11EC-B7DF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Directly invoking make coverage-report as a target results in an error because
> its prerequisites are missing,

The result happens to be identical to what I already have in my tree.

Thanks for taking care of the details of dependencies.

