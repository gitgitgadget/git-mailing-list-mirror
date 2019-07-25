Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6F11F462
	for <e@80x24.org>; Thu, 25 Jul 2019 15:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbfGYP4T (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 11:56:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52746 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGYP4S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 11:56:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E9DC88286;
        Thu, 25 Jul 2019 11:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=inWKxuu/bQ8NSVDQPs9f8Ok8OME=; b=Z/BSbk
        dspXF99v2yG59Q1ATNxyjEPVYPxKxquksNjz8fPePFpbqdAksonmzXnQFb1ZDdM1
        79IjaXGPTqJ2tQlaQB7Gel9ANQxMahgmNxQhnGXfDHB5gJnF7B9e3MycVqfqyQ7d
        EVDtIwDzykHd98D08yn4xelbIlNYin30yS4lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XeBX92fJfF1CtVZslLFKHqw1aT9n1DTw
        z0qViOzFrtolyNZmNrhNB4PDUZ17yfnVWmSyfrYAKOQ95eyeHEvEBB9NjuGY4L5t
        +rP8sAIlP0RNqXB4enkhm6b96cZxBohiRyPbpoBa09Y4CR3zb7PaoZwljvRt93CA
        cciorjR7rtA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 86E9888285;
        Thu, 25 Jul 2019 11:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B456B88283;
        Thu, 25 Jul 2019 11:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Clean up more of the fall-out from dropping the scripted git rebase
References: <pull.293.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Jul 2019 08:56:13 -0700
In-Reply-To: <pull.293.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Wed, 24 Jul 2019 14:14:58 -0700 (PDT)")
Message-ID: <xmqqh87aqfaa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBCD3076-AEF4-11E9-B5C4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> I had prepared these patches even before v2.22.0, but deemed them not
> critical enough to push into that release.

Thanks.  Both of these look quite sensible.  Will queue and
fast-track.
