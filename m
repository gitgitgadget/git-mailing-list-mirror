Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49643C0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 19:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjGMTeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 15:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjGMTd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 15:33:57 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD4E2707
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 12:33:52 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74F6D1AADE2;
        Thu, 13 Jul 2023 15:33:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gg01cIqTx8DmVlYh4teym9jK4LvBcEtP8ZTxua
        HA9Hk=; b=V7fPhFrryoiOubTcQyvxNFT6zAQwNbxfjC3EWwGJkQUT1guY75cF9Z
        kesZ9N5H4KQVfLpx1ZPBB+5cJhPdXXWuz8rx4w6flX9Kp5+oVGE7YYToPse9pdlr
        Rq2PdD1wVN+8qA603xfGlRJmAuNenzLDXfnUphxgjamuWHHa6ABVE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B5981AADE1;
        Thu, 13 Jul 2023 15:33:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D15AB1AADE0;
        Thu, 13 Jul 2023 15:33:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Petar Vutov <pvutov@imap.cc>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: remove mentions of .gitmodules !command syntax
References: <20230712160216.855054-1-pvutov@imap.cc>
        <xmqqleflt75z.fsf@gitster.g>
        <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
        <xmqqfs5tt3qz.fsf@gitster.g>
        <7090349c-4485-d5c4-1f26-190974864f72@imap.cc>
        <xmqqa5w0swcs.fsf@gitster.g>
        <7ce31744-8c9d-da75-126c-e92dfbb4cf16@imap.cc>
Date:   Thu, 13 Jul 2023 12:33:49 -0700
In-Reply-To: <7ce31744-8c9d-da75-126c-e92dfbb4cf16@imap.cc> (Petar Vutov's
        message of "Thu, 13 Jul 2023 21:20:17 +0200")
Message-ID: <xmqqh6q7ppwi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31D1FD0C-21B4-11EE-AB0A-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Petar Vutov <pvutov@imap.cc> writes:

> I will address both of those and include your bugfix blurb in
> v3. Still figuring out how to properly reference the previous patches
> using git-send-email..

$ git send-email --in-reply-to='<7090349c-4485-d5c4-1f26-190974864f72@imap.cc>' ...

