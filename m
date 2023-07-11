Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EC9EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 20:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGKUH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 16:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjGKUH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 16:07:26 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B881BB
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 13:07:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE54D2BC2E;
        Tue, 11 Jul 2023 16:07:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/IEvydsejh7VCpd5/RnylTWp5ihUSDnY8dgy4f
        QKHis=; b=LGR9aGzru6RcBK4OHEzsOox2byvnO2JqaiVzSlYrn2xfjyPqiIPJYc
        r4pZ2oTEUPpvsSbzuzzoTMgcBXQbi+qXCGvmGi3lVkjrWZJk3ScTzo+kF9E3yJwC
        x6dLt4v3KyFnGHmZRvkiGUt7mXW0ODY+S+ccBnQdm31NtWuDPXpqw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E62932BC2D;
        Tue, 11 Jul 2023 16:07:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 564FB2BC2C;
        Tue, 11 Jul 2023 16:07:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH v3 3/3] check-attr: integrate with sparse-index
References: <20230707151839.504494-1-cheskaqiqi@gmail.com>
        <20230711133035.16916-1-cheskaqiqi@gmail.com>
        <20230711133035.16916-4-cheskaqiqi@gmail.com>
Date:   Tue, 11 Jul 2023 13:07:20 -0700
In-Reply-To: <20230711133035.16916-4-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Tue, 11 Jul 2023 09:30:35 -0400")
Message-ID: <xmqqa5w2xldz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B57AE92-2026-11EE-AEF8-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> Set the requires-full-index to false for "diff-tree".

Really...?
