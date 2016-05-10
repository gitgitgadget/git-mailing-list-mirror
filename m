From: Junio C Hamano <gitster@pobox.com>
Subject: Re: syntax error in git-rebase while running t34* tests
Date: Tue, 10 May 2016 13:53:56 -0700
Message-ID: <xmqqy47hmy6z.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEiF9Ooi1f0O3KG0wYmN0KRWBQTNarXx79-wBD2E-8q2jA@mail.gmail.com>
	<xmqq60ulpw1s.fsf@gitster.mtv.corp.google.com>
	<20160510204758.GB19958@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 22:54:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0EfS-0002vX-0C
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 22:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbcEJUyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 16:54:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752577AbcEJUyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 16:54:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3587F19E61;
	Tue, 10 May 2016 16:53:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X2W4LvTHnvRYv8wYHXOiu3EdTDw=; b=oBZcY/
	gmB7E7cgjS9xD0yNM5NydUFkI/XepyIktM3UUU9mn8QodRAUYyMOXhxgywmuL1Mg
	eC6+AJSS5wPPZvgMvim8b2uNxBAyljAKSFUt6qvWpqgTEGk6mlRh2Tmf89A3kJq/
	jH1AKpLv0RkyzqSKnsbspTR0mV6DZO5ctfXjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M9bWtn91I3ykXYzifCD4ZFoonOmZt69I
	uZm6FBOB7JbhcTClsiuc9ecTHLDxkXwTP1praEdhzWmtWBF2stqf6UHzBcD/2WIm
	125/4lj5ZipF170qDiYpz+hIazLdXfNZMSShFlvUuClomwKg4o6V6xYbUGm1ICmG
	mL9Phz0CJk0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E3C119E5F;
	Tue, 10 May 2016 16:53:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A64DC19E5C;
	Tue, 10 May 2016 16:53:58 -0400 (EDT)
In-Reply-To: <20160510204758.GB19958@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 10 May 2016 16:47:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5137DC6E-16F1-11E6-9A01-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294190>

Jeff King <peff@peff.net> writes:

> I think it is clear why it works. If $strategy_opts is empty, then the
> code we generate looks like:
>
>   for strategy_opt in
>   do
>           ...
>   done

Ah, of course.  Thanks.
