From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 19:03:55 -0800
Message-ID: <7vaaw8xip0.fsf@alter.siamese.dyndns.org>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <alpine.DEB.1.00.1001202354070.4985@pacific.mpi-cbg.de>
 <7vljfsz7vx.fsf@alter.siamese.dyndns.org>
 <201001210354.22756.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Joey Hess <joey@kitenet.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 04:04:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXnLG-000187-AG
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 04:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab0AUDEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 22:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696Ab0AUDEN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 22:04:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab0AUDEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 22:04:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AE1C922CF;
	Wed, 20 Jan 2010 22:04:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CbUvl8qJodawK4wyQT7kb3lVTv4=; b=IBlqKe
	1APHRY9KF6lkEsjufK65TLpkNzZU1JylJysC9Nm0bk8qAyDwjdJlKUG3wl9/E3Jr
	l+k2eIUQ6qm+lMQmZzNKUjz6vX2Wz63aqem6pa/ZXa+P21nnQHNYTOy+a5MJNFS1
	ieeTjbWtKUrvL+TC2f1QzSOuyw3zzdEZSl2QA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JvUWoN0FPK4CCdEL+2r6zADAhYWa9Jin
	jY6MM821uWZ2EYBcGYTciZq7w6hhp2nEornrvW4JgB41/zThHUXkZ2KGa+sAnOsd
	RdrRrL/ZTwcO3jkYtuF7vzYercSaGWppQGG0RmroXXmG7U6H7HgYigBCzcxtJWvQ
	Rz/7vYk/duc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05740922CA;
	Wed, 20 Jan 2010 22:04:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10789922C3; Wed, 20 Jan
 2010 22:03:56 -0500 (EST)
In-Reply-To: <201001210354.22756.johan@herland.net> (Johan Herland's message
 of "Thu\, 21 Jan 2010 03\:54\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A1162152-0639-11DF-A47A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137622>

Johan Herland <johan@herland.net> writes:

> - Re. Junio's worry that he will become the janitor for these patches. 
>
> Please don't. As long as the patch series is in 'pu', it is MY 
> responsibility ...

I am not worried so much about what is not in 'next' yet.  My worry right
now is primarily about what to do with upcoming 1.7.0 and also the 1.6.6.X
series, which already shipped with "format-patch" that injects notes in
its output.
