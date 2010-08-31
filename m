From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 v4] Add global and system-wide gitattributes
Date: Tue, 31 Aug 2010 16:56:26 -0700
Message-ID: <7vfwxu8hg5.fsf@alter.siamese.dyndns.org>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
 <1283210123-19752-3-git-send-email-Matthieu.Moy@imag.fr>
 <vpqbp8i2yns.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Onderka <gsvick@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 01 01:56:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqah3-0003ZM-Lk
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 01:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab0HaX4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 19:56:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab0HaX4i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 19:56:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 755EAD212E;
	Tue, 31 Aug 2010 19:56:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ky5uLu4DcJvXYDxbIbC6s3BrNZs=; b=fZZFyK
	BEUuqUaVXVAE6V4tmlMRXak3VSA/i62TBRQg8zWms6Yg/n1s33w/XUXMcW5Jol3L
	JEENvHVE5bjtAfusUvl35ndfn3tDc6LtyGPcrsC40HACwkXw8ik5w96Aq2gYcJSI
	XqUCPShizdk1lUKNc9cF/ee2psEWL8awIPijk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v0/TcmY11AQLIcDt8PUYeAka0SXnjKbX
	KwYhaEbrIMaW2+R/LTilJNi+AtJIQoUQKORxE8hQC5d6r+aoQMXNmG7pEv/ySlbd
	TP9kaadXec1kBQyNfaDIwxiA+qD2Vo9ziR25XOlxPIcppuurAYIKrSM9PziCf2K5
	vjJ04F4Vt9I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09CD6D212D;
	Tue, 31 Aug 2010 19:56:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FB72D2129; Tue, 31 Aug
 2010 19:56:27 -0400 (EDT)
In-Reply-To: <vpqbp8i2yns.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed\, 01 Sep 2010 00\:41\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 61176DAA-B55B-11DF-BB6B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154998>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> This version doesn't touch config.c, and calls git_config with a
>> trivial callback reading only the core.attributesfile variable.
>
> I see that pu has a variant of my fix:
>
>   17cd572 fixup! Add global and system-wide gitattributes
>
> (is the fixup! here on purpose, or is it a failed rebase -i?)

It wasn't a failed "rebase -i" but was a reminder to myself.  I didn't
want to squash that in before discussing on the list.

> ... I'm resending my patch with this change for conveinience.

Will take a look; it will have to wait until my git Wednesday this week to
be pushed out, though.

Thanks.
