From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 21:16:55 -0700
Message-ID: <7vwqs3nm88.fsf@alter.siamese.dyndns.org>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
 <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
 <vpqzjwzkb4e.fsf@grenoble-inp.fr>
 <20130416005836.GC14995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 06:17:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URxKJ-0007Qh-5Q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 06:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab3DPEQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 00:16:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605Ab3DPEQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 00:16:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAA6A108B1;
	Tue, 16 Apr 2013 04:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oQBTONrsvQ2SFJrruq2vtwcWcoA=; b=KV1x05
	NeEfkdhOvwAJUR1olrV1TYeyycsp2D3ihzsaHqCPliwrROWBfv2LWkobQynM8z1p
	vvL1clSW70cnSmjA36WUjU2M4/7H3dywzygtNhNAtC0/Ooex2q1FNwsWDdC1hOPD
	MiLWizBVcDy082yEHT2NiVaa6+HX4AoAgZ6Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qaBvOouUQ5IeG/fQSvv6UjzhADUbGDOa
	K3bljhVRFWIFF8FDZhjxm6tfoUfFzTqvmmaPyrYo6YA1rdAX/OK3j2CEE0UhjMIX
	l5k5F7/+/I++zQe/EfMaZOpGlKrA/ixn7yVdJaIo83GhJB1Jg/oUp0tpfk9luXqK
	b5Zof0UfVD0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE32D108B0;
	Tue, 16 Apr 2013 04:16:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 346FB108AD; Tue, 16 Apr
 2013 04:16:57 +0000 (UTC)
In-Reply-To: <20130416005836.GC14995@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 15 Apr 2013 20:58:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A304F3E-A64C-11E2-949B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221359>

Jeff King <peff@peff.net> writes:

> FWIW, I do not think it was so much rejected as that I had initially
> planned to implement it, then decided against it. Mostly because I
> wanted to actually get annoyed with each piece of advice before
> disabling it. Because sometimes the right answer is actually "make the
> advice better".

I am pretty much aligned with this position. "Make the advice
better" not only refers to what we say (i.e. the message) but when
we say it, and keeping the advice variables enabled is the only way
to notice when we are being excessive.

I'd hate to see any Git developers running with advice turned off
for this exact reason.
