From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick -x: improve handling of one-liner commit
 messages
Date: Fri, 29 Mar 2013 13:49:29 -0700
Message-ID: <7vr4iylyna.fsf@alter.siamese.dyndns.org>
References: <20130329153818.GB27251@suse.cz>
 <7v8v56p1bl.fsf@alter.siamese.dyndns.org>
 <CA+sFfMet0578rLwAKBBsd8DM3thsw=8+joEAAf44TzwqUZgXzw@mail.gmail.com>
 <20130329203915.GA5157@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 29 21:50:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULgFN-0007a0-6s
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 21:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab3C2Utc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 16:49:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50591 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756828Ab3C2Utc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 16:49:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98E92E872;
	Fri, 29 Mar 2013 20:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vj4u7cSDCgxhMSOJtgssDDeOXII=; b=Q/KItw
	dRMV6dxVrDawuhM+Cza/Chg9fgYcZIZud2kp6G7XXy6t1PzXbGMQbxp4U0Cc7vJe
	jnebamN+QXsEhsJKjOuWqBEAL3Rswm1IwYHHiXL21xqfoRBc/J9NgscVl/f4EygO
	btXAte0P7EScRkqcEwkthSB7YB669pznrWUww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xvhibtirYVRnQr2QTvN4ETe8o2oLeKxC
	PF4nPOn0gRwalYdHSwiLL2WqLgEGqV0QMaELChSFiok9BSZj2dVZ65EME/FAQJJE
	XjfPt37oN5/3si70wetNzKQ9PewUpvBbBJwRCW8YFK20YhT0lh52U4NJAX6Jami+
	ltYom//yPxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90BF1E871;
	Fri, 29 Mar 2013 20:49:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECA0DE870; Fri, 29 Mar 2013
 20:49:30 +0000 (UTC)
In-Reply-To: <20130329203915.GA5157@suse.cz> (Miklos Vajna's message of "Fri,
 29 Mar 2013 21:39:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 278E4328-98B2-11E2-A5A5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219530>

Miklos Vajna <vmiklos@suse.cz> writes:

> On Fri, Mar 29, 2013 at 10:41:17AM -0700, Brandon Casey <drafnel@gmail.com> wrote:
>
>> > I think this is part of the bc/append-signed-off-by topic that is
>> > about to graduate to 'master'; more specifically, b971e04f54e7
>> > (sequencer.c: always separate "(cherry picked from" from commit
>> > body, 2013-02-12) does the equivalent, no?
>> 
>> Yeah, I think this case is already handled.
>> 
>> Miklos, can you check out next and see if your problem case is handled?
>
> I just checked next and right, that solves the problem I was fixing.
>
> So -- sorry for the noise. :-)

Don't be sorry.

People noticing an issue, trying 'master' and 'next' to see that it
has already been resolved, is the only way for us to know we are
helping people other than those who had the original itch.

The ideal would be for more people to run 'next' and report both
problems and successes ;-)
