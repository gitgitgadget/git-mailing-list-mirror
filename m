From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2014, #01; Tue, 3)
Date: Wed, 04 Jun 2014 13:50:05 -0700
Message-ID: <xmqqwqcwtn5u.fsf@gitster.dls.corp.google.com>
References: <xmqqzjhtvdua.fsf@gitster.dls.corp.google.com>
	<538F7050.3040103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 22:50:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsI8b-0005WB-5D
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 22:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbaFDUuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 16:50:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65301 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbaFDUuL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 16:50:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AAB0C1B268;
	Wed,  4 Jun 2014 16:50:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sfhJUPNAEKAVYXVUsZ9qADXcw8c=; b=OmBzLB
	h42lfFAxQEoo79tFec6tkVp4mw2AX8PZCuk00rvdWXDsTONvV4xokdvT1eyWZKEU
	GAgw8L7bE7cN6bKcqGOC+ZjkWfaFgnx/zFy2mnZQOcsGQKHHkV6BpbfE4zOmypd2
	7UrKNxYQnXh7/uBw3SU3j3vbYk7LAz3npr+wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ny2YtKkK3S63MnhKCjHe+OuvLScli0jB
	4fXlLQyzDuOQac8bYlPdceEmcbGodnLC0/kjQhGawNu3vTSnOAIdinTBD+Lgx1En
	yi2jGw4Kc0n+VMP5Q6bZd72wLmY82gDndkg4+KzpreFWAxAgP2GlYN+4b+WzD77U
	dNGfaTi7jXg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A1D8B1B267;
	Wed,  4 Jun 2014 16:50:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EA03D1B25E;
	Wed,  4 Jun 2014 16:50:06 -0400 (EDT)
In-Reply-To: <538F7050.3040103@web.de> (Jens Lehmann's message of "Wed, 04 Jun
	2014 21:15:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF765EBA-EC29-11E3-8D2C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250779>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 04.06.2014 00:16, schrieb Junio C Hamano:
>> * jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
>>  - commit -m: commit staged submodules regardless of ignore config
>>  - status/commit: show staged submodules regardless of ignore config
>> 
>>  There also are a few patches Ronald Weiss and Jens are working on
>>  polishing around this topic, and a patch from Jens each for gitk
>>  and git-gui.
>> 
>>  Waiting for the dust to settle until picking them up all.
>
> To me it looks like the dust settled enough around that part of the
> topic and I remember consensus about that change. But it would be
> nice to have the gitk and git-gui patches in at the same time.

Yes, what I meant was that after the dust settled, it may turn out
that these two may need to be adjusted.  If these two commits can be
used without any change as a base for any further development, that
is good---shall I move it back to "Cooking" category?

>> * jl/submodule-recursive-checkout (2013-12-26) 5 commits
>>  - Teach checkout to recursively checkout submodules
>>  - submodule: teach unpack_trees() to update submodules
>>  - submodule: teach unpack_trees() to repopulate submodules
>>  - submodule: teach unpack_trees() to remove submodule contents
>>  - submodule: prepare for recursive checkout of submodules
>> 
>>  An RFCv2 exists ($gmane/241455) with sizable review comments.
>>  Expecting a reroll.
>
> Will do, but only after I rerolled the submodule test harness
> ($gmane/245048) soonish, as I intend to reuse the infrastructure
> introduced there for tests.
>
>> * jh/submodule-tests (2014-04-17) 1 commit
>>  - t7410: 210 tests for various 'git submodule update' scenarios
>
> Will look deeper into that one in the next days, we really need more
> test coverage in that area.

OK. Thanks.
