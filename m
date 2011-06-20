From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Mon, 20 Jun 2011 15:30:56 -0700
Message-ID: <7vboxsb0f3.fsf@alter.siamese.dyndns.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
 <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
 <7vk4cgb24p.fsf@alter.siamese.dyndns.org>
 <20110620220027.GD32765@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 00:31:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYmzp-0003rY-Qy
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 00:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137Ab1FTWbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 18:31:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab1FTWa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 18:30:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C59D6968;
	Mon, 20 Jun 2011 18:33:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2vXnf8QYiMXnVuweOlmrLMtf3wo=; b=DE69vx
	lBGhzHFB6AmHiS1MYM9SFqy+Wqx81YYM5c1kExAT3YrGxBQfE26Lszv0zJjmgHs9
	ZjlCooHEfync9NBYnsirlvy6dOkGtBjL58n7wizc6JDbG+QctMkIcZhLNDHKE548
	oqlt3cPxk8jGGZncScqkAtW1bslUpOO87buJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fiiCJ2QR8Ku4VTJsPGCFeUHwy6ylOg3v
	eP2k7lwqjPL08lZLGVfxUBbjLilUjw92rq9w+SbgatwDFeIXtXJ29g/yH6HSt3GM
	Zyv00jg2Ap7Jr+gFc5oAzYlEzCzP/WD+ckkQHFQFHJnzolpg1c3+UnLgcGF0ZML0
	TGv8MabnDJ0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 23CE06967;
	Mon, 20 Jun 2011 18:33:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8364E6966; Mon, 20 Jun 2011
 18:33:10 -0400 (EDT)
In-Reply-To: <20110620220027.GD32765@one.firstfloor.org> (Andi Kleen's
 message of "Tue, 21 Jun 2011 00:00:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47076398-9B8D-11E0-88EB-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176101>

Andi Kleen <andi@firstfloor.org> writes:

>> I would need to clarify with s/introduce noise/introduce more noise/; the
>> existing codebase is not noise-free.
>> 
>> But I do not see much point in making things worse, only to squelch
>> "reaches end of non void function" warnings that will be given under the
>> NO_NORETURN workaround configuration.
>
> Can you please give specific guidance what I should do to make
> the patchkit acceptable?

I am inclined to apply only 1 and 3, which is what I already have on 'pu'.
