From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2010, #05; Wed, 15)
Date: Thu, 16 Sep 2010 09:14:54 -0700
Message-ID: <7veict4qdd.fsf@alter.siamese.dyndns.org>
References: <7viq266461.fsf@alter.siamese.dyndns.org>
 <AANLkTimd0j4toF6kEF+6H_-JcE60aA2jbM67PoLjJ=bs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 18:15:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwH79-0006On-MP
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 18:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139Ab0IPQPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 12:15:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717Ab0IPQPD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 12:15:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49753D6D62;
	Thu, 16 Sep 2010 12:15:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wQ3uJ+4jlwe9K+chMXnqEUShkiM=; b=x0Ub6G
	X4Xj8ZHMQ834M9r316XgyETDihwJRupiuc2y6L0EbBEkVoQqbMJwB8icoU58UQAH
	pqzfZUyvO4cycD4J4kKWSrs4U0gpiU+Ir4myxmG8SEogd9G+eYehoVqukdRgoOUt
	fyvIax3izHEAE5HJ12Ol2850I+CKnCoGLJs7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ljRfVKBLsRcTJ//oAQyLSyHtoo06mZ+D
	lWUhFjOxLwGu1nj7DqPX31qkwLsUSLRBnz7N93NKZTTW3xRxSh/0CqUzTPTJFU5o
	yLjB8pMFhR4trrQa4AYp9EIa5SBCG0RdRnBtb1etcMVln83w7/8MtElVCQh7IT3u
	3Nr9CsTQuGY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 233F1D6D60;
	Thu, 16 Sep 2010 12:14:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E4CBD6D5F; Thu, 16 Sep
 2010 12:14:56 -0400 (EDT)
In-Reply-To: <AANLkTimd0j4toF6kEF+6H_-JcE60aA2jbM67PoLjJ=bs@mail.gmail.com>
 (Bo Yang's message of "Thu\, 16 Sep 2010 23\:23\:06 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8D750980-C1AD-11DF-BDBD-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156341>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Please put the revision before the '-L' options, you can run:
>
> git log -p origin/pu  -L 440,450 t/t7300-clean.sh

This goes against all the command line convention used in git, which is
"subcommand, dashed-options, revs and then paths", doesn't it?

What else was broken with this series, I have to wonder...
