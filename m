Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686AAC433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 22:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376582AbiDCWmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 18:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiDCWmH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 18:42:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460BB29CA6
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 15:40:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF72C1132EE;
        Sun,  3 Apr 2022 18:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X38x8Fz0TL8PRXSNhvl1sZ/N9TWtQbh9AZBxZd
        NlSD4=; b=Garh3k9bI6pStbE6pae5B9CqTgQagAb5q3/FcJmpQNMy4UC9kRelID
        ewBAnCs69x/55FqfZSQHZ59q19Z7l48CQmuBr9G8n/GjLgzhFZIjtmIZRqp+2+GZ
        6HZQrLdbNUFIwOxXTRRKe/4oDVV7km8jJsiA/G+P1+l41BA6dzdwo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C851A1132EC;
        Sun,  3 Apr 2022 18:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59F6C1132EA;
        Sun,  3 Apr 2022 18:40:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Eric Wong'" <e@80x24.org>, <git@vger.kernel.org>
Subject: Re: any real-world SHA-256 repo users out there?
References: <20220403084258.GA27999@dcvr>
        <Ykna7sJP8ktvNLor@camp.crustytoothpaste.net>
        <02b501d84784$0e904260$2bb0c720$@nexbridge.com>
Date:   Sun, 03 Apr 2022 15:40:07 -0700
In-Reply-To: <02b501d84784$0e904260$2bb0c720$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Sun, 3 Apr 2022 13:55:45 -0400")
Message-ID: <xmqqa6d1u6yg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03AB164A-B39F-11EC-9CA9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

>>I have some indefinite plans to improve the support for
>>SHA-1/SHA-256 interop in the future, as well as port SHA-256
>>support to libgit2, but those are dependent on some things which
>>are not certain (but very likely) to occur.

That is encouraging to hear.

SHA-256 interop is one of the things I want to see appear sooner
rather than later (it would be what I would answer to the popular
"Git Rev News" question, if I were interviewed).  I certainly would
want it to materialize before I retire ;-)

>>I strongly encourage folks to add SHA-256 repository support to
>>tooling since it's likely going to become more popular in the
>>future.  I have some local SHA-256 repositories on my systems and
>>they appear to work fine.
>
> Our tooling works correctly regardless of the choice of SHA-256,
> but have been waiting for GitHub et. al., to provide
> capabilities. I would welcome interoperability. What help do you
> need?
