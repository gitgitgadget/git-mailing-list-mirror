Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB83ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 18:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiISSEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 14:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiISSET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 14:04:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94D445980
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 11:04:18 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42D9314EC10;
        Mon, 19 Sep 2022 14:04:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JeAauItJE8PJhnfa507cSKcCR1mwhZ7IInXy6O
        M9vRw=; b=XFfTdJICWvev0Jb19ktSCPVEbJyWxPXtKqz5awaTxJ4xeyXeIQRClk
        t/rzrJJ0K0bVvQms0AKpmB20B5lsZ/TgjKwwMf6qhTBKuRMtTKX0TCpvgw4m8+hA
        t7DNtoyYdHhxvidvgsaP6Szr4w015becB99rwFBpruelQ/Ntb5N+o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A38414EC0F;
        Mon, 19 Sep 2022 14:04:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73EFC14EC0E;
        Mon, 19 Sep 2022 14:04:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.38.0-rc0
References: <xmqqczbwkpt8.fsf@gitster.g> <YyiXojfvwfvmW4Dd@danh.dev>
Date:   Mon, 19 Sep 2022 11:04:16 -0700
In-Reply-To: <YyiXojfvwfvmW4Dd@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Mon, 19 Sep 2022 23:24:02 +0700")
Message-ID: <xmqqy1uf9r6n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A5981F2-3845-11ED-B143-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All valid typo&grammo-fixes---thanks!

