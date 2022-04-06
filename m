Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF05C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiDFV1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiDFV06 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:26:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082B22B2B5D
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 13:23:29 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07AE917290F;
        Wed,  6 Apr 2022 16:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lZ+gQzjHARycOl7FWngvX1VY0fhg6KW2/jj5+8
        C4UnY=; b=uVmF1O93oX8E2JjK643TfWV8dy0onTM7R02rjNkNmEW3wh+FF8dGhs
        oB1vucJ/FcWRJFJpxc2nYGPVv1O2jR+kVgcV7EYYV1E/A46Fn0vAdaKus1P93QaR
        NHyxjpJtFCCh681WkUqEE16K3+8nCpnOorlX+VsMwBc7BQJtICZ9s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F2FE317290D;
        Wed,  6 Apr 2022 16:23:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5091F17290C;
        Wed,  6 Apr 2022 16:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     COGONI Guillaume <cogoni.guillaume@gmail.com>, avarab@gmail.com,
        Matthieu.Moy@univ-lyon1.fr, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] contrib/vscode/: debugging with VS Code and gdb
References: <84f77a5b-5721-3583-8ed8-9d360928cf35@matthieu-moy.fr>
        <20220406151858.5047-1-cogoni.guillaume@gmail.com>
        <20220406151858.5047-2-cogoni.guillaume@gmail.com>
        <378c5790-f587-4e26-87be-8f856974e5ca@github.com>
Date:   Wed, 06 Apr 2022 13:23:25 -0700
In-Reply-To: <378c5790-f587-4e26-87be-8f856974e5ca@github.com> (Derrick
        Stolee's message of "Wed, 6 Apr 2022 14:03:12 -0400")
Message-ID: <xmqqbkxex8oy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A1478AA-B5E7-11EC-AA23-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>  
>> Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
>> Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
>> Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
>> Helped-by: Derrick Stolee <derrickstolee@github.com>
>
> Here, you probably want to flip the order here (Helped-by, then
> Co-authored-by, then Signed-off-by). You probably also want the
> sign-off of your co-author, too.
>
> The sign-off should be the last thing in the message, because
> the previous lines are covered by that sign-off.

Yup.  It would record the order of events that lead to this exact
patch, which is what we want to capture.  With help by these people,
together with the co-author(s), the patch was written and author(s)
signed-off before it was sent out to the list.

> ...
> And this is the necessary fix.
>
> Thanks for working on this!

Indeed.  And thanks for a helpful review.
