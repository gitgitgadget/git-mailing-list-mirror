From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/5]rev-list and friends: --min-parents, --max-parents
Date: Wed, 23 Mar 2011 10:12:47 -0700
Message-ID: <7v4o6tg3qo.fsf@alter.siamese.dyndns.org>
References: <20110321105628.GC16334@sigill.intra.peff.net>
 <cover.1300872923.git.git@drmicha.warpmail.net>
 <20110323144835.GA30337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 18:13:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2RcP-0001Fo-Eo
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 18:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab1CWRNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 13:13:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44156 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab1CWRNG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 13:13:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77D094463;
	Wed, 23 Mar 2011 13:14:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WK+aNCysUL+X54HvFUr8A0sRtRE=; b=BGr4lB
	RuFXjmg84S9KFPw/TRdUcSC7WQu94dCUrP+zisAecgBklMSf6VML8nRAc9hsp9QO
	Hr3IrqfQHIrM6Z6xCe5ctbuJFUATuJgtFEvLI1lvuuqvfowjh9dUtzdcYW4m2bbl
	WKKMYloDi1mP62J2uRCi2lRWLGjYlckbJ6n9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Edl58hbPieWyeS0LEXSgGNQag7N2zq86
	FdxGI+NXNs15iJuU7OJ7kHPY7aCVkeQZ8ye+28dZSkhmuEh7i2qnZ+6OEyZ8vKn1
	4FXa1ylzBP87yUmG6Cd45UzM7TDFoZTGDGqaHRSpKKGU1jeAsefZ1toE/m+lqniR
	S+zn/y9iSog=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37B234462;
	Wed, 23 Mar 2011 13:14:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D5078445D; Wed, 23 Mar 2011
 13:14:30 -0400 (EDT)
In-Reply-To: <20110323144835.GA30337@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 23 Mar 2011 10:48:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 085F6BAC-5571-11E0-86F0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169857>

Jeff King <peff@peff.net> writes:

>> Junio, please let me/us know whether sending an amended series in this way
>> (which I've seen before) is actually convenient for you or not. !squash
>> commits require a message edit, for example. OTOH, I don't know any (other?)
>> good inter diff solution.
>
> As a reviewer, I find it is usually most convenient to just have the
> submitter do the squash, and then write below the "---" (or in a cover
> letter like this) a brief explanation of the differences.
>
> Yeah, I end up reading the whole patch again, including bits I already
> read, but that is probably a good thing. A good patch is hopefully not
> too long, and it is easier (to me, anyway) to review it as a whole and
> not as an interdiff.

Yes.  And that would also make it easier for people who didn't read the
earlier round to double check.
