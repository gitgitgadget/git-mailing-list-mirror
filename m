Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB174CE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjISTvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjISTvj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 15:51:39 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873E19C
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 12:51:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D60E319B95B;
        Tue, 19 Sep 2023 15:51:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=qxPPYlly+aFkNYcMRRDfffiSeN42ys/8mZYCcH
        oEXiE=; b=es3GcVhc91xTVviy9FukVk0DBh4N+F3vzVkKMQXEvJPAL0g28Yy3GL
        YoqX5rPqU03FS8OkXka/XbBrWggaOTaf2FzTcAiBx1c4Nxb77DRYjIFRC0RgW6D+
        nKvliBwm3DUz2O17SBheSZYm14+LBBApieyX7OwxuyFQ3dk6L1kFA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF29C19B959;
        Tue, 19 Sep 2023 15:51:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A3F919B958;
        Tue, 19 Sep 2023 15:51:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     git@vger.kernel.org,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Denton Liu" <liu.denton@gmail.com>, "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v4 1/1] range-diff: treat notes like `log`
In-Reply-To: <6ad470bd-207f-4735-9ab5-2da5010d9ef4@app.fastmail.com>
        (Kristoffer Haugsbakk's message of "Tue, 19 Sep 2023 21:44:20 +0200")
References: <cover.1694383247.git.code@khaugsbakk.name>
        <cover.1695144790.git.code@khaugsbakk.name>
        <244e102cc4693bb6291e03cffea6df05cdb29df3.1695144790.git.code@khaugsbakk.name>
        <xmqqled2ezfh.fsf@gitster.g>
        <6ad470bd-207f-4735-9ab5-2da5010d9ef4@app.fastmail.com>
Date:   Tue, 19 Sep 2023 12:51:32 -0700
Message-ID: <xmqqbkdyeybf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF2DBCF0-5725-11EE-94F2-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> Okay I think I understand. With that in mind I would change it to the
> patch below.
>
> I can make a new version if that looks okay.

Looking good, although I would say "unless other options are given"
("other" is optional) instead of "arguments" if I were writing this.

Thanks.
