From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] contrib/subtree: Add --unannotate
Date: Tue, 15 Jan 2013 20:31:03 -0800
Message-ID: <7vy5ftzr3s.fsf@alter.siamese.dyndns.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
 <1357646997-28675-4-git-send-email-greened@obbligato.org>
 <7vehhvecoy.fsf@alter.siamese.dyndns.org>
 <87vcaxq0ez.fsf@waller.obbligato.org> <87y5ftojoj.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Nylen <jnylen@gmail.com>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Wed Jan 16 05:31:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvKf0-0004YZ-10
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 05:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758421Ab3APEbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 23:31:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758392Ab3APEbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 23:31:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25572B1B2;
	Tue, 15 Jan 2013 23:31:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qv6TDlGfZxpOzIBP41m+QrdFoxM=; b=p1tBJO
	hP78rXsJnnvTUPR1F1/WOpmih45OKi4MbssSKqQrR+sX3nxFMyiaB0Ji7Bh8snDP
	+lk5FN8hLwMxk1arTYjD95ceNkz5wE3+fpfxoDCuKybJNUr+t4Wsj5r9YrBLJcUr
	cD1a1U0ibtLpExSaBWlpK1sHcS7KOx1g/knWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=twDLpiQuUSa1GHZt8nS6IRgGlmWQUssk
	vwO3o3IamozGqXxR/qa2s0x9KChlXbrGvcLFKVCHEeqZDpY4NH3RJcidR+RvGi9t
	i6G1yoDrSJH3TbFzIQxVl9oylXOnFxlUNbndtZwAk/sxGuhJuwz2eCyeXL2F7DEu
	u0dCWotViEE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19106B1B0;
	Tue, 15 Jan 2013 23:31:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AF33B1AD; Tue, 15 Jan 2013
 23:31:05 -0500 (EST)
In-Reply-To: <87y5ftojoj.fsf@waller.obbligato.org> (greened@obbligato.org's
 message of "Tue, 15 Jan 2013 22:06:52 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AA12A6C-5F95-11E2-AEA4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213726>

greened@obbligato.org writes:

> greened@obbligato.org writes:
>
>>> I think this paragraph inherits existing breakage from the beginning
>>> of time, but I do not think the above will format the second and
>>> subsequent paragraphs correctly.
>>
>> Ok, I'll take a look.
>
> I don't know what "correctly" is but it is at least formatted in a
> similar manner to the other options.

That is what "inherits existing breakage" means ;-)

The first paragraph is typeset as body text, while the rest are
typeset in monospaced font, no?

It should be more like this, I think:

        --option::
                First paragraph
        +
        Second paragraph
        +
        And third paragraph
