Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50015C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 18:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbiAJSgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:36:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60206 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbiAJSe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:34:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AFE3E111F43;
        Mon, 10 Jan 2022 13:34:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pW6t8HSvq4kPSAjV7ZyHUYvXAt/ODOTwP7Vjmy
        1Q0bY=; b=H4f/08RQAzsYPTx1h24wkEs5cJCXkx1tm5ZJqF9/fj+MSSOk00UnO5
        Q65NTNr68IMyFnOejMnKBSuFarQN96DpAbbjFoxCpBkL9CIrNdMbQvwoqw4KMCPk
        oxL5ZLPm+jeFo7i2Ubs/6viw6uFgYP7JEV69U/oxbQjpfLrwURz8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7AF8111F42;
        Mon, 10 Jan 2022 13:34:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CDA8111F41;
        Mon, 10 Jan 2022 13:34:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        congdanhqx@gmail.com, git@vger.kernel.org, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
References: <cover.1641440700.git.dyroneteng@gmail.com>
        <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
        <nycvar.QRO.7.76.6.2201071401240.339@tvgsbejvaqbjf.bet>
Date:   Mon, 10 Jan 2022 10:34:26 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2201071401240.339@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 7 Jan 2022 14:03:37 +0100 (CET)")
Message-ID: <xmqqwnj7zbgt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F170D790-7243-11EC-8201-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The original rule was introduced by commit:
>>
>>     https://github.com/git/git/commit/28c23cd4c3902449aff72cb9a4a703220be0d6ac
>
> Doing this in 9/9 is too late, by this time you already introduced the
> code site that requires this workaround.

Good to point this out.  Thanks.
