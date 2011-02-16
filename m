From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Wed, 16 Feb 2011 09:56:10 -0800
Message-ID: <7v8vxflv7p.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <vpqy65gs6hs.fsf@bauges.imag.fr> <alpine.DEB.2.00.1102160421300.14950@debian>
 <201102161108.26637.jnareb@gmail.com> <vpqhbc4mg1c.fsf@bauges.imag.fr>
 <AANLkTikq67jQnM555nHKeyk5t0Ln+Hp97WSztTaej_CW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 18:56:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PplcL-0006iE-T6
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 18:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab1BPR4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 12:56:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab1BPR4i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 12:56:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 11A224869;
	Wed, 16 Feb 2011 12:57:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UPWQ9JXZlxmHCNEOpLDM0ecXl5w=; b=aNVlIV
	f9keCOXiqbNhmRoiH5Hc1KJofdmQFFYCKpJuloZEO/0xR4rWR7xL9OgonnGDNea3
	Eu2FB9bM9oxLocV4ICjzhAxul+20vMQqiJ+BmIhUQ6OVUTQ4sIX+4hQa8qnbX8ur
	O/HvpqTwVx7AquzBLsSh2iKJCECHr22AoaQlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qvi+mLyOHbiBLQW2htOoQIyUoYTbGjn3
	QO3pMKYRFCfbq5PhUOlEDTNtbNVDFYsD/UdEZ7wsSNe6bf0LN3lk7qYlGLGFgtlm
	NDm5eUINZMCto/9ZPdjHhYJpMuUoWrNdV/vO7c6jtEMcREKLIfNHtAUloflvNPp6
	wXhhBjhFPWI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 614644864;
	Wed, 16 Feb 2011 12:57:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E37014863; Wed, 16 Feb 2011
 12:57:17 -0500 (EST)
In-Reply-To: <AANLkTikq67jQnM555nHKeyk5t0Ln+Hp97WSztTaej_CW@mail.gmail.com>
 (Sverre Rabbelier's message of "Wed\, 16 Feb 2011 10\:27\:47 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39AD2F14-39F6-11E0-B6D4-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166980>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Wed, Feb 16, 2011 at 10:26, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> I think that for 'branch.<name>.upstream' it would make more sense to
>
> I like the idea of naming it 'upstream', although I don't care much
> either way for restricting what you specify. I've always thought
> 'merge' was a curious name that didn't really fit with my mental model
> of what I was configuring.

That pretty much comes from the days back when 'merge' was the only method
of integrating with what the other party did.  

I agree "upstream" is a better name.  The name "merge" is about what
operation uses it, and does not say why it is used (i.e. "we merge with it
because it is _the other end_ of the integration"); the latter is a more
important thing to express.

Until another method of integration (namely, rebase) started using the
same mechanism, this was Ok, but when it happend, the name "merge"
immediately stopped making sense, but we did not rename nor give a synonym
to the variable.

The name "upstream" prepares us for yet another method of integration that
nobody has invented yet.

As to its value being what the other end calls the source, I think it is
not a good idea to change it, and it is even a worse idea to add a new
configuration variable that points into the tracking branches on our side.
@{upstream} is a short-hand notation to call the tracking branch of the
"upstream" we have been discussing, and has to point at refs/remotes/
hierarchy, but the entire point of the notation is that the users do not
have to see/type "refs/remotes/" when they say

    $ git merge @{upstream}

but at the level of an end-user's world-view, his branch that was forked
from origin's "master" integrates with origin's "master", and the use of
an intermediary, the refs/remotes/origin/master remote tracking branch
that is kept on the local side, is a mere implementation detail.

IOW, I consider --set-upstream that takes refs/remotes without bothering
to go through the remotes.<name>.fetch mapping is a design bug (it may
have come from sloppy initial coding---it certainly is easier to store
what you get without computing anything).  That may be something we might
want to fix in 1.8.0.
