From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Thu, 03 Nov 2011 16:02:48 -0700
Message-ID: <7vbossermv.fsf@alter.siamese.dyndns.org>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
 <4EAEAE13.50101@atlas-elektronik.com> <4EAFC18A.1070502@atlas-elektronik.com>
 <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
 <loom.20111101T205618-231@post.gmane.org>
 <loom.20111101T211624-511@post.gmane.org>
 <20111102180327.GA30668@sigill.intra.peff.net>
 <20111102181041.GA5366@sigill.intra.peff.net>
 <7vwrbiibgz.fsf@alter.siamese.dyndns.org>
 <20111102200947.GA5628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 04 00:03:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM6JG-0006Y5-5R
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 00:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab1KCXCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 19:02:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab1KCXCx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 19:02:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 415E16A2D;
	Thu,  3 Nov 2011 19:02:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pdQ/gKJK/OBABk2RFQnrZzRQ/tg=; b=IBcuk3
	fCuwRn9/yCTpvFKpjVWRUypAFy77xLrOLdu8ekbUH0cMiAkvWLSDsnn2OaErniFV
	/lh8NLoe6r9ONghxEcXz+3i6qN0UJgcy7JAElo+ikhEHtU0zn96UD1IZx0mx7PvH
	coawBwb4DnH1HDX3w9V5aXbGJUPYSM61br9Ag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rgXfD647t1MrXkV56Pm1d05HaK5ZsJmL
	KVdZNeVO2DxLytxDgnWD33q7WL2gJVRhs3xQ2yMsR9xHmNfTMYVtTDV0ngsRtGBR
	HwoR5/R1HvS2GTsEMvHWjP4prRyfK3ylVFL2GfSvW0UjAgyTQtGLxZ0/O00/fUZi
	xPhP+XWOCRE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 375056A2C;
	Thu,  3 Nov 2011 19:02:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B63EE6A2B; Thu,  3 Nov 2011
 19:02:49 -0400 (EDT)
In-Reply-To: <20111102200947.GA5628@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 2 Nov 2011 16:09:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3B35ABE-066F-11E1-A39B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184750>

Jeff King <peff@peff.net> writes:

> Normally I would say to implement in favor of the no-netrc case, as it
> is probably more common (and will hopefully be more so after the auth
> helpers are finished). But the problem is that the penalties are
> different. On the one hand, we have the extra http round-trip. Which is
> annoying, but mostly invisible to the user. But on the other, we have
> git prompting the user unnecessarily, which is just awful.

Ok, so are we in agreement that Stefan's patch $gmane/184617 is the right
fix at least for the time being?

This will be a minor regression if left unfixed, so I'd like to have a
minimum fix in before I tag -rc1 over the weekend.

Could any one of you guys please care to package it up with a readable
commit log message with a sign-off?
