From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] require-work-tree wants more than what its name says
Date: Wed, 04 May 2011 08:42:58 -0700
Message-ID: <7vliymfp4t.fsf@alter.siamese.dyndns.org>
References: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
 <20110504073850.GA8512@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 17:43:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHeEN-0000nK-8Q
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 17:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab1EDPnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 11:43:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab1EDPnI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 11:43:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3CFA45A86;
	Wed,  4 May 2011 11:45:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T4ICVcmB2wVxGS3P+9uWabY5ueY=; b=YmjbQ9
	icEolzEptLVXINn5/ePJdz4PxoOoBfZ0dFwxqbvqRhbLdJxXPBPK/6mLXN3oIz67
	Kgg2Pj/YUk61I+zOfUBucYFBBsB5dbnQpSCjC2j+W0KGa4zLJ+20tuNzIjKjim2q
	aiks7DKuw/SsbcNTSm7kLfJvl16h6VkslicPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B8sne1EARAje7d5bMzsNx4hpkc3HNbb9
	quzt3B7hSIVwNJrrmf/7xeu9pHrUcz5wieeHiJCV2VySu2A7O/ro5WifOAzcjRHw
	cHzY7h9kaEcUa6kjU7NzWgJ9Sk77vWhNnh++qXpXPuc7Y57U180GpP8JducayAHn
	+Z3GmOww7W8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1AA725A81;
	Wed,  4 May 2011 11:45:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E45955A7F; Wed,  4 May 2011
 11:45:02 -0400 (EDT)
In-Reply-To: <20110504073850.GA8512@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 4 May 2011 03:38:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BA934DE-7665-11E0-97B8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172748>

Jeff King <peff@peff.net> writes:

> ... but I worry about compatibility. We can audit our in-tree scripts,
> but git-sh-setup is part of the recommended API for external scripts,
> no?

I am Ok with renaming the thing to "require_work_tree_exists", and all the
worry will go away.
