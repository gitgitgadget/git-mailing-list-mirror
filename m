Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3EF720133
	for <e@80x24.org>; Fri,  3 Mar 2017 19:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbdCCTdH (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 14:33:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50466 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751584AbdCCTdF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 14:33:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB89B6485B;
        Fri,  3 Mar 2017 14:29:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wAZCPVMZQ9J/d5k+UpsEX4IiJJE=; b=YtuEWq
        Xnb5x1xGsQrGBSCWm9Xao0kTpvtLcYeCKIiDM8zgjaiCCg7jKJ6idqgMOSigjuRj
        /5ajfGcRCHuwGXjtfihYFy/N649E7lPJXIXjMID6fXHYlLenBRsNwo0dVkGuaxD+
        D5EoMLgqBLSPYx2J5ID+6VOOytQTccT2wFzv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oZWHA+x2FZjjpJ+i/WjAs8Hu9k/be865
        bvOWkkDO2XXUWPZurp4vNSpwSIyhlgAW/dAqiGkHaUWIV+IXl29Ohiw06jBel5dw
        1ObXEFWrwPI4KqjHWbd7O12AhSuc5WtVPm3HI/YAtC/MVOEqiwm+CB5A5OTS2z3j
        uiXC8mYsQdc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3EB46485A;
        Fri,  3 Mar 2017 14:29:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F7E764855;
        Fri,  3 Mar 2017 14:29:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org,
        davvid@gmail.com
Subject: Re: [PATCH 3/3] Remove outdated info in difftool manpage
References: <20170303115751.GA13225@arch-attack.localdomain>
        <alpine.DEB.2.20.1703031645470.3767@virtualbox>
Date:   Fri, 03 Mar 2017 11:29:37 -0800
In-Reply-To: <alpine.DEB.2.20.1703031645470.3767@virtualbox> (Johannes
        Schindelin's message of "Fri, 3 Mar 2017 16:46:36 +0100 (CET)")
Message-ID: <xmqqh93a88gu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEE46DE6-0047-11E7-B43A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Denton (or should I address you as Liu?),
>
> On Fri, 3 Mar 2017, Denton Liu wrote:
>
>> When difftool was rewritten in C, it removed the capability to read
>> fallback configs from mergetool. This changes the documentation to
>> reflect this.
>
> Thanks for pointing that out. But that is probably an oversight on my
> part, not an intentional change...

So, ... in the meantime we'll hold off of this removal from the
documentation and wait for the "capability" to get restored?
