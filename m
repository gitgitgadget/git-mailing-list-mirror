Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD05203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 20:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbcGVUAY (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 16:00:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752160AbcGVUAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 16:00:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FA1A2E290;
	Fri, 22 Jul 2016 16:00:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GDRCQ8Vg6CSs0H1r+p9Ygocv+3g=; b=DJ103T
	nM9zIiiRqdmL3XLCxxXw7iM6Jv7h+yUFTGsJFwDyRNXCPGbPRLX8smVhpAcgfc9/
	SBLobkrHqMDLtbDmAsgkgtzjSfTLN6Dj8H7mjLRcx0OAx8ZcpZX28avj8d6jbn1e
	eOWuHr6Xsi6jdOLVCQS9l0t9996WI1xVFUKXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLjxqzGyIpXAXa6E/J7fzdZMe+E5U52w
	UXlCYKGDcfXNWYKiHsX8wFKQapAChLLuntcJkrny1vEiSW4bFOSo07feRfOR0GVf
	S5FAYISLDGs7VxkNWvH3EDgy7NRka4xdYz/VogykvHUDUKgGWL3IkhoNqY9ySxmJ
	MZ1TpBh0fg8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56DFA2E28E;
	Fri, 22 Jul 2016 16:00:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CFDEF2E28C;
	Fri, 22 Jul 2016 16:00:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] submodule-helper: fix indexing in clone retry error reporting path
References: <8c0e116b-b604-ee83-197a-538eedf6e0ea@kdbg.org>
	<4d40da99-2f66-a380-840f-1828dc5b9324@kdbg.org>
	<xmqqeg6la2da.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZCt2iZNc7VkkcW1bTnwF9YrDi9zPi0p7=-7aDVe=0dzg@mail.gmail.com>
Date:	Fri, 22 Jul 2016 13:00:19 -0700
In-Reply-To: <CAGZ79kZCt2iZNc7VkkcW1bTnwF9YrDi9zPi0p7=-7aDVe=0dzg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 22 Jul 2016 12:50:13 -0700")
Message-ID: <xmqq1t2la1f0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBFE33FE-5046-11E6-AFD6-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I expect I'd queue these two instead, after seeing Acks from Stefan.
>>
>> Thanks.
>
> Sure. Please take these 2 patches instead of mine.

OK, I've already queued yours but I haven't started today's
integration cycle yet (I first pick up new topics and updates and
review them in isolation, and then re-review them after rebuilding
jch/pu branches in a separate phase), so I'll replace it with these
two patches.

Thanks.
