Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4042CC433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 01:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhLPBUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 20:20:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61865 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhLPBUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 20:20:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D42AA17135A;
        Wed, 15 Dec 2021 20:20:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PeV5epDELXmz3ULjD0lBeU7CCPUdfGo23OcyaR
        nvMtU=; b=msuSmIeCDbQw+TbdAWpGv16VGD2zyTu66uiMQtb1E6ZFe1rEuhBXTa
        +ybkQG+jpCeFMiwqs7U8X5vobaTY+eF2Uyij2q6kLadDSZ/iOFGeCNnU6PYoMair
        7VUlRaVKeTJMcR2bqlaFG6TeC3fYapKWOjKaiGQH3lugm66Dqwvvo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCBF5171359;
        Wed, 15 Dec 2021 20:20:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 37E7B171354;
        Wed, 15 Dec 2021 20:20:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        avarab@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 0/3] branch: inherit tracking configs
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <cover.1639524556.git.steadmon@google.com>
        <xmqqsfutzaaq.fsf@gitster.g>
        <kl6l35mtv0yz.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 15 Dec 2021 17:20:35 -0800
In-Reply-To: <kl6l35mtv0yz.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 15 Dec 2021 16:37:40 -0800")
Message-ID: <xmqqlf0lz6os.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FDBF4DE-5E0E-11EC-A1C0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I did not rebase this on top of 'seen' though; I'll take a look and see
> if there's anything of concern.

That's OK; please do not ever rebase anything on top of 'seen' or
'next'.  In this particular case, you and Josh agreed to base your
topic on top of Josh'es, if I understand it correctly, so find the
tip of js/branch-track-inherit from 'seen' [*] and rebase your topic
there.

But making a trial merge of the combined topic to say 'next' and
testing the result out before sending the patches to the list would
be very much appreciated ;-)


[Footnote]

* One way to do so would be:

 $ git fetch
 $ git show 'remote/origin/seen^{/^Merge branch .js/branch-track-inherit.}'





