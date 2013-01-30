From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/11] unify appending of sob
Date: Wed, 30 Jan 2013 09:37:54 -0800
Message-ID: <7vhalylggd.fsf@alter.siamese.dyndns.org>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <20130128034831.GQ8206@elie.Belkin> <7v7gmxzwkj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 18:38:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0bc5-00055q-9v
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 18:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825Ab3A3Rh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 12:37:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754299Ab3A3Rh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 12:37:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D812BBED9;
	Wed, 30 Jan 2013 12:37:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z0J8xsiF0bh7geIgPGhBUxGcYGU=; b=SyG7ff
	3Qe6C0bX2TWLptjS2zb4xQQRDJty2Y2pMiI7muMs7IIw5h4zy8PRawUT8neiAIE1
	AmK9QCa6O0pn8coT9Ya1Ttm/YZN0g6CsAQTah/v277pYMMGQwBXCUGXtMKB23zfI
	LfaxhRNBKIrY2pBptja5XjZHFZY7sN6IL7yF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KtVhMgGHrSvAZJka/pa3ANjNVkgZmVSg
	+oedbftMd8M6IQB6svJA68y9I6dw6+0UcGW3gp2zMn3M2dhke/l2rzSxxy18uuca
	U2Bg3naJSvJA1Z+bf0JIRebE/I/rB3qQMOj0bqT/NGwTGSIJCuzDjfREv3YZbjAg
	PbDy4ZkNTyM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBE5BBED8;
	Wed, 30 Jan 2013 12:37:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DC9CBED4; Wed, 30 Jan 2013
 12:37:56 -0500 (EST)
In-Reply-To: <7v7gmxzwkj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 Jan 2013 21:49:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C844A9BA-6B03-11E2-B18A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215042>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Brandon Casey wrote:
>>
>>> Round 3.
>>
>> Thanks for a pleasant read.  My only remaining observations are
>> cosmetic, except for a portability question in Duy's test script, a
>> small behavior change when the commit message ends with an
>> RFC2822-style header with no trailing newline and the possibility of
>> tightening the pattern in sequencer.c to match the strictness of
>> format-patch (which could easily wait for a later patch).
>
> Thanks for a quick review.  I agree that this series is getting very
> close with your help.

Unless Brandon and/or Jonathan wants to have another chance to
excise warts from the recorded history by rerolling the entire
series one more time, I think what we have queued is in a good
enough shape to merge to 'next' and any further improvement and fix
can be done incrementally.

OK?  Or "stop, I want to reroll"?

I'll wait for a day or two.
