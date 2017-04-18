Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A9F1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 00:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754196AbdDRAOZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 20:14:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61875 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751634AbdDRAOY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 20:14:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A05B73CD3;
        Mon, 17 Apr 2017 20:14:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4aLiv3I9Q8ZD8pdZFKxc6N/e1lQ=; b=roZP03
        ale7iVXEFwaWLVp+zUiBvoX1VJx4DqW4YdVfXUfMGN4Z0nWChS3BjiymIpVL+eyn
        nNaf3+oDeIpksC0/ZisgnueVRsVmkuH+m+ykFxlUx1vdLRru/2tIhX4X0Z7vck+P
        r6m/7K5izpI2auUOaFBjCXpg3akKTQHFBckpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DW3EoMpdvtoMFB7b6b+5mS/jrZiHc+3+
        H7848hghFT9sgK1s2Dz7pLFanGdmF/mvWagnDtKSEUmvsZyZi5glbNESnvkn0Y+M
        ahn3hujocE/GdReEVAQbI9FHWqBU+pq7cAAfH6kOMqXC5vur1cYoOTr1OnhAwya6
        IGa5ixHd1fU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01EEE73CD2;
        Mon, 17 Apr 2017 20:14:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 701A673CD1;
        Mon, 17 Apr 2017 20:14:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] rebase --signoff
References: <20170415144103.11986-1-giuseppe.bilotta@gmail.com>
        <xmqqshl7ik21.fsf@gitster.mtv.corp.google.com>
        <CAOxFTczhfvzhrSiCj7SgLXbO3hrBW_QaDVZMpOqrij_hCJyCzg@mail.gmail.com>
Date:   Mon, 17 Apr 2017 17:14:21 -0700
In-Reply-To: <CAOxFTczhfvzhrSiCj7SgLXbO3hrBW_QaDVZMpOqrij_hCJyCzg@mail.gmail.com>
        (Giuseppe Bilotta's message of "Mon, 17 Apr 2017 16:12:19 +0200")
Message-ID: <xmqqinm2inc2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F939CAAC-23CB-11E7-BF14-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

>>  - How does this interact with "git rebase -i" and other modes of
>>    operation?
>
> A better question would maybe be how do we want this to interact?

If "git rebase -i/-m --signoff" will not do anything (which I
suspect is what we have here), we at least would want it to be
documented, or the combination be made to error out, I would think.

A better question can wait until that happens ;-)
