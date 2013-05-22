From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Wed, 22 May 2013 09:36:03 -0700
Message-ID: <7vy5b7j7kc.fsf@alter.siamese.dyndns.org>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
	<519C7431.8050208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 22 18:36:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfC1M-0008Jn-PN
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 18:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238Ab3EVQgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 12:36:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63031 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754506Ab3EVQgG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 12:36:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A619C20CD1;
	Wed, 22 May 2013 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AJejihRtS5pzoa6omGrMTYgNeYM=; b=tr55jI
	zrM+xbtCL1Y4PudieUdoF08tw0Ov8l22M8L6HP6osWKVZWlonltx/+J9q5C3TLVC
	NaW+8wztq/Cz4a74rUSccMHfwJOq1hVX8ryy66gDQHJKp06jOjX/VVrshYq5/zkD
	PjgPyAIZ/v+3M/5wbFIUNcBedXbk/UsujSk0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gWD9mlhFg0qmeXvbOm/P8OnY5C0rTj7E
	4UYI77qwU6ZTVcH4WryVfwd5BHdBqSmIfhVxAGtS4ccGJKmvG0BcIktrd4qUNbM8
	HjtR98xMht76fTpoOA2aIfYO1tuFY+FYduqq/IwsM3nCn1qsKtClkIAh6qv4dHB0
	jxFUsnQPwU4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D46020CD0;
	Wed, 22 May 2013 16:36:05 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08D9A20CCB;
	Wed, 22 May 2013 16:36:04 +0000 (UTC)
In-Reply-To: <519C7431.8050208@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 22 May 2013 09:30:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B26BCC70-C2FD-11E2-B11E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225173>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> * mg/more-textconv (2013-05-10) 7 commits
>>  - grep: honor --textconv for the case rev:path
>>  - grep: allow to use textconv filters
>>  - t7008: demonstrate behavior of grep with textconv
>>  - cat-file: do not die on --textconv without textconv filters
>>  - show: honor --textconv for blobs
>>  - diff_opt: track whether flags have been set explicitly
>>  - t4030: demonstrate behavior of show with textconv
>> 
>>  I think this is ready for 'next'; not that it matters during the
>>  prerelease feature freeze.
>
> Oh, I'm sorry, I thought we were still in discussions about the default
> mechanism (config or attributes) and the implementation (tacking context
> onto each object)? Therefore, I didn't hurry to polish and follow up
> over my vacation. I'm not sure I had smoothed out all minor things
> (honor/obey and such) when the object struct size issue came up. I'll
> check today or tomorrow. (Freeze, yes, but we don't want too many next
> rewrites, and one is coming soon...)

I thought this was fine as-is, but we can kick it back to 'pu' and
replace it with a reroll after 1.8.3 if that is necessary.

Thanks.
