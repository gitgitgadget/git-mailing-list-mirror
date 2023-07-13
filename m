Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E7EC001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 21:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjGMVKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGMVKu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 17:10:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B7A2D43
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:10:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3EA439873;
        Thu, 13 Jul 2023 17:10:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y6g5AbZM7Vpu6feAdmWQgd/Rvrd1AU6D7eaZjS
        eJ9RQ=; b=HdcQfV44SkNJErAomUA/Zolw30/o/CO21QFw/dSXg2FzpEBFdSOie6
        awY62NnSRt4/+1art5e9UELb/klRnj/b98y+s4slME+RbsRC8lBWaUp8r3gdUbeb
        4gKyypUJ2iYkNmHzrheV7Gm3E5QfkrO1YI/L+QavGKjxaFQOtKu4I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ABE9339872;
        Thu, 13 Jul 2023 17:10:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 43ED039871;
        Thu, 13 Jul 2023 17:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] SubmittingPatches: be more explicit
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
        <203ed19dd1b72a8085af05359d5a226b94fe2c7f.1688778359.git.gitgitgadget@gmail.com>
        <xmqqo7kn6k21.fsf@gitster.g> <owly5y6nh6cj.fsf@fine.c.googlers.com>
Date:   Thu, 13 Jul 2023 14:10:43 -0700
In-Reply-To: <owly5y6nh6cj.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Thu, 13 Jul 2023 14:03:24 -0700")
Message-ID: <xmqq5y6no6uk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB7C24BC-21C1-11EE-9201-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> I think what threw me off originally was the internal section link name
> "[[base-branch]]". I think that could be reworded to
> "base-starting-point" or similar.

Yeah, I agree that it is misleading to say "branch" as if it has to
already exist.  starting-point would be a good phrase to include, so
I would imagine base-starting-point would be an appropriate name for
the inline anchor.
