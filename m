Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2277DC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbiCDAYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbiCDAYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:24:35 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE4111DE3
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:23:49 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2333218D161;
        Thu,  3 Mar 2022 19:23:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tYCv/RmYVt69HCYkDMWI1nNye869UbI1ZfnV18
        BJBIg=; b=RIVrStixgt15pEubhUEFejaaHQv9RNHDlitSin7D9rflscXhxZmuFg
        5JGqiXOKiLwmx5bvi69dEIJYdSEGZyLyHNm7Ce6akymtgWia++/PcvgRjZIv9dYa
        v0r2Omj3OhznIGYEk7GXLOs4xOuvHCeAOWjKhx5sq2uicHnNlOXSk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BA9E18D160;
        Thu,  3 Mar 2022 19:23:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 95DC518D15F;
        Thu,  3 Mar 2022 19:23:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] SubmittingPatches: write problem statement in
 the log in the present tense
References: <20220126234205.2923388-1-gitster@pobox.com>
        <20220127190259.2470753-2-gitster@pobox.com>
        <YiFWZal+k6ixnYPU@google.com>
Date:   Thu, 03 Mar 2022 16:23:45 -0800
In-Reply-To: <YiFWZal+k6ixnYPU@google.com> (Emily Shaffer's message of "Thu, 3
        Mar 2022 15:59:33 -0800")
Message-ID: <xmqqzgm65zvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B31D7D4-9B51-11EC-ACA6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> As for the norm itself, I think it is a good one, and I've seen it
> pointed out in code reviews frequently. Thanks.
>
> Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

Thanks.

Was this meant to be sent long after the topic was merged to
'master' at 83760938 (Merge branch 'jc/doc-log-messages',
2022-02-11)?
