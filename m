Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEECC4332E
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 22:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC4A20772
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 22:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hb0E51G6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgCRWm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:42:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64996 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCRWm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 18:42:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28F2CBCBBE;
        Wed, 18 Mar 2020 18:42:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=hb0E51
        G6ZcMSK1WcMJv3k6a2B9d5tARRkr6DrQDsLaXeNjoFc3zW7k8WKNKfOyFpFmMsSP
        KCtdViAJo2rAmgWsbzy0J1R8NQBpTZlqAOujVMalLV9MdhHRmL5naRe830pn4any
        H0fSbaHq6eRFug57iAQyvXHLmuNkdW2CNvWko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IzCRUk7rt/vl8B6fJhtLXmc0gvfHZJWA
        rR7SlXj3H6u5tQkybLIXTT0JD1mAJqre3OhfuzXwx6ObINk9OINd1iJ+iv6/paDi
        FnCc4vFLRzEdO0tKBm2i1fR/4O+oNQD2BHVia5SzaT6vu8VxY5hHoY8WBBqjVI0H
        3IG9GS7/CS8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 209A8BCBBD;
        Wed, 18 Mar 2020 18:42:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 463F1BCBBB;
        Wed, 18 Mar 2020 18:42:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] RelNotes/2.26.0: fix various typos
References: <pull.731.git.git.1584566306427.gitgitgadget@gmail.com>
Date:   Wed, 18 Mar 2020 15:42:19 -0700
In-Reply-To: <pull.731.git.git.1584566306427.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Wed, 18 Mar 2020 21:18:26
        +0000")
Message-ID: <xmqqzhcde14k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAB3767A-6969-11EA-8865-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
