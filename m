Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E8CC001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 16:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjGMQPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 12:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGMQPn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 12:15:43 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3C3E74
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 09:15:42 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6910E1A974E;
        Thu, 13 Jul 2023 12:15:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OJmbIddAcDJJMPme0CAlYZrHNTEBNDd7A9yUc/
        1KQgM=; b=YA7/W/bYqinzN11QXglChkCR7lAqTfRGVncfwljR649674SywyFVL+
        toPFo5BAbPjOmtFsn5tY0Yx0hyYr/17y05b9KYuQ95NTCzYxx239UIpkUoM8ImCU
        tWXnvrNdC0XWFj+q7pL8V+WlzaxXrRtHygk6pRNI1YBUtPdPhUH/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ED8D1A974D;
        Thu, 13 Jul 2023 12:15:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2BE41A974B;
        Thu, 13 Jul 2023 12:15:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        git@matthieu-moy.fr, christiwald@gmail.com, john@keeping.me.uk,
        philipoakley@iee.email, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/3] don't imply that integration is always required
 before pushing
References: <20230707054257.3366355-1-alexhenrie24@gmail.com>
        <20230713044128.3771818-1-alexhenrie24@gmail.com>
        <919d1ba8-bb8b-a77b-cef3-db14f168ed4a@gmail.com>
Date:   Thu, 13 Jul 2023 09:15:39 -0700
In-Reply-To: <919d1ba8-bb8b-a77b-cef3-db14f168ed4a@gmail.com> (Phillip Wood's
        message of "Thu, 13 Jul 2023 10:51:09 +0100")
Message-ID: <xmqqpm4vrdn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82B7BE30-2198-11EE-B7F8-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Alex
>
> On 13/07/2023 05:41, Alex Henrie wrote:
>> Many times now, I have seen novices do the following:
>> 1. Start work on their own personal topic branch
>> 2. Push the branch to origin
>> 3. Rebase the branch onto origin/master
>> 4. Try to push again, but Git says they need to pull
>> 5. Pull and make a mess trying to reconcile the older topic branch with
>>     the rebased topic branch
>> Help avoid this mistake by giving somewhat more general advice that
>> does
>> not assume that the user always wants to do reconciliation.
>> Changes from v4:
>> - Don't show divergent branch advice in the middle of `git commit`
>> - Soften the advice, but don't specifically mention force-pushing
>
> All three patches look fine to me, they are definitely an improvement
> on the current advice.
>
> Thanks for working on this,
>
> Phillip

Thanks, both.  Will queue after taking another look.
