From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 10:52:00 -0700
Message-ID: <7vk49bui4f.fsf@alter.siamese.dyndns.org>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
 <4E7085E6.3060509@alum.mit.edu>
 <CA+55aFw08zEeWovDPRGCM2f-xCuamJogFzigka4=mfcpJbZpsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 19:52:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3td4-0004xC-IR
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 19:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757219Ab1INRwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 13:52:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754950Ab1INRwD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 13:52:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BDCE4521;
	Wed, 14 Sep 2011 13:52:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zSvZB/ePfxVNr1FE/WdtIo41LPk=; b=pT5ZIc
	1Ml43fbr8WNkNLRKa7KRt3vM8LL3CRHE1oYbDUDcK/bCPguyGL0A0LDNeDSLANZK
	XN5ip3KpRuHzp4D8Z85msR5RhQYIvhVcbgpW/qboVQR2q/ZqkAw+Xk+eSVtEZk7I
	PkdXvbutClljZOjWHEneLjUshuLJJfl8jsXm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PXRYYOfvqSPN07iAL1pgvPeLbPHYWV4l
	OdhOK67dXihvO7SCAFNUJj4cTZvKog56p0CURi98SWm+/v9YWC5pwSOvF8pSLXJs
	UA3ZRSXnmpCE06AqG6calWJ0bqo3FzzmWMuOjqSTXk93Tah6LXe9PNg3dRofHDUj
	vEyGzpPPW3o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 314174520;
	Wed, 14 Sep 2011 13:52:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 233E9451F; Wed, 14 Sep 2011
 13:52:02 -0400 (EDT)
In-Reply-To: <CA+55aFw08zEeWovDPRGCM2f-xCuamJogFzigka4=mfcpJbZpsA@mail.gmail.com> (Linus
 Torvalds's message of "Wed, 14 Sep 2011 08:25:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40358DAA-DEFA-11E0-BA39-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181369>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Now people do "git merge" in scripts etc, so we can't fix it ;-(

Yes you can, by teaching "git merge -e" to open an editor ;-).

In the meantime, "commit --amend" is your friend.
