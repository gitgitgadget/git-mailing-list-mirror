From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Fri, 19 Jul 2013 12:40:55 -0700
Message-ID: <7vli52uym0.fsf@alter.siamese.dyndns.org>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
	<87wqon7ok4.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rahul Bansal <rahul.bansal@rtcamp.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jul 19 21:41:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0GY6-0007gb-FD
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 21:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010Ab3GSTlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 15:41:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923Ab3GSTlA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 15:41:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66BF23234B;
	Fri, 19 Jul 2013 19:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qZzvCatY3WAcd5w5imCkWVT8uDs=; b=e9taL8
	EJdjUv3Duu4gXUJOKLMm8WqnuZrjUypqm21O6XaNU//WU9ku1ggn9xsAIYYb7qUS
	CHXyoFQ2isvYqMQlaUSDfm1qXcCUWcHg3bvYwRSilxi3A+Gf7wiPMyproAbvbHkX
	g7ZNSzEFeBgDP4FILm5Grk+aNuJ/bAJgLj8jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AYigAckRkr1krr9acduDe96EcZ1RdPpf
	9xMwIEVBDn7BI5SENSN/jMcgKMdSUx872p/eFNTPefPNFnSs3r3MIaV2xK7MoPsY
	+OrWKcNrts8t7miH0c1TxH7ZvJ2oLieicXVg5gTsHyO7zBGuLH1khzrXenID8TlU
	qLw3i7YnPNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A83E3234A;
	Fri, 19 Jul 2013 19:40:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B815432348;
	Fri, 19 Jul 2013 19:40:56 +0000 (UTC)
In-Reply-To: <87wqon7ok4.fsf@igel.home> (Andreas Schwab's message of "Thu, 18
	Jul 2013 19:42:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 218F2766-F0AB-11E2-A10F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230843>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Rahul Bansal <rahul.bansal@rtcamp.com> writes:
>
>> IMHO "git tag" is expected to show tag-list ordered by versions. 
>
> A git tag can be anything, not related to versions at all.

Correct.

But that does not prevent somebody to add "git tag --sort=X" option
to the command, just like "git for-each-ref" has "--sort=X" option.
