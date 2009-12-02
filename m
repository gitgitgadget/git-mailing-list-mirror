From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add --track option to git clone
Date: Wed, 02 Dec 2009 15:02:23 -0800
Message-ID: <7v1vjd9dz4.fsf@alter.siamese.dyndns.org>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net>
 <20091202192028.6117@nanako3.lavabit.com>
 <20091202190807.GB30778@coredump.intra.peff.net>
 <20091203060708.6117@nanako3.lavabit.com>
 <20091202223728.GB9691@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	David Soria Parra <sn_@gmx.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 03 00:02:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFyDY-0005Wg-CS
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 00:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbZLBXC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 18:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754856AbZLBXC3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 18:02:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952AbZLBXC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 18:02:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDE23844BA;
	Wed,  2 Dec 2009 18:02:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4JOLYPKQn9jRcS4rYPrRb8MSW84=; b=Jlp3kT
	9nJRQ6TOZWFAyW4qMNJ5I9QWkrKP4RygcQU7qdYBenorPmvj3L2wVD7T+yRbr4ab
	9hZdvOdd6jJWZBhgzdceHWhC1Om/jOcdFsCRt0ROd5aAZilBBx58G8VlaSejzePf
	/v/PWyOlMAhHeCenwSjiQIiTGxMH7byZwP6ww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=INoAoKzrPPpLYViH0uo5UAW9SUdLPgu0
	Dufqy5HCaV8p8EPyAqA19y9KLW12kjGo1wXC2LSao1AYHvmDi/CDtv4hRQ8aRvv5
	xgze5T7TcFklJo2O0/psYAiJfALHYkw23rflEmuz0KYV3TGFKtm5gtdIJDSv0ufB
	o+RLWjD+/b4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CA25844B7;
	Wed,  2 Dec 2009 18:02:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDAD7844B3; Wed,  2 Dec
 2009 18:02:24 -0500 (EST)
In-Reply-To: <20091202223728.GB9691@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 2 Dec 2009 17\:37\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C41DA41E-DF96-11DE-B688-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134417>

Jeff King <peff@peff.net> writes:

>>   git clone -f maint,master,next,pu git.git
>
> Yeah, that is much nicer. I think "," is allowed in ref names, but I
> am tempted not to care here. It is not as if this is a low-level
> feature, and most people will not be crazy enough to use commas in their
> branch-names. IOW, you will get into trouble only if you have crazy
> names _and_ you want to use this particular feature. If we wanted to be
> complete, we could provide a quoting mechanism, but that is perhaps
> excessive.

Yeah, I agree it is Ok not to support crazy people in this case.  Not
supporting from the very beginning is quite different from _breaking_ them
;-)
