From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A few questions about git-reset's reflog messages
Date: Fri, 22 Jul 2011 13:57:21 -0700
Message-ID: <7vzkk6vupw.fsf@alter.siamese.dyndns.org>
References: <4E287DDE.8020108@avtalion.name>
 <20110722161222.GA20700@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ori Avtalion <ori@avtalion.name>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 23 00:03:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkNp3-00043V-Au
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 00:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614Ab1GVWDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 18:03:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420Ab1GVWDm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 18:03:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 925AD533B;
	Fri, 22 Jul 2011 18:03:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=b1XmTnzfG/V7ZOOIBDqsDmh3wRo=; b=nItx6uice2VsCSWo4zIy
	BIXv2Hv8Res7i+IvCn3o25qZ9ctq+8uRnVsfTUTrzTE56tPh6wRoLGQaEQ4IQ549
	uNnsTyaogdKoN1AwTRueFWiP0cN3WJtzrzWtXbndmRriRy7oMaZ3NwwKv/If4rVk
	Y5nVsclsleLoRNw7sMKwHYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XhYQPxstsuA+nAe1W1ycsuL6YKUndc+Q2oj8jR9Q7ZZJG9
	6CpkLi2ryOxKQt2LUB7xGS0hwZScSF0kz7F09nU9KDt012j4Aze3NOVfSRf8Aeft
	euZzMxNlTx9ymL5MgOf7m4UqxonYUedYmIZzFwkAh3K4BfmChKLRcL33TrjxA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A350533A;
	Fri, 22 Jul 2011 18:03:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A85B5339; Fri, 22 Jul 2011
 18:03:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 759611DE-B4AE-11E0-8AA5-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177673>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] reset: give better reflog messages
> ...
> This patch changes the reset reflog code to show:
>
>   $GIT_REFLOG_ACTION: updating {HEAD,ORIG_HEAD}
>
> as before, but only if GIT_REFLOG_ACTION is set. Otherwise,
> show:
>
>    reset: moving to $rev
>
> for HEAD, and:
>
>    reset: updating ORIG_HEAD
>
> for ORIG_HEAD (this is still somewhat superfluous, since we
> are in the ORIG_HEAD reflog, obviously, but at least we now
> mention which command was used to update it).

Looks sensible; thanks.
