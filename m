From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] tag: die when listing missing or corrupt objects
Date: Wed, 08 Feb 2012 20:33:51 -0800
Message-ID: <7vbop8y6a8.fsf@alter.siamese.dyndns.org>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <20120206081342.GB3966@sigill.intra.peff.net>
 <7vk4408ir6.fsf@alter.siamese.dyndns.org>
 <7vfweo8ikq.fsf@alter.siamese.dyndns.org>
 <20120206083832.GA9425@sigill.intra.peff.net>
 <7vty337rug.fsf@alter.siamese.dyndns.org>
 <20120208210156.GA9588@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 09 05:34:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvLhn-0005uF-6i
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 05:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758032Ab2BIEdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 23:33:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757752Ab2BIEdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 23:33:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9F37750E;
	Wed,  8 Feb 2012 23:33:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YIn4vdRaZp1LGgASXGtHtbBE1OA=; b=gz3YsO
	pGqo8JdWMkR6sCBjzkS4hlp2QVlN5J7KgHhbAfPrgab+KjCXNumbYbRz44Md/zXz
	Jk2xVzscX8IMy9VeJi14Dc6fQFXV94HA/9x2NUXZ5nEGGVfrkecyR3HdNBtN0gwG
	Ra866JI1tfRgIucQN/qB/UWTnUyTksalNkfLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VH0aIP+U0wcuueca2mpqLpfoqNgTtAQF
	dTBNcyHB/gB1uwN5C6aNq8OfQgkuYckJzjM39ThZAEfuOrXBOVObr7mgJ8dVT/wX
	TBMLgvh0dpG4BRNgu7CqS+puSf1RQCBXo8fD79A/XJX55IPMfMiC7xhtdnvnXWFD
	aYbLZRTXVXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1954750D;
	Wed,  8 Feb 2012 23:33:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35677750C; Wed,  8 Feb 2012
 23:33:53 -0500 (EST)
In-Reply-To: <20120208210156.GA9588@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 8 Feb 2012 16:01:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45525C7C-52D7-11E1-8785-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190272>

Jeff King <peff@peff.net> writes:

> Since jk/maint-tag-show-fixes is still in pu, perhaps we can squash in
> this test from my 3/3:

Thanks.
