From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git subtree oddity
Date: Thu, 28 Mar 2013 22:47:18 -0700
Message-ID: <7v38verc49.fsf@alter.siamese.dyndns.org>
References: <1827202810.1012362.1364488493363.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Taranowski <tom@baringforge.com>, git <git@vger.kernel.org>,
	"David A. Greene" <greened@obbligato.org>,
	Stephen Smith <ishchis2@gmail.com>
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Fri Mar 29 06:48:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULSAQ-0003M6-E9
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 06:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548Ab3C2FrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 01:47:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931Ab3C2FrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 01:47:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D327AEF58;
	Fri, 29 Mar 2013 05:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TgiWOOOyOLzorofi5dd9glGLjcI=; b=QFVqUX
	WQupB2KBQJDNut88yWup+mRUPA+Vhj8pHn/WFZOOp6QcruH1ly3XHzjUSBV4H5zI
	2jgZnUPXJQQDzCqoeupFEhsayQhBwtlesOheeRgKLgpES13KJvH/755CmyAiceUG
	PQ7oubcJiwklQy1Ehm7KFKB1VXD0no7aEHySE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FpjXDYJygxf2rnee7AAx+4fQXhcKeMi9
	bWUbaEj/Sgegmg08u2XSZeMppP+6W2ju/NU/f73WY2gQ/g0GO9Wnm2qFpncT2+b/
	E8MWatm8c6BDTkn41DJHq7qYQhnHlAfe0SbAGOt5qahvBaYTDiPtSi0WP4jE77DM
	jTdY7EpW630=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA545EF57;
	Fri, 29 Mar 2013 05:47:20 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 332F7EF56; Fri, 29 Mar 2013
 05:47:20 +0000 (UTC)
In-Reply-To: <1827202810.1012362.1364488493363.JavaMail.root@openwide.fr>
 (Jeremy Rosen's message of "Thu, 28 Mar 2013 17:34:53 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F1C7DBE-9834-11E2-AACD-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219484>

Jeremy Rosen <jeremy.rosen@openwide.fr> writes:

>> I am starting to regret that I caved in and started carrying a
>> copy of it in contrib/.  It probably is a good idea to drop it
>> from my tree and let it mature and eventually flourish outside.
>
> that's a shame... it solves a real problem, is simple to use, and
> really powerfull.

I've never said the program does not solve a real problem, it is
hard to use, nor it is useless.  It just is not well maintained.

I knew (and I said), from the very beginning when people started
making noises about adding it to my tree, that I will not be a good
maintainer for it. I am not its user, I do not know what its users
expect out of the program, and I cannot read from its history what
the developers were thinking when they designed its features and
implemented its internals.

I started carrying it in contrib/ only to give it wider exposure,
but under the condition that somebody else would be the real
maintainer for it.

I'd say we should wait for at least a few days to see what David
says. Perhaps he is too busy with other things. Perhaps he needs
co-maintainers who are also interested in the program to help him.

Leaving it in my tree without real maintenance is not an ideal
state.  I do not know why you think it is a shame.  I honestly think
it will do better outside my tree.
