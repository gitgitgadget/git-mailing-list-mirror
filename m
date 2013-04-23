From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! t3210: test for spurious error messages for dangling packed refs
Date: Tue, 23 Apr 2013 10:50:03 -0700
Message-ID: <7vehe1i1bo.fsf@alter.siamese.dyndns.org>
References: <7vehe2nr16.fsf@alter.siamese.dyndns.org>
	<1366708556-9172-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 23 19:50:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUhM7-0003pD-AC
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 19:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685Ab3DWRuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 13:50:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756381Ab3DWRuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 13:50:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DBD019A7E;
	Tue, 23 Apr 2013 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XCu52BJo+ynHyj6vX6I8qinLlVw=; b=XDgGUr
	FUlSIdnlXd+TkepCTmPw4aFvfwLaIUpPGn6HG/fSH1AiWjaVUrUuPMk4GqA68+nx
	Mp1Uc1JJ++hun38nMmetud6knz2vDsD3LCwNYZFg8M4lNGbHNEp1Q6ty5dqLzwFr
	KEHdHo8WtwrBTlAMMw4LRRPBURJa/XvBH0wV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KRB06LYBkSmPHU9w0aRaSMKhZSE2IauD
	k91O205jo3/oF7691zUdSkNsDrMiTLlVTRPW71s+Tsu2MI1QSUYYeEoNsFsBQJ9G
	sn9gvRl4yzbBHxvW3zK2oJmatnTaXnbYztEOJu2s2PI70FC03rk8+J6B8UhV4ixA
	/75L+2bf9DE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 562B919A7D;
	Tue, 23 Apr 2013 17:50:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D30EE19A7A;
	Tue, 23 Apr 2013 17:50:04 +0000 (UTC)
In-Reply-To: <1366708556-9172-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 23 Apr 2013 11:15:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AC8DB66-AC3E-11E2-B3F6-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222201>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Let me know if you would prefer that I re-roll.

Your fix-up cleanly applied to the result of applying the series up
to 16/33 and it was trivial to squash it in.

Please holler if what I push out on 'pu' in 8 hours or so looks
wrong.

Thanks.
