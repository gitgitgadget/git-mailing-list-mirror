From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 08:24:19 -0700
Message-ID: <7va9nv7xss.fsf@alter.siamese.dyndns.org>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
	<7vip2j8ozu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 17:24:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud02d-0004id-Cs
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab3EPPYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:24:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074Ab3EPPYW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:24:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0E661E4E2;
	Thu, 16 May 2013 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QZ7m6CGUF1mxqQqglimpiZCgP4M=; b=jx2rUP
	VHhpPgXxRYtnsBSMQSNefpC0mTjWzYHSlqPTSrbVkeQbV9x9d3zF7CeLG/GhCLvQ
	McdOY/MpUHe8YhMDuTAndJn7/uJM3OlR1+qSQyCzdZMyk9Pv2PjtX6UpH0L2w8tO
	sj5kkezcj6BIXhKYbPVt2WIaxD5elrDu+91JM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NxhWcVbSO0v+KFXn9ArbTAE5yx4AnNkc
	FNkz+wnSJzHQIVYsAL5BzKxmz0sketBOZJiydGdZN79hV6xdxAsMf8DFQ+qAoFt/
	xkiSs0dZ34cmpui8c0zaiwyTVY7/GvSHwL/Rn/N6WQk11jnpD3GtRACZyg5/IFS5
	wINd8/Z1nrM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C89671E4E1;
	Thu, 16 May 2013 15:24:21 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B5021E4E0;
	Thu, 16 May 2013 15:24:21 +0000 (UTC)
In-Reply-To: <7vip2j8ozu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 15 May 2013 22:36:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE9AA12C-BE3C-11E2-93BD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224572>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It doesn't make sense to push to the upstream branch, so create new
>> configurations for the notion of 'downstream' branch, which is basically
>> the branch to push to by default.
>
> It doesn't?  That depends.
>
> To people coming from (and people who are still using) central
> shared repository workflow, pushing to anywhere other than the
> upstream makes no sense.
>
> If qualified with something like "When using a triangular workflow
> to pull from one place and push to another place" in front, I can
> see why having a separate upstream and downstream makes sense, and...
>
>> The upstream branch is remote+merge, the downstream branch is
>> pushremote+push.
>
> ... this is a perfect explanation of what a downsream is.

After thinking about it, I do not think downstream is a good word to
describe where you push to at all.

I'll have more on this topic but the above is the short of it for
now.
