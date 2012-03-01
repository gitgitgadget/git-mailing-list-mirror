From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] t5510: ensure we stay in the toplevel test dir
Date: Thu, 01 Mar 2012 14:33:31 -0800
Message-ID: <7v8vjkkl38.fsf@alter.siamese.dyndns.org>
References: <cover.1330637923.git.trast@student.ethz.ch>
 <80204781996b200d08b73cf61fa50df468e4b51d.1330637923.git.trast@student.ethz.ch> <7vipiokmrz.fsf@alter.siamese.dyndns.org> <871upcht2h.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:33:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3EZ9-0007Dw-TU
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 23:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758159Ab2CAWdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 17:33:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999Ab2CAWde (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 17:33:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A5C069D4;
	Thu,  1 Mar 2012 17:33:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5MWCQnBm3mYbmOHofTAv3kbUKHc=; b=DcXRtL
	4tz3TYeJ8cg2Ggm7tacbEYqMKYlpRGfQAvbjuhbBdnV13FF6NO9NwZT7iJr2hkRd
	GGqVFKg7atpr3jhFjw3aI3RG+M0bFgjV+LKbICcmDhcNIt8Wnzjt+e7MTUUeeBmH
	T6po0A+SN3xWS/dWPu0n8JJCZzKazfjBQdtuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qeop2iLyhnto7rsGINHH4r5LGECJbWot
	CLRLkYrlJz4qbhepWYCLCs36bFSYv/fOKbrUIUBriBDTFUI7coJPqOQKblQNU5LW
	nHtLzCGENOIAcFeemfDQSMISs5ukikkpIfymzK/t/MWIPCankdPKk5vRqX/Yckvm
	kxquH7EnvjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2BF669D3;
	Thu,  1 Mar 2012 17:33:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 506E469D1; Thu,  1 Mar 2012
 17:33:33 -0500 (EST)
In-Reply-To: <871upcht2h.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 1 Mar 2012 23:09:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93F3AD04-63EE-11E1-9AED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191985>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> The last test descended into a subdir without ever re-emerging, which
>>> is not so nice to the next test writer.
>>
>> True.  Making the test suite more robust like this patch does is very much
>> appreciated.
>>
>> Is there a reason why we shouldn't be sticking to the more usual
>>
>> 	mkdir dups &&
>>         (
>>         	cd dups &&
>>                 do whatever in dups
>> 	)
>>
>> pattern?
>
> None in particular.  It would also perhaps reduce the churn since (as it
> touches every line anyway) it could be squashed with 2/4.  Should I reroll?

I was just curious.

But it does sound like squashing the two may make sense.  I can manage
locally.

Thanks.
