From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] replace: List replacement along with the object
Date: Thu, 25 Aug 2011 12:07:25 -0700
Message-ID: <7v1uw9l382.fsf@alter.siamese.dyndns.org>
References: <bae5a8f7d30417864d972390f9f6b4470cf4e5bf.1314283118.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 21:07:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwfHA-00061u-Ps
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 21:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab1HYTHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 15:07:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57695 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755306Ab1HYTH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 15:07:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1187B440F;
	Thu, 25 Aug 2011 15:07:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uay/XyKZaIYLfX5g1gb7jXWPHyI=; b=EOsWGZ
	XDCZaqXv29QkH98WbAY/tJehYzpbGOokHiF4nHWSamBBEo07Wf7BNIHa9h8Ciwn5
	a4rMHd+XgfaHff1Agne2lPmk5N4XVyzvpBznrVjx/+3ty8/cYqvergxiCyzDOf1t
	6LHzP9TTkpPK9KLZUAgh8f8KW+G4TBpjEsEHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bq+Iy8BjrM7+AnCBwZYvP9buG/uBYmvl
	yuTpQyyaW9lMqcr5fYaZVNeJQmU2uyVf0ly8DPqk695ltZjhB1JGqqrFxvM5B/P8
	8xJCULot+iaSEWyYG8XgBp5WEacWfqSCcVpKOlfl8QEHDLUs5Oi1BE5g4XHUUfsF
	7yajqFO7ZfE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07D47440D;
	Thu, 25 Aug 2011 15:07:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B743440C; Thu, 25 Aug 2011
 15:07:27 -0400 (EDT)
In-Reply-To: <bae5a8f7d30417864d972390f9f6b4470cf4e5bf.1314283118.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 25 Aug 2011 16:39:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7931D670-CF4D-11E0-A72D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180102>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The documentation could be misunderstood as if "git replace -l" lists
> the replacements of the specified objects. Currently, it lists the
> replaced objects.

Seeing that you had to change existing tests, I do not think this is an
improvement. The existing scripts can read the list of objects and find
replacement themselves (if they want to find that out, that is), no?
