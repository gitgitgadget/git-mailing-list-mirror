Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA1C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbiAJRNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:13:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52720 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbiAJRNb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:13:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E81E1852DF;
        Mon, 10 Jan 2022 12:13:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SjFINrSLUSCWN/T1CqImY1DZ2OPOSrUZq9Qd8y
        QVU04=; b=GqqgWGsxgvTJ/T568gwxTE2/JF37YwStbwpE0sP0TXOadi8BAvejn9
        dSA2drLEAUD9Lgf/5HQx3Gk779LzxL1jq6HF51lXE3bwYpcE03TWSaSc+9xXa4R8
        ecGQAwFDNJX9sBlXUsrINUvv7SuyApsw/hmNpB3E6IX5kgW1RI8vM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 060411852DE;
        Mon, 10 Jan 2022 12:13:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6EF9B1852DD;
        Mon, 10 Jan 2022 12:13:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        steadmon@google.com, chooglen@google.com, calvinwan@google.com,
        workflows@vger.kernel.org
Subject: Re: Why GitGitGadget does not use Sender:, was Re: Review process
 improvements
References: <YbvBvch8JcHED+A9@google.com>
        <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
        <211222.86ee65pb60.gmgdl@evledraar.gmail.com>
        <20211222154534.b2gb22ghn2mpyeur@meerkat.local>
        <xmqqh7b0juk5.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201101401530.339@tvgsbejvaqbjf.bet>
Date:   Mon, 10 Jan 2022 09:13:27 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2201101401530.339@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 10 Jan 2022 14:03:01 +0100 (CET)")
Message-ID: <xmqqwnj71pl4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0E49236-7238-11EC-BAA1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin gave a more generally applicable answer to think about
this issue in <20211222213247.5dnj3zlj53lh6l32@meerkat.local> in a
separate thread last year.  I would not be surprised if GMail pays
attention to the reasoning he gave in that message and that is the
reason why it does not use the "Sender" as I hoped.  I expect other
e-mail providers should do the same.

Thanks.  
