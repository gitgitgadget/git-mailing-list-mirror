From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Thu, 25 Aug 2011 22:52:01 -0700
Message-ID: <7vty94g1oe.fsf@alter.siamese.dyndns.org>
References: <20110825200001.GA6165@sigill.intra.peff.net>
 <20110825204047.GA9948@sigill.intra.peff.net>
 <7v8vqhhzgd.fsf@alter.siamese.dyndns.org>
 <20110826025913.GC17625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 07:52:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwpKt-00052h-KS
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 07:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab1HZFwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 01:52:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307Ab1HZFwG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 01:52:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D6D428C6;
	Fri, 26 Aug 2011 01:52:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C29s7UO/PdJhvHEd/PhcNVIXcck=; b=MzOud0
	gjDzw/iY8gsMxZy2vRWN4+f50ox28qN4x8ckcFQt1/GkJMzoS9VNEm/eWZSALIFC
	7ad2wEEHgge0DOMMAVxNVPLSyixpcmULWg5tildmtlUf4tiOZNBlVNI1Ui6vTg5n
	aoQwPVAMwCVI8YPLJFgylBwXVcyS+WrEIAQ5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JgJbtbVig4NWAgh04DZ14PSU76+3W5BO
	J3UGMKHUYoUnxZFtD9luwgXE4MWOhsfBkx9tTnSpezDwe4WjNnJZ7cRJCDv4nLkd
	gFLEgqL4JaaU7RvIGCkgrqAUwJIKG7CttmKLBn1g2VOQs5zTIIeL4BB0Jv5WlJW3
	/GxasOMdOtE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FFE828C5;
	Fri, 26 Aug 2011 01:52:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A625C28C4; Fri, 26 Aug 2011
 01:52:03 -0400 (EDT)
In-Reply-To: <20110826025913.GC17625@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 25 Aug 2011 22:59:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8611E3B2-CFA7-11E0-9B53-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180152>

Jeff King <peff@peff.net> writes:

> No, certainly not since 122aa6f (diff: introduce diff.<driver>.binary,
> 2008-10-05). That commit's message claims that we did before it, but
> looking at the patch, I am not so sure. But I'm not about to start
> testing a 3-year-old patch to see if it really was the source of the
> fix; the point is that it is correct now. :)

Violently agreed ;-)

> I think it could be a problem in the future if the builtin userdiff
> drivers started growing more invasive options, like automatically
> claiming to be non-binary (i.e., setting diff.cpp.binary = false by
> default).

Well, I think we can be careful when we start thinking about doing
something complex like that, then. Mentioning the above consideration in
the commit message of the final version of this patch would probably be a
good idea, I presume.

Thanks.
