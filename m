Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAB5C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 16:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiGJQ2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 12:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGJQ2h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 12:28:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12204639B
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 09:28:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33EBF19640C;
        Sun, 10 Jul 2022 12:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kCa1V4/FtKMsUaj8VCELOY8fsER9xYfbpjEHUG
        QFZV8=; b=EHtElZiSVOS/5VQ6SgNuXhbQ+JJK2v/foVn7JZtnMb3uykKRk06lrG
        GFda6YRZiwPsfTMd+Y6s11oZ91FWFGvTFErR0sIObM7x5OV60QxndU5mqth75B7u
        PEIgl4ExUyQAUqO+4hhXTWdfeigDuoEaml1sRhjzaBI39xFW43dsA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CF5D19640B;
        Sun, 10 Jul 2022 12:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D34D9196409;
        Sun, 10 Jul 2022 12:28:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2022, #02; Fri, 8)
References: <xmqq4jzquiok.fsf@gitster.g> <202207102031058469922@oschina.cn>
Date:   Sun, 10 Jul 2022 09:28:28 -0700
In-Reply-To: <202207102031058469922@oschina.cn> (lilinchao@oschina.cn's
        message of "Sun, 10 Jul 2022 20:32:06 +0800")
Message-ID: <xmqq7d4lrkyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 552CC93A-006D-11ED-8234-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

>>--------------------------------------------------
>>[Stalled]
>>
>>* ll/curl-accept-language (2022-06-13) 2 commits
>> - PREP??? give initializer to rpc_state
>> - remote-curl: send Accept-Language header to server
>>
>> source: <pull.1251.v3.git.1655054421697.gitgitgadget@gmail.com>
> what should I do if the state is stalled?

Send a response to the discussion thread and/or possibly an updated
and corrected patch to fix compilation issues, perhaps?
