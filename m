Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64E662018A
	for <e@80x24.org>; Fri, 24 Jun 2016 16:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbcFXQoy (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 12:44:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751132AbcFXQox (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 12:44:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AC3025CEE;
	Fri, 24 Jun 2016 12:44:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6R9NZ6RB69nMSYRQlNKkS9YwYTc=; b=e5a/i2
	iuJSKfN1jnfY5S6pAQn86Isoc5VBcfiMDUGUt4ofcxuhA6GXnzXh7wIbBlkWe6gc
	wSHNrOJz8pPcE9V54pWf6DA/R6glKxxyXjVSyhIhWxa4ImvL6wNALM8t3hBuL6+W
	jiXrDI9O34VFRW1Kih3il3S+Nb8Qja2QIqA/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fAc5qMaNbf/tk/PofLJgt0iaxgyrshyr
	DMXOMGhc60KVbhr0ULiXM4BpCCmBoqjlyRQYzHaXkE/aVRMZTajzxSGUakr1W0zY
	3FoOd7uq0S1EKm7KPcAggRpmObQnFuPCWTs8F7YSm4BfqmIWJPCCzf+uIYCjCvb3
	T+yqsk/Z1oo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7446D25CED;
	Fri, 24 Jun 2016 12:44:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 044F725CEC;
	Fri, 24 Jun 2016 12:44:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
Subject: Re: name for A..B ranges?
References: <0648000B273C412AB7140AE959EBC99A@PhilipOakley>
	<20160624160943.GA3170@sigill.intra.peff.net>
Date:	Fri, 24 Jun 2016 09:44:49 -0700
In-Reply-To: <20160624160943.GA3170@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 24 Jun 2016 12:09:43 -0400")
Message-ID: <xmqqh9cih6ym.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8E6A24A-3A2A-11E6-8DF1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jun 22, 2016 at 08:25:59AM +0100, Philip Oakley wrote:
>
>> Is there a common name for the A..B range format (two dots) that would
>> complement the A...B (three dots) symmetric range format's name?
>> 
>> I was looking at the --left-right distinctions and noticed that the trail
>> back to the symmetric range description was rather thin (it's buried within
>> gitrevisions:Specifying Ranges, and even then its called a symmetric
>> difference.
>
> I would just call it a range, or possibly a set difference. But I don't
> think we have any established naming beyond that.

Yup, I think "range" is the commonly used word in discussions here.
When inventing A...B as a new thing in addition to A..B, we called
the former "symmetric difference", and what is implied by that is
the latter is "asymmetric difference"; we do not say that unless we
are contrasting between the two, though.
