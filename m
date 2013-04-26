From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/9] remote-helpers: fixes and cleanups
Date: Fri, 26 Apr 2013 16:04:15 -0700
Message-ID: <7vd2tgvqq8.fsf@alter.siamese.dyndns.org>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
	<7vwqrpuedv.fsf@alter.siamese.dyndns.org>
	<7vsj2due28.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 01:04:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVrgk-0006HJ-PT
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 01:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912Ab3DZXET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 19:04:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986Ab3DZXES (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 19:04:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2ACC1AD3A;
	Fri, 26 Apr 2013 23:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y3oqsiTjSsfIc3QyJFhEPOU5OaA=; b=iTyoF0
	c5JXYGOMftbg3LHFj3D43EI/Rm7/j+lNM91rnJdqKD6PtejBfW7K7NajBPz2oCjF
	YCb/23d4ArJIXyPiDm28Kpqongqo0xox3rA1h7dfMkLwxAaXh7NjIgkf0kq6lShb
	srjBw5nPtnLIIDSXQjzVkaUL4JgL4vpwQ11b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bxsacjLIs9+hYpFd2AxZy/jbVQF1fg/f
	WVS2PVvLcgIXx0VLYW2+jtqKew55v0GXTGpp1JXnOzucj348KWRVJ9yOO0jnBnno
	2+HdCKPviKuCHdC2NV0Ln9kPfktFtLhIMn1cVmbQba50/C8wQRXFExc/cz4tG6dp
	giI2dw6ZePE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C81A21AD39;
	Fri, 26 Apr 2013 23:04:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CBDD1AD38;
	Fri, 26 Apr 2013 23:04:17 +0000 (UTC)
In-Reply-To: <7vsj2due28.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 26 Apr 2013 15:23:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EF63960-AEC5-11E2-86DE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222604>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Updated the commit messages, so we say Bazaar instead of Mercurial, and stuff.
>>>
>>> Here's a bunch of cleanups mostly to synchronize remote-bzr and remote-hg.
>>
>> Thanks.  Will queue on 'pu' without looking.
>
> Actually, I was going to merge fc/remote-hg and fc/remote-bzr down
> to master anyway, so I'll just apply them directly on 'master'.
> 
> By the way, I personally do not think the quality of the changes to
> remote-bzr matters all that much ...

Just in case anybody get the wrong impression from the above quoted
lines...

The "without looking" was a plan to "keep them on 'pu' for later
inspection so that I do not have to go back to list archive when I
declare patch review bankruptcy after the final 1.8.3 release".

I did read these patches I applied to 'master' and they all looked
sensible.
