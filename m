From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-send-email format-patch awareness & retry
Date: Wed, 08 Sep 2010 09:04:02 -0700
Message-ID: <7vk4mwnrwt.fsf@alter.siamese.dyndns.org>
References: <AANLkTimtOguHdcs+QYj7ePNeyMNsWYLDu+yfyOPrDWUG@mail.gmail.com>
 <201009081114.18263.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ryan Anderson <ryan@michonline.com>, Greg KH <greg@kroah.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Sep 08 18:04:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtN8P-0005av-07
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 18:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155Ab0IHQEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 12:04:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0IHQET (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 12:04:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE086D49B1;
	Wed,  8 Sep 2010 12:04:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2aG00sBrvyisQ6roNXp3pSQeu5I=; b=UY6YdV
	JhSAzvJXqZJmK0b95mIVGgHSaJ4c2s+qV8gqMeheV5WTX2KngA1vHaPz7tEUfdr9
	m2dkWBYxpnwBld5hk5/DU5L5pdyOc6ldVJqV4Oo9vuvdHo5POVkYOr0IBDLrCzJJ
	WxyV02TvVbj1T61nXEGMqDzY0Jqjb7aAif9G0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KgZnTt+dXOD7ALxnF4SU7ELBLD8hIGBj
	eEjsWRv4p8pIQzGCC8IE75MLZzi6CGNBNKCyvESDXDazOx+UUj9qchbkL2r49/IK
	vsKmUPGhi3KciyYLeK40ivZ0R60Y0Ccq8JnxlWgsimoh5rVYvQ+QDclUzo5WwrHW
	v61Kyi+u5+4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CC6CD49AF;
	Wed,  8 Sep 2010 12:04:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92B4DD49AD; Wed,  8 Sep
 2010 12:04:04 -0400 (EDT)
In-Reply-To: <201009081114.18263.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 8 Sep 2010 11\:14\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B8BA83C8-BB62-11DF-A487-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155797>

Thomas Rast <trast@student.ethz.ch> writes:

> You could resurrect
>
>   http://mid.gmane.org/7fedc4b76fed03e4db6a2bb7453609c9cd02928a.1244496564.git.trast@student.ethz.ch
>
> though on re-reading I'm not so sure anymore that *any* complaints
> remained.

I think I got distracted in the follow-up discussion and forgot about that
patch.

And the patch looks sane; let's queue it, so that I won't forget about it
again.

Thanks.
