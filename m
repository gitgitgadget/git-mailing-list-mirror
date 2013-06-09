From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] status: introduce status.short to enable --short by default
Date: Sun, 09 Jun 2013 11:54:53 -0700
Message-ID: <7v4nd7qflu.fsf@alter.siamese.dyndns.org>
References: <1370683737-28823-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	<CALkWK0kvKzFoZmz313hR-3Z71y-MDPT37BfUi7Qrgy7hz_sErQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>, git@vger.kernel.org,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:55:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulklk-00037z-Kq
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab3FISzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:55:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62800 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab3FISzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:55:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A59825A99;
	Sun,  9 Jun 2013 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HadcFITHkQnrquIpdnZCcC0JkjY=; b=ZX9uld
	kxbCX2UcixT7VbzAJEInlfbEw5lswu/24t50zQLkXwxtc/7wlJhZ1poKHwQfWIIJ
	sEYNUP/4Nv9qTyTVr8RVvrOBo65EaU3TC7ViItbjB/8M7aS8zEZkPwBO0lv5yHql
	Z81d6/VaFUReI1SMiIwoUwjbROrhm9ueB9eos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hlpTfWm7yhMwflojs94feDFVwfhX1JwD
	sz/hb3nfWdn/wik7ADF//4gdcfZyKh4udW1GqbzESq/WsqAuy752Yh9pZqdoH7QD
	6MuriHCHPu0nYTJhqFh4fbdxW2qPQwhMV1mwk6x3Oe4GaxpUjjeNvNwTUdeeZNwD
	S03PPioqaGY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E47A25A97;
	Sun,  9 Jun 2013 18:55:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0167525A92;
	Sun,  9 Jun 2013 18:55:03 +0000 (UTC)
In-Reply-To: <CALkWK0kvKzFoZmz313hR-3Z71y-MDPT37BfUi7Qrgy7hz_sErQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 8 Jun 2013 20:55:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18452E7E-D136-11E2-B0C1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227098>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Jorge Juan Garcia Garcia wrote:
>> Some people always run 'git status -s'.
>> The configuration variable status.short allows to set it by default.
>
> Good feature.

Is there a corresponding command line override added to help people
who need to defeat such a configured-in default?  Otherwise it is
not a good feature yet, but just only the beginning half.
