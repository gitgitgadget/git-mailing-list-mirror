From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag(1): we tag HEAD by default
Date: Wed, 03 Apr 2013 08:17:00 -0700
Message-ID: <7vvc8363v7.fsf@alter.siamese.dyndns.org>
References: <137ebfa428b16497287c55e552372df1087f1588.1364999181.git.trast@inf.ethz.ch>
 <7vzjxf64gn.fsf@alter.siamese.dyndns.org>
 <877gkjvecg.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 03 17:17:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNPRV-0006V2-Fh
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 17:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760979Ab3DCPRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 11:17:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760462Ab3DCPRM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 11:17:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C18212AF5;
	Wed,  3 Apr 2013 15:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YKrODwV/9YNvRh0/cOQGPcHsU6E=; b=QBnJiI
	uuV/gUBW0JqLjUb0XS9IdGKhRrWnq3XCWPE9B+A/docK06L49Vu5hEidIyL0BZoN
	Ioja4GOjI3BuWeR1bmhL77CcWiqi07BdD0ULo+jdrrvRkvtm8CF4LIOAoQvlTHip
	Ym57Vbx4fOZIsbmqKPSfle+lVtN/lla62fsgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eub2TfyD/oBym1/u2CMJoKhe7cEGFCZ6
	J6G2XQa307WiPSgAsSgqG7l5CJOveS6Q6yX99TgZg1rSp5tscYCFkRiqHkwQKd9j
	Nqrb3OGRTCevBXKWyrPzlQL7tESbYNPeIBERctvQ2h7QjnNFUx4tAc5jRvmFsuxf
	P5Oe0EbiGrA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33B8312AF4;
	Wed,  3 Apr 2013 15:17:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E35712AE5; Wed,  3 Apr
 2013 15:17:09 +0000 (UTC)
In-Reply-To: <877gkjvecg.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's
 message of "Wed, 3 Apr 2013 17:11:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D82BFF2-9C71-11E2-8052-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219947>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@inf.ethz.ch> writes:
>>
>>> +<commit>, <object>::
>>> +	The object that the new tag will refer to, usually a commit.
>>> +	Defaults to HEAD.
>>
>> Shouldn't this be more like this:
>>
>>     <commit>::
>>     <object>::
>> 	Your explanation here...
>
> Hmm, you're right, but we seem to be fairly inconsistent in that
> department.  There are some instances with the comma style:

That is because we did not know better in the olden days, until
somebody noticed and started using the separate-line form.  We might
have a patch or two to only convert from the comma-style but I do
not recall us doing a whole-tree style clean-ups.

> Should we fix that?

I personally do not think the churn is warranted.  "Fix the existing
ones you notice as you touch the vicinity, and avoid introducing new
ones" is good enough.
