From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/21] refs backend reroll
Date: Tue, 12 Jan 2016 16:22:09 -0800
Message-ID: <xmqqbn8qqqfi.fsf@gitster.mtv.corp.google.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 01:22:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ9Ce-0006R0-NA
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 01:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352AbcAMAWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 19:22:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754344AbcAMAWL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 19:22:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF07E3BFC2;
	Tue, 12 Jan 2016 19:22:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7qQzKjrcfjugfVbGf9n8pT3Oz9o=; b=c4gEBO
	tbw4Ezwv/4TugXQpMVeDIb/8mxayM7rRmGfGmLPaLbs/VyBZC/USK3Y4FDq9Ky/v
	kP06eLrT9biVtmRvRnfgNeVQ3B6dLlNCNPqMHXcMls9PyGXHfSwWwO0sFcjO4Hyw
	jxj9rDwZtsTqbZp7iOetDtxt1nvVGksohxjcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MmbpteLmtZJMo92WoZDsMU39rBeOYqRn
	2WUTFuJi2En1y6acZOj4K4tM4aeeBlG6jZaSow/QyFnijPr55RD9Lrr+u9jFPHe+
	EOCNBlgN30Pz3gwxK3LTPTQZ2lwGmir2D6HbrJUzAIB0P0irPviIeuppu41UEqT4
	d4OJIbQi1DM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5D283BFC1;
	Tue, 12 Jan 2016 19:22:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D1953BFBE;
	Tue, 12 Jan 2016 19:22:10 -0500 (EST)
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Mon, 11 Jan 2016 20:21:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AFBC32D0-B98B-11E5-97ED-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283862>

David Turner <dturner@twopensource.com> writes:

> This version incorporates many changes suggested by Michael Haggerty,
> Junio, Jonathan Nieder, Eric Sunshine, and Jeff King. I think I have
> addressed of the comments that were sent to me.  Those that I chose
> not to incorporate, I responded to on the mailing list.
>
> Thanks for all of the feed back so far.

Unfortunately this did not compile for me X-< and with a trivial
fix-up, I found that this overlaps with Peff's recent fixes to the
locking of symbolic refs.  So for today's integration run, I punted.

I still will push out this topic to the broken-out repository I keep
here:

    https://github.com/gitster/git

It's just 'pu' will not have this latest incarnation, but has the
older one.

Thanks.
