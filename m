From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Documentation: Add filter.<driver>.* to config
Date: Wed, 06 Apr 2011 09:50:50 -0700
Message-ID: <7vpqozjpcl.fsf@alter.siamese.dyndns.org>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-2-git-send-email-artagnon@gmail.com>
 <4D9C4E0F.8050302@drmicha.warpmail.net> <20110406124235.GA5881@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 18:51:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Vwu-0005q1-KS
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 18:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535Ab1DFQvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 12:51:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab1DFQvF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 12:51:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4FA5F4ABA;
	Wed,  6 Apr 2011 12:52:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0CG11nWMI3OF0PglKcpxRYOXXBI=; b=pKwHAR
	JxPBx97rQAn2N/t+dGzujF5TrhN9DE3i/FwexfPYWmILCgMEVqlHh3ptKjdfkF2E
	i1vAKqLdXZR4CxXOi7zJSxErFBcGIVyPZ+Wo5sJkIHVWML+RedzkEL0jJ9mmzNQF
	O5AsM1nXCZOgD7iLVgB5hFGDQUjq5vdmGh+sE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CC5Fv1upVz4qnkp7QmCg425U0YJuKhwr
	RVZbQ9opPLOq0ljBTDGPiT2C2zx6w6Tcyq8z4llpji+lbToRPDWvRMZtCwZoCuCQ
	/by2zBKvwEAOHU2LtipqqcWrWspibtypZeynbM0THW/VhI5QTwQhDkdCB63XybxN
	izUurkWfu8s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D9504AB9;
	Wed,  6 Apr 2011 12:52:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 87B114AB8; Wed,  6 Apr 2011
 12:52:47 -0400 (EDT)
In-Reply-To: <20110406124235.GA5881@kytes> (Ramkumar Ramachandra's message of
 "Wed, 6 Apr 2011 18:21:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50382A42-606E-11E0-9D68-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170990>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I'm very sorry to have caused so much pain.  Yes, I can imagine how
> terrible it must be to review several iterations of a simple
> documentation patch.  Thank you for being so patient with me so far- I
> understand if you don't want to do this anymore.
>
> I do spend time proofreading patches before sending them out, but I'm
> clearly not very good at it.  In future, I'll either try rewriting
> entire paragraphs or simply refrain from writing documentation patches.

I do not think that is the lesson you should learn from this exchange.  A
major part of Michael's complaint (which I think was justified) was that
he even made a suggestion that is ready to be cut-and-pasted, but your
reroll does not use the suggested phrasing _without_ explaining why it
doesn't.

It is not limited to "documentation patches".  If you get a "how about
doing it this way---isn't it cleaner?" suggestion to your code patch, you
at least owe either "yeah, that looks better---thanks, I've used it in
this reroll" or "no, because...; I've used the original" to the person who
tried to help you, no?
