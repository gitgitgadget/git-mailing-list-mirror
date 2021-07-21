Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD981C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985426101E
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGUWwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:52:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52306 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhGUWwx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:52:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF815C2D36;
        Wed, 21 Jul 2021 19:33:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s4ZKrJHh1vR7Bd61aQJuXcQXCw5xuQbQMTCwSl
        2ycvs=; b=cG6aP4JYzf58AkkqOukvsC6dkopsSc8GUu8bdRmuPZgKPVLnjWTCAD
        gxZoXDdpEvk9f/AYvpvLRFhgw5wQ5EQBSHoziMG2bkm4OmVYxdkoQ8SY8zKfx3zP
        dzL7kfLJbCPLVNHIbOzdTPNRQpwOg0Gr1nKGaXpWjwBNbyxwHrQfc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7022C2D33;
        Wed, 21 Jul 2021 19:33:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6ACA9C2D32;
        Wed, 21 Jul 2021 19:33:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] doc: pull: fix rebase=false documentation
References: <20210721221545.1878514-1-felipe.contreras@gmail.com>
Date:   Wed, 21 Jul 2021 16:33:27 -0700
In-Reply-To: <20210721221545.1878514-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Wed, 21 Jul 2021 17:15:45 -0500")
Message-ID: <xmqqy29z9r94.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D46D42E-EA7C-11EB-B9A5-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 5c3fb67c01..7f4b2d1982 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -117,7 +117,7 @@ When set to `preserve` (deprecated in favor of `merges`), rebase with the
>  `--preserve-merges` option passed to `git rebase` so that locally created
>  merge commits will not be flattened.
>  +
> -When false, merge the current branch into the upstream branch.
> +When false, merge the upstream branch into the current branch.
>  +
>  When `interactive`, enable the interactive mode of rebase.
>  +

Looks correct.  Will queue.  Thanks.
