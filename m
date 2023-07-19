Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54C9C001B0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 23:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGSX1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 19:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSX1E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 19:27:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F2D1B9
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 16:27:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 146671FCCB;
        Wed, 19 Jul 2023 19:27:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wlk1f1X4zhkK+FKY41n35LYTzZlcFmDg0baHsy
        zcGrQ=; b=EW5tR+SPG9yk+IFd+K2YZwtAQuPo2VStKkFnL8oHJCE3ZmMs6vd5Ex
        C4s4FPpfVDESnk8dbRXmmA28xzkEEdtcn9dxMDYXLjhn/S/e/g52Xn2B4Y7XFk9t
        iHju41CUJowZ8ZLv+fJzVRBTFLk4hm3YeiLBZavG9dUnrUAjlRY/w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D7791FCCA;
        Wed, 19 Jul 2023 19:27:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E43A1FCC6;
        Wed, 19 Jul 2023 19:26:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] short help: allow a gap smaller than USAGE_GAP
References: <xmqq5y6gg8fn.fsf@gitster.g> <xmqqttu0esqb.fsf@gitster.g>
        <xmqqlefcesjr.fsf_-_@gitster.g>
        <98b86433-053b-c44e-05a9-b2e3afd4b4f0@drbeat.li>
Date:   Wed, 19 Jul 2023 16:26:58 -0700
In-Reply-To: <98b86433-053b-c44e-05a9-b2e3afd4b4f0@drbeat.li> (Beat Bolli's
        message of "Thu, 20 Jul 2023 00:04:45 +0200")
Message-ID: <xmqqfs5j5vp9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C230967A-268B-11EE-8718-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

>> +		OPT_SET_INT_F(0, "longhelp", &integer, "help text of this entry\n"
>> +			      "spans multiple lines", 0, PARSE_OPT_NONEG),
>>   		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
>>   		OPT_GROUP("Magic arguments"),
>>   		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
>
> I think this chunk should be part of the previous commit.

Good eyes.  Thanks.
