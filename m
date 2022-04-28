Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E354C433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 19:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiD1Tqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 15:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiD1Tqu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 15:46:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5E65AED0
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 12:43:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D3E113F6FC;
        Thu, 28 Apr 2022 15:43:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8wsRjGTCxf3qHPnSXe73RKo/TP1P3d7kpVVdL6
        oz+Qo=; b=wa0BgnWbnP2zqj9kUIDDQse13/UDeb3oMfPG2QpWdFxaikFgoAmQKR
        lFLETLKuTBNj9fJ28HxW9ImqyGaFrToovUAsVU306G3Lp1gOeOrWGVnRiaBjL3Fw
        kVzajE33OwxZnRoznFE/OxNnOEmN61V2ut4xm+fBv6JpBzw9Ea2Mg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 034ED13F6FB;
        Thu, 28 Apr 2022 15:43:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AB9013F6FA;
        Thu, 28 Apr 2022 15:43:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] MyFirstContribution: drop PR description for GGG
 single-patch contributions
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
        <2f6ecbf260135efc2a7ad09564cf6c64ed6d6f0d.1651086288.git.gitgitgadget@gmail.com>
        <xmqqmtg6jim2.fsf@gitster.g>
        <73b8834b-c2be-7e47-0f77-4853a5a051b7@gmail.com>
Date:   Thu, 28 Apr 2022 12:43:32 -0700
In-Reply-To: <73b8834b-c2be-7e47-0f77-4853a5a051b7@gmail.com> (Philippe
        Blain's message of "Thu, 28 Apr 2022 14:25:59 -0400")
Message-ID: <xmqqo80lf0yj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CDAC660-C72B-11EC-9BB1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Considering your other comment, I think that a little section
> titled something like "Anatomy of a patch series" would make sense
> to introduce how then end product looks like and then the sections
> on GGG or git-send-email can reference this earlier section.

"Anatomy" does sound like a good idea.

