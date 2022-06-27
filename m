Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4D2C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 08:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiF0IcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 04:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiF0IcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 04:32:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD1F626B
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 01:32:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E988192285;
        Mon, 27 Jun 2022 04:32:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rR2Lay+hH8B+ub0qIsEdlpV8g4tSqrlUEUTcXjWCXmI=; b=t9Li
        gYvqkapdvtPyEq6VD+DxGiswqZgyxvlmkmdT/rfEKDXt1e2DK/oE4/1RyOk4lMnR
        KZ3o+/uzaNgrke9hV44Jk7GdOZY6BfSfYn/prnyHe8yUN9dDbde+gllm4lz7dPbw
        eSEhndo1JDY8aAhWo75SpJtBDaGbwvO9ga0x5oE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59C9F192284;
        Mon, 27 Jun 2022 04:32:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C684019227F;
        Mon, 27 Jun 2022 04:32:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.37.0-rc2
References: <xmqqedzg4hqj.fsf@gitster.g>
        <Yrii4Wj+c0YuQy61@zacax395.localdomain>
Date:   Mon, 27 Jun 2022 01:32:09 -0700
Message-ID: <xmqqv8smqzg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A35D28EA-F5F3-11EC-AEA7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> On 22/06/22 12:32PM, Junio C Hamano wrote:
>>  * "vimdiff[123]" mergetool drivers have been reimplemented with a
>>    more generic layout mechanism.
>
> Hi. Maybe because this is my first contribution to git I was strangely excited
> and decided to create a small blog post describing how the new mechanism works.
>
> There is no javascript nor tracking nor ads... just good old html/css/pngs
> explaining how and when to use `mergetool.vimdiff.layout`:
>
>   https://u92.eu/blog/git-vimdiff/
>
> Hope someone finds this useful :)
>
> PS: Please let me know if this type of message is not appropriate for this
> mailing list and I will never do it again... I just thought it might be good to
> explain the new feature in a blog post to prevent it from going unnoticied
> considering how "hidden" the new configuration variable is. Thanks!

You may want to also tell Git Rev News editors (Christian Cc'ed)
about the blog post page, I think they have a list of Git related
readings in each edition.

Thanks for an interesting feature.
