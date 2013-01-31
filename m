From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 14:48:42 -0800
Message-ID: <7vlib9dl4l.fsf@alter.siamese.dyndns.org>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <20130131223305.GB21729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 23:49:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12wP-0006wy-VM
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213Ab3AaWsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:48:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756273Ab3AaWsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:48:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3E28BF88;
	Thu, 31 Jan 2013 17:48:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RZJIidyfR8hDDQs7S4FXYxkDKCM=; b=bnTKSc
	m0Ki2JbC4UZnFOb3D6OMH7XIv/IWmP6DS/46JCk2L98IDkMEQlPYsb69S2s8/w+j
	bzkgyTM9sU077ZtZBKg7uZTYoyQofivb59uM0y4WpZgVv4MksItyIwwGDcjXu7Jy
	q29KJc5ROzKLrN5uEsk1uJL6ur+Z5l8VaNY64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r2X7VqsXfha86wrtvJrIDNIVS4qzlgRL
	Wt+qQ8bCtclWnrNtnT7f7XGh+q1wLh4HoHoXCsJkf2nuIciFndUsc/KbWi/QB2GN
	6opPRysJmUiHPx7SyaQwppGFnKUh5cMzPk05koa5PEsJp28PgIP+Me3vJp/IAREP
	VO+52g3kWSU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B90DDBF87;
	Thu, 31 Jan 2013 17:48:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F099BF85; Thu, 31 Jan 2013
 17:48:44 -0500 (EST)
In-Reply-To: <20130131223305.GB21729@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 31 Jan 2013 17:33:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5DB3C45A-6BF8-11E2-ADCE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215184>

Jeff King <peff@peff.net> writes:

> Maybe it is just me, but the fact that accessing the manpage is now:
>
>   man gitremote-helpers
>
> feels weird to me.

It feels equally weird to say "man gitremotehelpers" (or in general
"man git-thing" or "man gitconcept"), to me.  I gave up and switched
to "git help remote-helpers" some time ago.  "git help remotehelpers"
feels like a small regression.

> I dunno.

Me neither.
