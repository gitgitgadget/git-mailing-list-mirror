Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 938F71FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 19:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbcFTTsM (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 15:48:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754504AbcFTTsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 15:48:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E29A626238;
	Mon, 20 Jun 2016 15:48:08 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f+4tmocg/SZKNnNjLPU91abLjWI=; b=Tuykln
	GFvgP6qX7gCH269MJexN573G+WcJTlNGkSNxdZNvxjwgCJ9tn6hNN7p+2LehyeGO
	NOHIFbrCx/yeOimvJ/UvBfnH7EAu2BuEcY3VUWovQFy6jW/X6GYYtq3SFvKBq6Fp
	W5wdj4Cn37Pa8efDJUNmpBjLy2eVFuYx3p0LE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eDtP8ZqqgZ0UlbK5uQbgHNXnFWQRI2KA
	ZgUPAFfbIWtbGn9GxNleBXCNLyPMyJDyNMtMRSGg8OSRKbQGreu7LGk7kC/NpK6E
	WDBk1YmAaXwn9fWtsVCNRQvc9iooQCnfuH6udCiFD8VVxR928SQp5KajezkRSELr
	j/cbs1MpVlI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D8F0326237;
	Mon, 20 Jun 2016 15:48:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60F8726236;
	Mon, 20 Jun 2016 15:48:08 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: [PATCH] perf: accommodate for MacOSX
References: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de>
	<9A11C3D1-3DAC-489F-BDF9-F4D409E8D3F7@gmail.com>
	<alpine.DEB.2.20.1606200840350.22630@virtualbox>
Date:	Mon, 20 Jun 2016 12:48:06 -0700
In-Reply-To: <alpine.DEB.2.20.1606200840350.22630@virtualbox> (Johannes
	Schindelin's message of "Mon, 20 Jun 2016 08:45:29 +0200 (CEST)")
Message-ID: <xmqqa8iftzex.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E99A3634-371F-11E6-94F1-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 19 Jun 2016, Lars Schneider wrote:
>
>> > On 18 Jun 2016, at 15:03, Johannes Schindelin
>> > <johannes.schindelin@gmx.de> wrote:
>> > 
>> > As this developer has no access to MacOSX developer setups anymore,
>> > Travis becomes the best bet to run performance tests on that OS.
>>
>> We don't run the performance tests on Travis CI right now.
>> Maybe we should? With your patch below it should work, right?
> ...
>
> Yeah, well, I should have been clearer in my commit message: this patch
> allows the perf tests to *run*, not to *pass*... ;-)

OK, Lars, do we still want to take this patch?  I am leaning towards
taking it, if only to motivate interested others with OS X to look
into making the perf tests to actually run.
