Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EA7C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 19:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245399AbiA0TGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:06:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53851 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiA0TGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 14:06:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84526174D23;
        Thu, 27 Jan 2022 14:06:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jXnerrK0sGQx9bH/4c6BuHZYaAHJpuldcS1Yy4
        w0qYU=; b=YciBR+AvbyIcquSZweblQRF8Y/Sn222Qi3wYKHmC38+RfxtDhDTLvT
        /fBCTH4WFUkslLD+TDSdcSUUVV4KyXedXN1y8D6dyQqrTPPqDMg/v77PRbisCK3t
        qhLWaya5oqtHbr8V42M4ZsmC2SpzVFu2O7mfT884DF2Dc6HcAcVJo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CD17174D22;
        Thu, 27 Jan 2022 14:06:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E8C4F174D21;
        Thu, 27 Jan 2022 14:06:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mirco Babin <mirco.babin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git-Gui: Can the "push" button optionally be
 removed/disabled/hidden ?
References: <CAFgk54=iKT=vjkDT8-QF15LE3B-6BVCWUK5d5_J4SmYPLNuB1w@mail.gmail.com>
Date:   Thu, 27 Jan 2022 11:06:35 -0800
In-Reply-To: <CAFgk54=iKT=vjkDT8-QF15LE3B-6BVCWUK5d5_J4SmYPLNuB1w@mail.gmail.com>
        (Mirco Babin's message of "Thu, 27 Jan 2022 13:06:53 +0100")
Message-ID: <xmqq8rv12e2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 402CF716-7FA4-11EC-9A76-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mirco Babin <mirco.babin@gmail.com> writes:

> Dear Git Gui maintainers,
>
> Is it possible to remove/hide/disable the push button via a
> commandline parameter ? And if not currently possible, could such
> functionality please be added ?

Just a comment from sideline; I am not involved or invested in
git-gui that much.

Why should "push" be so special?  Should other operations like
"pull", "stage", etc. that makes changes also optionally be hidden?
Where does this stop?

If "push" is not doing something useful for you, would there be a
way to make it more useful by allowing options that are not passed
to the underlying "git push" to be passed?

Thanks.
