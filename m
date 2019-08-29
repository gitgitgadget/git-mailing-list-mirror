Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D833B1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 03:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfH2D5r (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 23:57:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54526 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfH2D5r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 23:57:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60D7686C4B;
        Wed, 28 Aug 2019 23:57:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VyTqwKKD2N0BCyv7f16xkECX25c=; b=cgK0CH
        q3M09+oBrtU+jRLBJkGX7hAMpUKyiPq5Z9lEMHJlEvaPg+eJJ9dlj7HlrNMvE4LF
        PBzEDgtRqTi2mA8byVfT+cQ8fZdlVVBJ7kvkDHQTDqoXSnuEp5Sp1WcEVihFtFr/
        HVmr6i28QQuK/psNXFGyQt0nJtPJ5fA2MpHwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UPdBEFZLHh9xB+J/WVYCHGEsmpU7g6AV
        CfhAixD3XiKGG7B5ylqcZe6TeBeFr+s827DsMpxpxawOwbhAwDmQLP04WR0LD9OQ
        DObWeNo12tyMUDLXu1dfJ2bAXl04a3npvqAgzMZdPf4kIYrklElSOgoEzXNgX86y
        ekGNqY+83AY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 599E086C4A;
        Wed, 28 Aug 2019 23:57:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88A3486C49;
        Wed, 28 Aug 2019 23:57:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Gadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
        "Philip.McGraw" <Philip.McGraw@bentley.com>
Subject: Re: [PATCH 1/1] git-p4: auto-delete named temporary file
References: <pull.303.git.gitgitgadget@gmail.com>
        <CANg4QoGSVQWG3QXzoiA8oDsjXaXGoZ+WMNLSPpu75eJWdrWxLQ@mail.gmail.com>
        <xmqqo90bj2ye.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1908281424240.46@tvgsbejvaqbjf.bet>
Date:   Wed, 28 Aug 2019 20:57:40 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908281424240.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 28 Aug 2019 14:25:28 +0200 (CEST)")
Message-ID: <xmqqpnkozkqz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26CD059A-CA11-11E9-9F2A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes, this was me trying to re-send the patch via GMail's web UI because
> the first time GitGitGadget sent it, it did not get through (only the
> cover letter did).

As long as that was manual screw-up, while fixing some glitches in
the machinery, that is fine.  I care about automation running
smoothly.

Thanks.
