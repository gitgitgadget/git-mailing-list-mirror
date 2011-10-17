From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] Tidying up references code
Date: Mon, 17 Oct 2011 12:12:57 -0700
Message-ID: <7v1uubmnye.fsf@alter.siamese.dyndns.org>
References: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 17 21:13:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFscV-00034w-MI
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 21:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab1JQTNC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 15:13:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097Ab1JQTNA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 15:13:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA5815F1E;
	Mon, 17 Oct 2011 15:12:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CSpTdz2tzf5Nfc1WLo+9fX1N1bI=; b=ZZe6ck
	nN3Awu3TZnhTBeblZ/4CIuaa0vypYLrGExc4LNy5hXNlz76SwMkg3kskejIFdcWb
	B8DKpvpytBBr3D0jGRIDX1ZU8OoPNzENCfQAv6YqygweHGYYgsqi3xgnN4FLJYCW
	yxf+kFkNmMAp9aq04xvR8pBKWW3lmSe/byY6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VbBXEL8jx0+3h1qn5uaC+yiTnLQVuGZc
	pFKBNQndBdpoQ7VbvtH3qQIH54dt6TQX7Aq4ICUmOV30ucP9HIA5owbKOhLuZ8I1
	7ahnVvSVtWZ14uDkmJwOxl70FY7wZWlhf8blVimMKSOBNqVmUBAjuqUl+xvd2Lpw
	2N50tTCO7zU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D02225F1D;
	Mon, 17 Oct 2011 15:12:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CB4E5F1A; Mon, 17 Oct 2011
 15:12:59 -0400 (EDT)
In-Reply-To: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Mon, 17 Oct 2011 09:39:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06FEA7F6-F8F4-11E0-B509-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183809>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> Patch series re-rolled against v4 of "Provide API to invalidate refs
> cache"...

Thanks; queued (but not pushed out yet).

> BTW, whenever I add comments to existing code, it is just an attempt
> to record information that I have inferred from reverse-engineering.

Thanks again. I often find me scratching head while reading other people's
code, long after I reviewed (or read other's reviews) and accepted their
patches.  It often is not the lack of review that caused undercommented
code to get in my tree. During the review process, the issue the code is
trying to solve is so fresh in everybody's mind, that certain things do
not need to be explained to be understood. But that kind of memory
eventually fades and only the code remains.

It is a rather unfortunate result of the human nature that the next person
who touches that code is in the best position to find out what aspect of
the code is hard to understand and deserves comment.
