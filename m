Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E21D1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 22:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbcFQW3x (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 18:29:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750840AbcFQW3w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 18:29:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB84125C89;
	Fri, 17 Jun 2016 18:29:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=00/eun4ea1uFz2jYISe56OQLhjk=; b=PZBv/x
	C9tFcKi3z0YcRyQxIlCYfsAyYByxMidbYjzm30og5f3Wk+O+bfGhtt0F/OEJIFo8
	i1V5urE6mPCBwdF5B70JR8it1h4o49Gy/8fYIiwPmUVgTpN8+kkU08LtZrB1lpw0
	PZf1w1ZqrorA8wOPnERQWS7KCg6yHrgngqGZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=li41siXVutS6yr6qnUgzLdOil3mAHQvH
	n4xyiE90DxlkHBH4TrLsC1zMzW77R/wf5PqG8Vp49YmeUZxMp7sQyoOwxK/+LOJy
	Nco3963Z1QfGVVhODKqAytT6Xs/d7UG6XaPyqeiFIAQXz8cSUwt1RrUDXOeBFhDh
	CkOFUjhk9iE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D339D25C88;
	Fri, 17 Jun 2016 18:29:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CF1825C87;
	Fri, 17 Jun 2016 18:29:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 00/38] i18n and test updates
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
	<xmqqoa6zzf3g.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 17 Jun 2016 15:29:48 -0700
In-Reply-To: <xmqqoa6zzf3g.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 17 Jun 2016 14:21:23 -0700")
Message-ID: <xmqqbn2zzbxf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 013C019C-34DB-11E6-9E84-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>
>> Interdiff included below.
>>
>> Vasco Almeida (38):
>>   i18n: builtin/remote.c: fix mark for translation
>>   i18n: advice: mark string about detached head for translation
>>   i18n: advice: internationalize message for conflicts
>>   i18n: transport: mark strings for translation
>>   i18n: sequencer: mark entire sentences for translation
>>   i18n: sequencer: mark string for translation
>>   i18n: merge-octopus: mark messages for translation
>>   merge-octupus: use die shell function from git-sh-setup.sh
>
> octopus.

> The last 5 patches seem to have been lost...
>
>>   i18n: init-db: join message pieces
>>   i18n: submodule: join strings marked for translation
>>   i18n: submodule: escape shell variables inside eval_gettext
>>   i18n: unmark die messages for translation
>>   i18n: branch: mark comment when editing branch description for
>>     translation

Now we see them ;-)  Thanks.
