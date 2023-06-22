Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE78BEB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 23:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjFVXEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 19:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFVXEg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 19:04:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08781BF2
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 16:04:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AF693162C;
        Thu, 22 Jun 2023 19:04:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wxyNDvWDUMBNeZh0G89eZ1zrCqfNP0hsG9V1Uf
        sZVbY=; b=QbIum+wSBz6PYSUlb1B6cs/uvM2TQIDeIVDgIp+/mmXwNXaDb6Um2k
        cHReMVrCCdq3o1AarOjqpLbmUB8+cU258u6IUkLbl2Eu3khuifld+DajNOVGJaoh
        tvBiZMBONrk5gqenzQjEjrAlRrx1Lhp1FhnFFfXZRcHtrwLq3kfgU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7234D3162B;
        Thu, 22 Jun 2023 19:04:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 990FD3162A;
        Thu, 22 Jun 2023 19:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] docs: add git-hash-object -t option's possible values
References: <pull.1533.git.git.1687394795009.gitgitgadget@gmail.com>
        <ZJOc3Kd0vEEO6bUr@tapette.crustytoothpaste.net>
Date:   Thu, 22 Jun 2023 16:04:31 -0700
In-Reply-To: <ZJOc3Kd0vEEO6bUr@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 22 Jun 2023 00:59:08 +0000")
Message-ID: <xmqqv8ffcd4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2639FF62-1151-11EE-A792-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-06-22 at 00:46:34, John Cai via GitGitGadget wrote:
>> From: John Cai <johncai86@gmail.com>
>> 
>> For newer users of Git, the possible values of -t in git-hash-object may
>> not be apparent. In fact the current verbiage under NAME could
>> lead one to conclude that git-hash-object(1) can only be used to create
>> blobs.
>> 
>> Update the verbiage to make it clear the command can be used to write
>> objects, not just blobs. Also add the possible values for -t.
>
> Sure, I think this is a good change.  I'm of the opinion we should tell
> people explicitly what the valid values are whenever there are a
> reasonable number.

Strictly speaking, the valid values become unbounded under
--literally, but it is just for those who build and experiment with
Git, not for end-users or toolsmiths, so I am OK with listing the
four object types here.

Thanks.
