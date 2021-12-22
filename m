Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE7CC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 19:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhLVTe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 14:34:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64175 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhLVTeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 14:34:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA8C910D879;
        Wed, 22 Dec 2021 14:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3wtZv2nycGvoxDLeSpPFjIUZA6xWBBlFwLprG6
        eI8g4=; b=TN0Xckp/MtRVS/dVVFzGFOopjRllxA6qgFnohPEsPx3R1EYD5glPBP
        LCXqZsuO8AUXio7KdEwMXU6HM2LecVC1zWgGdpIoOiUfHFm70HCntSA6/KHWwe2Q
        fQggtY6OP8qO80xMTdMTPIfN9t6EAgqjXapYNFXqX4Phm6T8UW15o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E9BD10D878;
        Wed, 22 Dec 2021 14:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3BCA10D877;
        Wed, 22 Dec 2021 14:34:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lemuria <nekadek457@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Rebasing commits that have been pushed to remote
References: <71b51bc8-172f-48de-7c3f-cf55dc45b39a@gmail.com>
Date:   Wed, 22 Dec 2021 11:34:22 -0800
In-Reply-To: <71b51bc8-172f-48de-7c3f-cf55dc45b39a@gmail.com> (Lemuria's
        message of "Wed, 22 Dec 2021 15:55:19 +0800")
Message-ID: <xmqqlf0cjuwx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AE74FF8-635E-11EC-8337-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lemuria <nekadek457@gmail.com> writes:

> How do you reword messages of commits that have been pushed to remotes
> (in this case GitHub)? Do I simply perform an interactive rebase 
> operation on the commits and simply push?

It is up to each project if it is an acceptable practice to
rewind-and-rebuild a branch that has already been published, but
if the projects participants are OK with it, then "'rebase -i'
and 'push -f'" is how you would do it.
