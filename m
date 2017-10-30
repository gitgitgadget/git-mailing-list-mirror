Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E4A202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 01:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdJ3B13 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 21:27:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60843 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750764AbdJ3B12 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 21:27:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5D72BB413;
        Sun, 29 Oct 2017 21:27:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W1IY9k35V1TC81kN/ykzOOdMcrk=; b=SVNtax
        K5dYyqeTkCoWgsnWMv+i6o9dtxKMraV2J4EGfF4uvGAEeOI7ULt2jOkqoP8h6J1S
        f9ZecILABBzKig2WAVZe07Uw5vgtonFTD6BAbxUqjpQpKo0vdP7PxAo9MU0cJXsf
        lYVw56JRAFJH9DIPFk+nZYLL44W6xG10S80us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=psOWVk+r3fq0fWVK6Um/yG9EZoKFNp+d
        Q3oV8ofCBtqb8pKD0AXAOqmFJ1VK6mqxhjj4SrJnItt5APU4c7Nx1rRUJBdEu0h6
        OK08uAK02ufpXpYMZlvB934UOje8ZfXy/bUoyuEy39dd6oWc85f5TzG2fXKmbUkE
        QbSZNid/VI8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF0B0BB412;
        Sun, 29 Oct 2017 21:27:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B531BB411;
        Sun, 29 Oct 2017 21:27:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #06; Fri, 27)
References: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710291409390.6482@virtualbox>
        <xmqq7eve9gw4.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710291614020.6482@virtualbox>
Date:   Mon, 30 Oct 2017 10:27:25 +0900
In-Reply-To: <alpine.DEB.2.21.1.1710291614020.6482@virtualbox> (Johannes
        Schindelin's message of "Sun, 29 Oct 2017 16:18:43 +0100 (CET)")
Message-ID: <xmqqfua18lxe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D45F3BE-BD11-11E7-8DCC-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Let's make this more convenient for *both* of us. You can find one fixup
> in the `jr/ssh-wrappers` branch at https://github.com/dscho/git, and the
> second one at `cc/git-packet-pm`. Both should fast-forward from your
> branches of the same name.

Thanks.  

I didn't follow these lenghthy back-and-forth closely enough to
notice that they boiled down to one liner each that needs squashing
;-)

Fetched, looked at, and signed off before merging them to 'pu'.

