Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412C11F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 09:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfJEJHL (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 05:07:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65198 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEJHL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 05:07:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 308A39BD97;
        Sat,  5 Oct 2019 05:07:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/fjuf5yefM63oHDr70Umn7JaaUM=; b=c/8P5d
        L0ZSzKbr/ZBvi3AbY+1MMOBoP+5EVURl9QUxoyOgHhbEMQM0epigxzMkF2i04gCR
        NkQrt60uEfOmXSa/dMCFZLmtcdq0dSSCoeHxF3GJESN7o+hdf0SlHElZgD6WOFt8
        GyehPjRjY6ytw2erdKXI4LhKoJbW959P/6/xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jQGBxAaufz4AuscbeXm/ui97YGgTtPFL
        xGQccppMqKPzfpabHh/ia7EunYJZiiR8v2pAbXdyq4fplCJbBxXkMjsk6DzYiiIi
        nYVi72wBr3UibzoHV7EhDtLDYXvczETICEqJoMUVJywl7ajHfFXl5bNfpxP6qyll
        fH45Z2vXot0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 291109BD96;
        Sat,  5 Oct 2019 05:07:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F9289BD95;
        Sat,  5 Oct 2019 05:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-rev-list.txt: prune options in synopsis
References: <645cc54c4c86493c855ec6b0b892a0bc8e999249.1570234118.git.liu.denton@gmail.com>
Date:   Sat, 05 Oct 2019 18:07:04 +0900
In-Reply-To: <645cc54c4c86493c855ec6b0b892a0bc8e999249.1570234118.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 4 Oct 2019 17:13:08 -0700")
Message-ID: <xmqqmuef7e87.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80F3D17E-E74F-11E9-AA0B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The synopsis section in git-rev-list.txt has grown to be a huge list
> that probably needs its own synopsis. Since the list is huge, users may
> be given the false impression that the list is complete, however it is
> not. It is missing many of the available options.
>
> Since the list of options in the synopsis is not only annoying but
> actively harmful, replace it with `[<options>]` so users know to
> explicitly look through the documentation for further information.

I am not sure listing only the most often used ones is harmful.  It
indeed is annoying and it is a good idea to shrink it down like this
patch does.

Thanks.

