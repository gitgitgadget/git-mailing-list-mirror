From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Fri, 22 Nov 2013 11:36:57 -0800
Message-ID: <xmqq61rk1b52.fsf@gitster.dls.corp.google.com>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
	<20131122102345.GC12042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 20:37:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjwXT-0007uY-D3
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 20:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab3KVThD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 14:37:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495Ab3KVThC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 14:37:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75AAF544FE;
	Fri, 22 Nov 2013 14:37:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XGIKpud7+oKbDuJ7DPx4kRyr4VA=; b=mnc/Td
	rdBKGMRo98Vm/KwCCHsUdK44jnRpFSCbkA4KqfeIfcYcesDybsIDclVSpNjuxdVj
	uE3wS+Xpz7jMbLjK/gPgxAsHuvZ07ypP95s7vaTyOmJnWURuxw9kWT97WIcvCRe+
	Ia2yu4fTKKAS0FR2Ktp+qhWyX0N82Hrr20YUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CatInLX42xGP4bqSc5gzwDcfKl8rojrN
	OOjYD8FOhesvJBUs9v+8TURvYXh1Y1BSrLCmWKA69viFsaHvQqJwEPteSwiwZXuc
	S4e4rp61+1zwXCiHISyDMmxV7D2eCzngQV782T0La4Md2YAhb6xhDP6BJ8f+GDfX
	vHpeTHqFV6Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EC41544FA;
	Fri, 22 Nov 2013 14:37:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D0C3544F4;
	Fri, 22 Nov 2013 14:37:00 -0500 (EST)
In-Reply-To: <20131122102345.GC12042@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Nov 2013 05:23:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 74D5BB28-53AD-11E3-BC44-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238206>

Jeff King <peff@peff.net> writes:

> Looks like you picked up my latest re-roll with Ramsay's fix on top.
> There wasn't a lot of review on this past round (I'm not surprised; it's
> a dauntingly large chunk to review).  I outlined a few possible open
> issues in the cover letter, but I'd be happy to build those on top,
> which I think will make review of them a lot easier.
>
> Do we want to try this in 'next' post-1.8.5, or should I try to prod an
> area expert like Shawn into doing another round of review?

Yes ;-).

I recall starting to read the series over and then got sidetracked
in the middle and never finishing.  I'll try to make time sometime
this weekend (we are still buried in boxes after the move, though,
so no promises) myself.

How close is this what you guys are running in production these
days, by the way?
