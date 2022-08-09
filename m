Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4553BC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 16:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244984AbiHIQtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbiHIQtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 12:49:40 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A919222B1C
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 09:49:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B751146FE7;
        Tue,  9 Aug 2022 12:49:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wWdK2oqIxEPlL7zv6wO2xu1WS2w/+4T/kEjLhG
        Ws31o=; b=w49a7sg5UwHLm9ByMVbTe36MUAesF6+gI0d13nupers16AMgLqeZCP
        2GQmOOVy0j/ur91Uyj0hSrlVM78TDtCZjb3N2zTzov3+QWq81rC65N/ooSC2N2Zz
        fEitlIXsk3GlOXPSbvlS+TUKbMyaAjevYGzpi4bGp55Pt5ZGuQ0uE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22835146FE6;
        Tue,  9 Aug 2022 12:49:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 833AA146FE5;
        Tue,  9 Aug 2022 12:49:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: ds/* (was What's cooking in git.git (Aug 2022, #03; Mon, 8))
References: <xmqqv8r2qoi4.fsf@gitster.g>
        <d8a20d85-ab00-cb03-765b-e1d080de422b@github.com>
Date:   Tue, 09 Aug 2022 09:49:34 -0700
In-Reply-To: <d8a20d85-ab00-cb03-765b-e1d080de422b@github.com> (Derrick
        Stolee's message of "Tue, 9 Aug 2022 09:16:44 -0400")
Message-ID: <xmqqr11pqs4h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FF7B13A-1803-11ED-A4E0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 8/8/2022 7:55 PM, Junio C Hamano wrote:
>> * ds/bundle-uri-clone (2022-08-02) 5 commits
> I just sent v3 [1], including the updates to the protocol parsing.
> ...
>> * ds/bundle-uri-more (2022-07-25) 2 commits
> I just sent v4 [2], including minor rewords of things. ...
> ...
>> * ds/decorate-filter-tweak (2022-08-05) 11 commits
>>  Will merge to 'next'?
>>  source: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
>
> I think review has stabilized on this series.

Thanks.

As usual I'm offline today, so please expect no changes to the
public repositories.
