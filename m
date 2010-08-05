From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 05 Aug 2010 10:05:58 -0700
Message-ID: <7vhbj9dm6h.fsf@alter.siamese.dyndns.org>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
 <20100805001629.GC2901@thunk.org> <7vsk2tdnv5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 19:06:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh3th-0006Zn-OD
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 19:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933330Ab0HERGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 13:06:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab0HERGI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 13:06:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F22CACADAD;
	Thu,  5 Aug 2010 13:06:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VXfD6itZhWde8+mFst7uQJY1+r0=; b=RQBVbK
	nlyYvtvzdTtIKQ5itynvXIY+py5QYbo6cE+pbYmPDMG80j0cEYnlOa2Q3Z+hox/j
	W9fPrDcuVd5EZrLdDIuERXW1uxj/7fh8ra88X+rnPN9HePpWZWPslZoZL1CSirw9
	rlUitZTwqnr6Xolvt1OgfG7FXnMmInhrJZzmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=prjfPk0rJuRiurH+KBTha6ZIHUNeeR6g
	h/1bXB5Bx/RseE0adDBPmK9ooh/QrzVq8ZL80vYo9DR6EfDPMlh0/11wW5iKLwXh
	O6zD2E2w0X5A/RMgoj5vI2kfxyMObcxr+hSgcqAML1MVfAwjIEJzobU9Y5O+7pVY
	ZdijEO3VZyE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CABB4CADAB;
	Thu,  5 Aug 2010 13:06:04 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3A46CADAA; Thu,  5 Aug
 2010 13:06:00 -0400 (EDT)
In-Reply-To: <7vsk2tdnv5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 05 Aug 2010 09\:29\:34 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BB660792-A0B3-11DF-8F99-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152693>

Junio C Hamano <gitster@pobox.com> writes:

> Ted Ts'o <tytso@mit.edu> writes:
>
>> On Wed, Aug 04, 2010 at 03:24:23PM -0700, Junio C Hamano wrote:
>>> 
>>> * jk/tag-contains (2010-07-05) 4 commits
>>>  - Why is "git tag --contains" so slow?
>>>  - default core.clockskew variable to one day
>>>  - limit "contains" traversals based on commit timestamp
>>>  - tag: speed up --contains calculation
>>
>> What needs to be fixed up before this effort can graduate?  I find the
>> fixups here to be really helpful, even without the automated skew
>> detection that has been proposed.  And even if we fix the root problem
>> with some new all-singing pack format, I suspect that may be a ways
>> out, so it would be nice if these patches could get included for now....
>
> I agree in principle; the log messages need to be cleaned up first
> at the least, though.

To reduce the risk of double-work, I need to clarify.

I meant to say that I can find enough material, especially what Peff
wrote, in the discussion that followed in the thread to do the clean-up
myself.  No need to resend by anybody unless there are material
differences from what have been discussed so far that need to be
incorporated in the final series.
