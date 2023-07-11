Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BECEB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGKQ4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 12:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjGKQ4d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 12:56:33 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2803410C7
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 09:56:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37F0F1ACAA8;
        Tue, 11 Jul 2023 12:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qkXyhxE+77SFIxvrq588yBkwzTY68/m066wVVo
        b1Jm4=; b=Ufrq9SVgrPPpSqlyHj049Dg7hzqPO+ksri82v2i2jTEy1hOuiIVk9I
        +mgVXYCHFJcRgAdGhiXOwzNOiHF0MSzS38p8Rezeo25I5N/7UMUdvymlF+CeUI4a
        CjkTuO6sf7TKbbMPXKxDXNrYkqc/R84/efq+vKijVUu/pPbae8sQw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3114E1ACAA7;
        Tue, 11 Jul 2023 12:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 960DC1ACAA6;
        Tue, 11 Jul 2023 12:56:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH v3 0/3] check-attr: integrate with sparse-index
References: <20230707151839.504494-1-cheskaqiqi@gmail.com>
        <20230711133035.16916-1-cheskaqiqi@gmail.com>
Date:   Tue, 11 Jul 2023 09:56:28 -0700
In-Reply-To: <20230711133035.16916-1-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Tue, 11 Jul 2023 09:30:32 -0400")
Message-ID: <xmqq351u1j5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E192B7A4-200B-11EE-98C0-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seems to have leftover whitespace glitches.  They are not a reason
to reroll alone, but if you need to create v4 then please make sure
your patches are free of these.

Thanks.

.git/rebase-apply/patch:31: trailing whitespace.
	 * If the pos value is negative, it means the path is not in the index. 
.git/rebase-apply/patch:32: trailing whitespace.
	 * However, the absolute value of pos minus 1 gives us the position where the path 
.git/rebase-apply/patch:33: trailing whitespace.
	 * would be inserted in lexicographic order. By subtracting another 1 from this 
.git/rebase-apply/patch:34: trailing whitespace.
	 * value (pos = -pos - 2), we find the position of the last index entry 
.git/rebase-apply/patch:35: trailing whitespace.
	 * which is lexicographically smaller than the provided path. This would be 
warning: squelched 1 whitespace error
warning: 6 lines applied after fixing whitespace errors.
Applying: attr.c: read attributes in a sparse directory
Applying: t1092: add tests for `git check-attr`
Applying: check-attr: integrate with sparse-index
