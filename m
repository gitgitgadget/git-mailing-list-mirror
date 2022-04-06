Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A93C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 18:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbiDFSHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbiDFSHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 14:07:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F40CDCE24
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 09:43:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA6D2130419;
        Wed,  6 Apr 2022 12:43:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5qubmTZdpkVyKxbnAiCFwHPgtJ93Rk2NmqVCBH
        TaouU=; b=Rf/0pvFa/ga7RH+UWaYtz+CoSGq8xu81OKHiY4bTYVfiKj883GrbY9
        CAr7oJataL1Uwp+PnIdosgl7/vHCyyYgqvbxFaTz4ENo3bWTvIm3REUJXjfsR63v
        AxmDDJIV+Vq42a+FV4sWhRLcHgcn2aPG7i9Qu/ZdQgU0jrqydOZE4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF910130418;
        Wed,  6 Apr 2022 12:43:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 276F0130417;
        Wed,  6 Apr 2022 12:43:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Documentation/Makefile: fix "make info" regression in
 dad9cd7d518
References: <20220405141552.qgl6t2urtbeilsmp@lucy.dinwoodie.org>
        <patch-1.1-e700d372e0c-20220405T195425Z-avarab@gmail.com>
        <20220406082625.7mots3ziqchjpyhw@lucy.dinwoodie.org>
Date:   Wed, 06 Apr 2022 09:43:42 -0700
In-Reply-To: <20220406082625.7mots3ziqchjpyhw@lucy.dinwoodie.org> (Adam
        Dinwoodie's message of "Wed, 6 Apr 2022 09:26:25 +0100")
Message-ID: <xmqqbkxeyxfl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B84D29DC-B5C8-11EC-A83C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> Confirmed this patch fixes things for me.  Thanks for the quick fix!
>
> Tested-by: Adam Dinwoodie <adam@dinwoodie.org>

Thanks, both.

