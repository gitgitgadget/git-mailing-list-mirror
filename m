From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 8/8] Doc branch: show -vv option and alternative
Date: Wed, 19 Sep 2012 10:22:24 -0700
Message-ID: <7vvcfagc6n.fsf@alter.siamese.dyndns.org>
References: <1348010734-664-9-git-send-email-philipoakley@iee.org>
 <7va9wmirud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:22:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TENyv-0005hz-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424Ab2ISRW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:22:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58299 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295Ab2ISRW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:22:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B2BA9707;
	Wed, 19 Sep 2012 13:22:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6OobqiPHSv6/AZ9mDUW1LMJacQ8=; b=SSCCtI
	/zVJ/OLXObqjnUPfdc9kDPLJCRpObVY4yYEuJ0h6qWc4KhAw1F40yckofDJABGzi
	xmF/wh6K/lGW+NixN7CNt/bQv0VlHCvvY7TNi3n8kw23Bv+NCqJyPd80lvgJjv0N
	en2DTCe+QN7uh0ep6JNUMOuxAkrvVfe4E1lM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IiEfbd53woerok/8t6xPzL1STEHBbKaE
	jwKVs9I9wnZf1hi06tL+9lN304xA2UqNWH+TV4ZWk1CETrTVq5HS4dGilpV0hGVX
	10ZAm3mCAR6k81c56hRS4oArnzCbKrr5A/YJCp3B3mvgESjx2rqQMOXNn+67zwaC
	1mHpbv0W1cc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 386ED9706;
	Wed, 19 Sep 2012 13:22:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C4759705; Wed, 19 Sep 2012
 13:22:26 -0400 (EDT)
In-Reply-To: <7va9wmirud.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Sep 2012 21:01:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 952DBE9C-027E-11E2-A904-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205955>

Junio C Hamano <gitster@pobox.com> writes:

> Philip Oakley <philipoakley@iee.org> writes:
>
>> --v::
>> +-v, -vv::
>>  --verbose::
>>  	When in list mode,
>>  	show sha1 and commit subject line for each head, along with
>>  	relationship to upstream branch (if any). If given twice, print
>> -	the name of the upstream branch, as well.
>> +	the name of the upstream branch, as well (see also `git remote
>> +	show <remote>`).
>
> Can you try
>
> 	-v::
>         -vv::
>         --verbose::
> 		The description...
>
> instead?  Cf. http://thread.gmane.org/gmane.comp.version-control.git/205184/focus=205315

Nah, nevermind (I was being lazy and hoping for a quick turnaround).

I tried it and it formats well, so I'll squash that in and queue.
