From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/13] add --always-print option
Date: Tue, 13 Jul 2010 13:35:43 -0700
Message-ID: <7v8w5f3ysg.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829141-11900-11-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 22:35:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYmCr-0002aI-Da
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 22:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab0GMUfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 16:35:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab0GMUfv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 16:35:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4359C4FD7;
	Tue, 13 Jul 2010 16:35:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j5kLxksy18EAEDFOBwywTZZvFOw=; b=h/cNC3
	MvglaVv4wlFiqT0+As3Wo/UL5GkCshjuPH3qlgg5SHhGs40E++owEaHzm6Jwo2LO
	Jpt4DbATqnMehv+twJ8VEzuRkBNfb7Kb+5BVS4dZQUczxtzzWdG9yQI9cVK94aHF
	4jrnoAKcJ8eaJcDxgko1ATV07OjZloCZHNE1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=npZYLcHskGT1+Rua+rV7g3qjtwSsjtO0
	35D6XeyNRWIcSbYVkKfKUwoaIQ4uc9Dn3B0DQSbnDIbxxWaOg8wQdRIC578kKPeX
	t8sFqO3nXrFeUIe1drexfQtRjoUlGF/jaXEd729oPnsowBmZd26aRJyKH17qTUt1
	fR04qkF9XUc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A070FC4FD6;
	Tue, 13 Jul 2010 16:35:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01D40C4FD1; Tue, 13 Jul
 2010 16:35:44 -0400 (EDT)
In-Reply-To: <1278829141-11900-11-git-send-email-struggleyb.nku@gmail.com>
 (Bo Yang's message of "Sun\, 11 Jul 2010 14\:18\:59 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37D903A4-8EBE-11DF-9665-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150909>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Subject: Re: [PATCH v3 11/13] add --always-print option

Please be always careful about your Subject: line.  Imagine the above
appears in the shortlog output for v1.7.8..v1.7.9 among 500 other commits;
do you expect people to be able to tell what this commit is about?

> Always print the interesting ranges even if the current
> commit does not change any line of it.

Please explain why it is a good thing to do so.
