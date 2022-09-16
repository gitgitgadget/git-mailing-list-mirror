Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F94ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 15:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIPPro (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 11:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIPPrl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 11:47:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B49B02BC
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 08:47:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3724514741A;
        Fri, 16 Sep 2022 11:47:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RNryJFVKBLGkbAuZZ1qxegMpT50BRaxyFkVddd
        ayoFE=; b=jGbBU5t4D4poqv4IOyWlP24OC0evD106P+UY7LiUDURWOPX0SVHWn2
        00leSzqW2VU/PGvgIgrdMr8B9ZtqGbm+CHFreqQ0tLBQiEjuQOQ6AF6MVRXq/zxq
        WiuVGodekbp0xDLIp54TA0eUn9Mq4MQmcb+0bYOUOaofhguD0rqTA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DC59147419;
        Fri, 16 Sep 2022 11:47:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96089147417;
        Fri, 16 Sep 2022 11:47:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.38.0-rc0
References: <xmqqczbwkpt8.fsf@gitster.g> <YyQZ3L8HQo+bj8yz@pobox.com>
Date:   Fri, 16 Sep 2022 08:47:37 -0700
In-Reply-To: <YyQZ3L8HQo+bj8yz@pobox.com> (Todd Zullinger's message of "Fri,
        16 Sep 2022 02:38:20 -0400")
Message-ID: <xmqqr10bjp7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E434DDB8-35D6-11ED-BE6C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Junio C Hamano wrote:
>> Git v2.38 Release Notes (draft)
>> ===============================
> ...
>>  * Introduce a discovery.barerepository configuration variable that
>>    allows users to forbid discovery of bare repositories.
>
> s/discovery/safe/ in the first sentence, I think?

Indeed.  The configuration knob was renamed to the final name in
"safe." hierarchy in the last iteration and I forgot about it.

Thanks.
