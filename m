Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403D2C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 20:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351808AbiDAUQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 16:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbiDAUQV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 16:16:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC67D226A36
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 13:14:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3372012FD75;
        Fri,  1 Apr 2022 16:14:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J6o12F4mnL98hxKMBqFlH/W1vS2qDb6iOE6Vwq
        Csud4=; b=nnjYKA5cycf3UXSIjz3Vpf8Xu6bksSHU2ZcKztOR3CEPERlKkIXBg4
        VaZ6wckNRoftw8DhkfhV5FCCrA2JCjG/cj2G9+fQOrLIIeJ+tzyXhMhKUzD3OK68
        ovwrU6UR33yQNxaOfItzyAZeaNaeA43n1n5VfuGghWjvDMZeUNoW8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AE7912FD74;
        Fri,  1 Apr 2022 16:14:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 852CD12FD70;
        Fri,  1 Apr 2022 16:14:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/4] branch --recurse-submodules: Bug fixes and clean
 ups
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
        <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com>
        <xmqq7d89zqys.fsf@gitster.g>
        <kl6lk0c8spt4.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 01 Apr 2022 13:14:27 -0700
In-Reply-To: <kl6lk0c8spt4.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 01 Apr 2022 09:59:03 -0700")
Message-ID: <xmqqh77cv9wc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55794314-B1F8-11EC-9A54-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> Thanks, but sorry that I've already merged the previous round.  Let
>> me turn them into incrementals.
>
> Ah whoops, sorry I didn't send them out sooner.

No, it was me this time.  I have prepared 'next' long in advance so
I could have redone it if I delayed pushing the result out, but in
any case, we are working asynchronously and these things are bound
to happen.

> Thanks for that :)

Thanks for working on the topic.
