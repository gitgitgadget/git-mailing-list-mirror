From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Wed, 14 Apr 2010 12:32:09 -0700
Message-ID: <7vwrw9q18m.fsf@alter.siamese.dyndns.org>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
 <l2jfabb9a1e1004111635v16e4dc86g405883ca12d316b9@mail.gmail.com>
 <201004142110.36453.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 21:32:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O28K4-0007xW-9N
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 21:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab0DNTcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 15:32:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab0DNTcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 15:32:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43987AB683;
	Wed, 14 Apr 2010 15:32:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GM8+iorVBWD6pRYrAqy5IZQJ+Fk=; b=Jeg+yu
	aC88v/jncEj1sNdtL2maH1bLRoITdsAiDZlbUa1cUx4w5pWiBN+W+bof+za9gVwP
	gx1t9dRUWbARiY6Yu6hMbttorMXmN+41dX2M1VvuU+MLWjqovlSEHgf8jNfFLZXO
	UaHsIF7bcTmRs1d1uYZQrea6FpVkCRFNfymT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NQDhsuRNxvzNa5yENaj43fRefxJwAB70
	MrzYy4FxosZVmoxt2rQMoUE00vUOiq4Qim6+T8hGX9JeiUmpURJ3oaE8E3wJXIwY
	qQeMqHQ93JoR0RjlPR9XVnqVpwqwfFTosNdIgSdeZx/GTKbfQKR3ucuCwjOBi0/1
	dRsxYnBXSd4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB7E3AB67C;
	Wed, 14 Apr 2010 15:32:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12505AB67A; Wed, 14 Apr
 2010 15:32:10 -0400 (EDT)
In-Reply-To: <201004142110.36453.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 14 Apr 2010 21\:10\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F47916A-47FC-11DF-9223-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144896>

Jakub Narebski <jnareb@gmail.com> writes:

> I don't think it is needed for either command.
>
> 'git blame' has --porcelain and --incremental output, which is line-based
> and pretty much self-describing (with "header-name value" syntax for most
> of it), and well documented.  JSON output would only add unnecessary
> chatter and different quoting rules.

Wouldn't the exact same argument apply equally well to the output format
of "status --porcelain", by the way?  It is line-based and pretty much
self-describing (once you know the mnemonic but you can make an educated
guess from previous SCM experience).
