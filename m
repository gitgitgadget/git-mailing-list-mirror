Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82417ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 16:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIPQVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 12:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPQVN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 12:21:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E957DB6549
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 09:21:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 215D91B8F06;
        Fri, 16 Sep 2022 12:21:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MKFGJVJBKGl85Y0HceSZ2VkwDmNPjHxpSkW4s7
        DatdU=; b=t0DLX5MQMLnOWFnmNKnXtQ9Z1RS3kfO9aOLq6bTg9du74IlgjI/bNq
        I+sLBvM8IleHevwRh8gQN+XeDQtBTMcOBwf8DrVbRN64mqdXaQUn1B+4z4hVoZHm
        Pnd37uFBeKahwgWVjd68DBqXcIsrklxBho4fiX93iPxQ5/8Q6Vuf0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 196EA1B8F05;
        Fri, 16 Sep 2022 12:21:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9F7C71B8F00;
        Fri, 16 Sep 2022 12:21:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff-merges: clarify log.diffMerges documentation
References: <20220914193102.5275-1-sorganov@gmail.com>
        <20220914193102.5275-4-sorganov@gmail.com>
        <xmqqr10cmqbk.fsf@gitster.g> <87leqjjuu9.fsf@osv.gnss.ru>
Date:   Fri, 16 Sep 2022 09:21:06 -0700
In-Reply-To: <87leqjjuu9.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        16 Sep 2022 16:46:06 +0300")
Message-ID: <xmqqo7vfi93h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91AFBEB4-35DB-11ED-9B78-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I wanted to explicitly describe what log.diffMerges affects, instead of
> vague "default diff format" term causing a need to figure what in fact
> it means.

Yup, excellent.
