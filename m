From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] stash: introduce 'git stash store'
Date: Tue, 18 Jun 2013 07:31:40 -0700
Message-ID: <7v61xba3sj.fsf@alter.siamese.dyndns.org>
References: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
	<1371302006-29775-5-git-send-email-artagnon@gmail.com>
	<7vtxkwd1cw.fsf@alter.siamese.dyndns.org>
	<CALkWK0n3aEC+BxM7iAY=pcy7fKzpLeTAeRf8UttJ+K1PURP2rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:31:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uowwl-0000KA-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863Ab3FRObn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:31:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691Ab3FRObn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:31:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8952F26DB5;
	Tue, 18 Jun 2013 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LA5TNdyougEA4JwMtxQylds2JTU=; b=DrPoMM
	aOV6luOWe8J0eBauYSzH96mS9k0rQnTwpoMY0uKEPdWxUVZ5E8KhgrRRyUbS5t0Q
	KnB9l/KK/C8HIqPP0lYDHMZ63Z3G5mlHCLPiwGEgSvTQMnwD/Xqeo+17fM73ephv
	/JT6FNtl9XdXh1+cipJYiFRU12cNZn0RW+dKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X7EIqxOK9OHTzVeGA0Guo28dfHWKq10L
	fH4QvwAKDTjNiIrZhw6KEU4gBJ1Dqy7fKAQXljrZwzRcR+UkQ3BAPTfGwDlxPu8d
	DYnYtsUyEUNulDvrUeYxGdkxVOHf6knFfTPRPxBU/w76bWuKUm1flZWrRnAdmSOX
	B+ks98ZHFSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DEB626DB4;
	Tue, 18 Jun 2013 14:31:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB31A26DB3;
	Tue, 18 Jun 2013 14:31:41 +0000 (UTC)
In-Reply-To: <CALkWK0n3aEC+BxM7iAY=pcy7fKzpLeTAeRf8UttJ+K1PURP2rQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 18 Jun 2013 14:20:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB3C7976-D823-11E2-B73D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228239>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>> +     test $# == 1 ||
>>
>> This is broken under POSIX shells.  No need to resend (will locally
>> patch up).
>
> Ugh, my C habit.  Thanks for catching it.

You're welcome---that is what the reviews are for.
