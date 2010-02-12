From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Separate default push/pull?
Date: Thu, 11 Feb 2010 16:49:26 -0800
Message-ID: <7veikrl1m1.fsf@alter.siamese.dyndns.org>
References: <m2zl3fg26j.fsf@boostpro.com>
 <a038bef51002111057l382ed55fy6b4042d1115a830c@mail.gmail.com>
 <20100212001417.GC21930@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 12 01:49:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfjj7-0004fi-Vv
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 01:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab0BLAtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 19:49:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462Ab0BLAtk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 19:49:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E365982BB;
	Thu, 11 Feb 2010 19:49:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X7+cOUjNViDQ3OK43Z922jDMZNs=; b=wL5zih
	pIhKDpFT6SNote8NPnZBrC/4TqSRhKCxgTP6gGrwykvQfUGDT0gf9Uv+qLumOE1a
	+ufU6XqWB56Zax3tBCVQ2WNGn3WUtRur5s7ZdB6BupGyAa0PRIREQX1ZqzoCByVJ
	4V8ya661fyLq30yir29Vves4rwbaJPEgv6+ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uC90EcpYh0AzQv8S0+SRDnbU/9Ium4Xq
	iEQh/lEaEuh6w4AgDcEsNQ4UvvIoid5h6RdK4iFJ8DaoPFG5vCgs7YvmLVvw+cfW
	O7D6nSmAmOeys+MY/7MN4ybwjN46HmOKwTZyk2B6QGDpEUqfHqyU5OHJLZRn3nTc
	J3LMA4x0ByU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D584B982B5;
	Thu, 11 Feb 2010 19:49:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05305982B1; Thu, 11 Feb
 2010 19:49:27 -0500 (EST)
In-Reply-To: <20100212001417.GC21930@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 11 Feb 2010 19\:14\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7BFCD314-1770-11DF-BA91-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139649>

Jeff King <peff@peff.net> writes:

> I think what he would need is a "push.defaultRemote" config option,
> which universally overrides branch.*.remote for pushing.

Or "branch.*.pushremote".

But does it really make sense to get changes from one place and send
changes to somewhere completely unrelated?
