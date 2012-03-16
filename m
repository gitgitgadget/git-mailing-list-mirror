From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Fri, 16 Mar 2012 15:00:57 -0700
Message-ID: <7vty1odx46.fsf@alter.siamese.dyndns.org>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr> <7vty1rqek5.fsf@alter.siamese.dyndns.org>
 <7vlin1gl9l.fsf@alter.siamese.dyndns.org> <20120316091019.GB22273@ecki>
 <7v3998kb0x.fsf@alter.siamese.dyndns.org> <20120316172013.GA8119@gmail.com>
 <7vk42kh11k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 23:01:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8fDF-0003pd-5l
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 23:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965370Ab2CPWBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 18:01:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50612 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757716Ab2CPWBA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 18:01:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE4086279;
	Fri, 16 Mar 2012 18:00:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xf3KYvvrCI6Jh6mO/vihseHPwIU=; b=V5CgAs
	H9UVfFGSH9xIPNRLpy+Ce8qf06UJagrPgRCXitjoZuADVAp1ijLNn76rY2V3rI0Z
	308yjmigPTeD1ugsltUe0NBnab/V0Y8kWxSCdIkirR389YFTU2zLF+Ah83ePNI/i
	OBeoS5/fR1cwTPMAdnjpKwxlQT8W3ehZtCxFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IKYSbdjM91Pg41cyEIp+rw3jGYzXOOHW
	idV5HScRyvOvYdZzvyDJLMjIPUW9Uw7MXY9/c3q5ilSjG9bpAT1iNLUziwd5TP3p
	Kib9OmyQEICTcT3iICbE2wzh8NBfWjWhn2SiYieEU5qocYnW5tj/6zebfDB4gBl0
	xV76wnebtI4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 807EC6278;
	Fri, 16 Mar 2012 18:00:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1369E6277; Fri, 16 Mar 2012
 18:00:58 -0400 (EDT)
In-Reply-To: <7vk42kh11k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 16 Mar 2012 11:07:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 835336BA-6FB3-11E1-A243-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193286>

Junio C Hamano <gitster@pobox.com> writes:

> After reading the fix-up patch again, I actually have a couple of
> comments/reservations myself.
>
>  (1) I suggested (and the fix-up patch does so) to use a single existing
>      advice configuration, but ...
>
>  (2) The advice to "Your current branch is OK but you are also pushing

Well, (2) is untrue.  Between message-advice-checkout-pull-push and
message-advice-use-upstream, we already capture this difference just fine.

Sorry about the noise.
