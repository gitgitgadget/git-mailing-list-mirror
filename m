From: Junio C Hamano <gitster@pobox.com>
Subject: Re: repo.or.cz being not well???
Date: Mon, 01 Jul 2013 16:10:59 -0700
Message-ID: <7vy59p98qk.fsf@alter.siamese.dyndns.org>
References: <7vli5q9ba2.fsf@alter.siamese.dyndns.org>
	<7va9m5apl8.fsf@alter.siamese.dyndns.org>
	<CB8FBC9A-B24D-4EAC-820F-A40472387FD9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, admin@repo.or.cz
To: Kyle McKay <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 01:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtnFV-0007qn-MZ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 01:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411Ab3GAXLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 19:11:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44465 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755179Ab3GAXLD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 19:11:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79E802DE96;
	Mon,  1 Jul 2013 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CXQ6GSmhgVssKLeLOMgs/5+oFRQ=; b=GeIScF
	9XCwQXpaMzINMwP6QeR0vHkxyX/R6UyS+LH5RinAIAln417QLU2f/d8phWoZgQ66
	fJ4VJTw4HaHJfOBJHyY4xoj0FU3lB9aKXbdzbQaGqrQbWFUpWBM3Lnq98GXOyTDa
	WtsJ1lwKmzPP+ETz7ofWSFwBDalTV4By34lSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oF4i2x+BavEhwgSMyo4okxi6Fvxk5kdy
	+Nuq28bpHS3dvXrEY4If+bpZpcngq+urarD8sQGCF4/TozpLkDKwGhZiPNtIJvph
	Vrb/jbSdHkyUswWgomdV9OJYZt1x0rgFOveJNq6g1xZOdzkO/W3V52t9rthFSPRz
	5Qd8N1IU5mQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7067A2DE95;
	Mon,  1 Jul 2013 23:11:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFBD02DE92;
	Mon,  1 Jul 2013 23:11:00 +0000 (UTC)
In-Reply-To: <CB8FBC9A-B24D-4EAC-820F-A40472387FD9@gmail.com> (Kyle McKay's
	message of "Mon, 1 Jul 2013 15:39:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7ECA1DA2-E2A3-11E2-82A2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229347>

Kyle McKay <mackyle@gmail.com> writes:

> I was not previously aware that URLs not shown on that page were
> accepted, thank you for bringing it to my attention.
>
> Do you feel that it's important to accept these alternate URL versions
> that are not listed on the project page:
>
> 1) Optional trailing '/'
> 2) For the ssh scp form, optional leading '/'

I am on the fence.  As long as the accepted URL forms are advertised
clearly (which you guys do indeed do), I do not think there is much
reason to spend effort to "loosen" it again.  People can adjust.  On
the other hand, loosening _might_ reduce the cost of "support calls"
(like the one I just did) from long-time users.  I dunno.

I just (1) was curious, as getting "error 403" when I didn't mean to
talk to an HTTP server was strange, and (2) wanted to make sure I am
talking with the same repo.or.cz without a funny MITM.  If I sounded
like complaining, that wasn't intended, and I am sorry.

Thanks for serving the community for all those years.
