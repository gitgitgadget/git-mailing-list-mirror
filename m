From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix signal handler
Date: Thu, 18 Feb 2010 12:06:34 -0800
Message-ID: <7veikib96d.fsf@alter.siamese.dyndns.org>
References: <4B684F5F.7020409@web.de>
 <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de>
 <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net>
 <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net>
 <7vsk94qfuy.fsf@alter.siamese.dyndns.org> <4B7D6B7A.1090004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:06:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiCeB-00050C-Aq
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab0BRUGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 15:06:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab0BRUGp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 15:06:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CE4E29B57E;
	Thu, 18 Feb 2010 15:06:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MEYMRZBEfJkyrdl7h0Hw5UcZeSE=; b=wraG9P
	0PM/BX37ptHi0ElE3YfvnJbx6MnKu5FNSXqCAFXTansKBPJIg9jGHwTrOsKEzkuc
	3mKLR2dZ7eAawvm8pDYbZuGvAGB6yeovFKmPkHZWmfUjYP4/o+pb36L0NFv8oqOg
	4UCI/Er2a5cyLULiR7M9oolghzBLmw9zyYb4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uDwfKEwKN+xAcr+/kDpFV/sLTR6z1xGf
	Y1wdkQEo1nWN7sD8O7ANos/llUS8L9RoHtIHNYn/dv1TG6ZJuktIXqJ1Cf8kyKgH
	3qppCrJ1wVxyZMbiRcIUHCetWDxU4jjwlD2IFeOtLVv0YzoiXPxgBTa5lP8tF7U0
	xzYZMHh0OXw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 94A0D9B554;
	Thu, 18 Feb 2010 15:06:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EFBF9B549; Thu, 18 Feb
 2010 15:06:36 -0500 (EST)
In-Reply-To: <4B7D6B7A.1090004@web.de> (Markus Elfring's message of "Thu\, 18
 Feb 2010 17\:31\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 209F9D0E-1CC9-11DF-9B64-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140367>

Markus Elfring <Markus.Elfring@web.de> writes:

>> Other than that, your comments all looked very sensible.
>
> Do you expect any more tweaks and fine-tuning for my update suggestion?

Are you asking me if _I_ expect?  How would I be able to read your mind to
see if you will decide to send a polished update?

Of are you asking me if I'd apply your patch if you send a polished update,
and asking me to decide it before seeing the patch?

Sorry, but I am confused.
