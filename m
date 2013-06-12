From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Wed, 12 Jun 2013 10:22:19 -0700
Message-ID: <7vhah35jn8.fsf@alter.siamese.dyndns.org>
References: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
	<1370724291-30088-1-git-send-email-apelisse@gmail.com>
	<7vsj0roxnr.fsf@alter.siamese.dyndns.org>
	<CALWbr2zLTUYRnaYxbjyU80zpa3Q6WGcquTPAHqWCJnbEZ7RNPQ@mail.gmail.com>
	<7vsj0pej5s.fsf@alter.siamese.dyndns.org>
	<CALWbr2zOkoX9NKuZGOWDHyG12xE8ASz+gCK8qwgM1Xqr+uqN7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 19:22:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umokd-0000c0-8o
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 19:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757443Ab3FLRWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 13:22:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906Ab3FLRWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 13:22:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC9D26CA8;
	Wed, 12 Jun 2013 17:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T5pUET4FjVO8bGVUbbuY/w27z1I=; b=OShr0f
	vEJ4xBZOesYEUY7bEnQ97WsZdvhBNwvCiR0i2bsx9kIxo9iSyuyMUQbeC5Gb46Qj
	ir/bE9gDpHD2+uGQx6/1BkNernv90Hm2YzF75dN5n7xpVW3DiFqYDpzgtkCPhCe1
	wRG2mzb7/gKmoadUi0Gqjx5ltWNvSb8eYaHVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SxJRfjuJ5KBiSkAUkTjYf21d6NA7dpeZ
	mnG5Yshgl1jUEACyIXx8tIdJXGw5mhyeq5gNacM8TWLQuoKr8qRh9VZzaAv5TdRO
	E09J9RXEyO1cWCU8B67Tne3+ELqOyf2Mh1FwR3PLjI7ZS8lkLxlKM+m3Oj0HqV9p
	gyqf4V6FYLs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1E1526CA7;
	Wed, 12 Jun 2013 17:22:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A5DD26CA6;
	Wed, 12 Jun 2013 17:22:21 +0000 (UTC)
In-Reply-To: <CALWbr2zOkoX9NKuZGOWDHyG12xE8ASz+gCK8qwgM1Xqr+uqN7A@mail.gmail.com>
	(Antoine Pelisse's message of "Wed, 12 Jun 2013 15:21:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3E15DE0-D384-11E2-8816-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227658>

Antoine Pelisse <apelisse@gmail.com> writes:

>>> Anyway, I'm starting to think that "show blank lines changes near
>>> other changes" makes sense more and more sense.
>>
>> Probably.
>
> I'm glad to see how convinced you are ;)

That is not me "not convinced".

It is merely "I do not have a strong conviction that you are wrong;
I'd have to think it (again) after re-reading your patch."

Thanks.
