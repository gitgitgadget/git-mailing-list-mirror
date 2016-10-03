Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1F120987
	for <e@80x24.org>; Mon,  3 Oct 2016 15:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbcJCPXK (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 11:23:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55854 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752399AbcJCPXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 11:23:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD9E441CB6;
        Mon,  3 Oct 2016 11:23:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3ZZyN73ZmF/jNkEISpWXExWhiLc=; b=qFDnl2
        ZT8AD0qmcl+vvKPskW0ID10d/AbtK1g4HqAU04g0tIARc+w36je/XeHjMuW/Ipwj
        q7ky/4e3SYlaDHUj5lJQ8m9RxFfAIhcbW8/iCXEoAekvdG0dD5ZeZzv0haFhRpH6
        cZ1xL7Fd0So/eiphA1uWk34KyWrjAORXxzijI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xp4dUCHsipqx67Rvh/Bm7CnhfJkUICYC
        6RmyeLMKB7CdXoGOPVLOPocnCtSaff2UYH6ZfPZUlD0UqkWsOkMT3Mj//YfVGSeV
        +QZfGrzLvpVbB0Hflb8M/4R0rteoRM3hspR10Q7tLxSWDeeO6kT0OdEPBB3KPyIF
        M5wOFADUtP4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4AE641CB5;
        Mon,  3 Oct 2016 11:23:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 508F241CB4;
        Mon,  3 Oct 2016 11:23:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
References: <cover.1475176070.git.jonathantanmy@google.com>
        <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
        <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
        <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
        <42332581-e47a-0fc8-ed5c-44e7e1c19341@google.com>
Date:   Mon, 03 Oct 2016 08:23:05 -0700
In-Reply-To: <42332581-e47a-0fc8-ed5c-44e7e1c19341@google.com> (Jonathan Tan's
        message of "Fri, 30 Sep 2016 13:23:28 -0700")
Message-ID: <xmqqa8el8nja.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4933C4F2-897D-11E6-B372-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On 09/30/2016 12:34 PM, Junio C Hamano wrote:
>>> 2) The Linux kernel's repository has some "commit ... upstream." lines
>>> in this position (below the commit title) - for example, in commit
>>> dacc0987fd2e.
>>
>> "A group of people seem to prefer it there" does not lead to
>> "therefore let's move it there for everybody".  It does open a
>> possibility that we may want to add a new option to put it there,
>> but does not justify changing what existing "-x" option does.
>
> To clarify, my patch adds the new option you described (to place it
> below the title instead of at the bottom of the commit message). The
> default is still the current behavior.

Ah, sorry, I missed that.  No objection from me on this point then.

Thanks.
