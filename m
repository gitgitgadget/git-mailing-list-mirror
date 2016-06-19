Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7834320189
	for <e@80x24.org>; Sun, 19 Jun 2016 01:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbcFSBT1 (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 21:19:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751144AbcFSBT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 21:19:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E57024642;
	Sat, 18 Jun 2016 21:19:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=99FtorMfWmqtZtji/Qet7x/eF3Q=; b=rn4eNz
	dbar0kCbG4YP7LIJX7Ww46cXg6ydKJFbM4eESbBPkq5g2T2Gjp9aDQ20CFm4Lqyi
	kWXmev7lPUuaIM+W5JWjdiJlPyu3kaUUbEZnmIq3dRlehTOIyZpl4wzsrMyj/eAI
	ahRzn/y0offRvOwB4HyemCumQ99LqWf2AfBbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v1MNWAg4hiox0gFWBNTEuM5yZN3cTerw
	uzTGhbrkYmOvXpP7tw0s4pzUpMKDLwGOFMUIS83o4LLob4LL7azH0AxtBjIoypPr
	275mz7OvTVGO4y6KxhTPOcXyaC4NpuE5OmeGbxE6J/l3C6VRkZoLzQcw5/02hj1q
	objX0Y89QDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5588B24641;
	Sat, 18 Jun 2016 21:19:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3FB824640;
	Sat, 18 Jun 2016 21:19:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2016, #08; Thu, 26)
References: <xmqqeg8otowp.fsf@gitster.mtv.corp.google.com>
	<20160527003621.GB26262@sigill.intra.peff.net>
Date:	Sat, 18 Jun 2016 18:19:23 -0700
In-Reply-To: <20160527003621.GB26262@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2016 20:36:21 -0400")
Message-ID: <xmqqy462x9es.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC096E14-35BB-11E6-849F-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, May 26, 2016 at 03:50:14PM -0700, Junio C Hamano wrote:
>
>> * jk/upload-pack-hook (2016-05-24) 6 commits
>>  - upload-pack: provide a hook for running pack-objects
>>  - config: add a notion of "scope"
>>  - config: return configset value for current_config_ functions
>>  - config: set up config_source for command-line config
>>  - git_config_parse_parameter: refactor cleanup code
>>  - git_config_with_options: drop "found" counting
>> 
>>  Allow a custom "git upload-pack" replacement to respond to
>>  "fetch/clone" request.
>> 
>>  Will merge to 'next'.
>
> I just sent a replacement for the fourth patch that avoids the t/helper
> problem. It's probably worth dealing with before even hitting "next" so
> as not to break bisection.
>
> You should probably hold off on merging the top one. The discussion
> stalled because I was on vacation, but it has resumed now (the earlier
> refactoring bits are uncontroversial, I think).

And then it seems nothing happened.  Can we settle this soonish?
