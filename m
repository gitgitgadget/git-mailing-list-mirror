Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71433C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F9461AA5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhKRXyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 18:54:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58221 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhKRXyL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 18:54:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AD86E9CB8;
        Thu, 18 Nov 2021 18:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=qNYAgC2bFFQfpJT05AD8/Ti1ZP2MG1wZkuLlT6Upj5Q=; b=itYw
        yfThkSUnxgEhcG3CoRhTqkXANv2r+ssCuh03yCvYJctKbakl0R05XLmYD49BVevi
        vnEjH/VVqU6icEvJftwHKcLrzxAPSdnvwKKFFysNsGrnP9SvgBimMz3jOTeuaTcZ
        hy2w4Fm/7tZ13q3goA1KL/5ITM6EeAdhH8r+cgM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62113E9CB7;
        Thu, 18 Nov 2021 18:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8ADFFE9CB6;
        Thu, 18 Nov 2021 18:51:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, stolee@gmail.com
Subject: Re: [PATCH v2 1/1] midx: fix a formatting issue in
 "multi-pack-index.txt"
References: <cover.1637218943.git.dyroneteng@gmail.com>
        <9b910a44f4143c94787110a688f2b17ba4eeb0fc.1637218943.git.dyroneteng@gmail.com>
Date:   Thu, 18 Nov 2021 15:51:06 -0800
Message-ID: <xmqq4k89uiol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66CA2CA6-48CA-11EC-AC3D-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> There is a formatting issue  in "multi-pack-index.html", corresponding
> to the nesting bulleted list of a wrong usage in "multi-pack-index.txt"
> and this commit fix the problem.

Thanks, will apply.

