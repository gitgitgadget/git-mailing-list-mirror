From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make color.ui default to 'auto'
Date: Wed, 15 May 2013 11:08:08 -0700
Message-ID: <7vppwsazg7.fsf@alter.siamese.dyndns.org>
References: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
	<1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vy5bgckr4.fsf@alter.siamese.dyndns.org>
	<vpqhai4fbsn.fsf@grenoble-inp.fr>
	<7v8v3gcfk1.fsf@alter.siamese.dyndns.org>
	<vpqwqr0azz7.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 15 20:08:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucg7d-0004eZ-7G
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 20:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943Ab3EOSIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 14:08:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932566Ab3EOSIL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 14:08:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23DCA1EB08;
	Wed, 15 May 2013 18:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lkss+ftKg348kgVri/iEtqfDjVE=; b=uFE2qj
	YnpqFK57CSLJAKFFj4/Y8Se2AhGyA5hjKUz1W0XxLNYvyDBTe1hpgxCmQJTTWcYX
	LzICwL36H4iJZXILOZUXI2hT5DMwghsPxXBPNm6DXyKMOuDqQK6dWw93fGYl6j/U
	bbXKq7FQmSGKQKA+xypvGa3U8MqM8qOw824Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YyEq06U8HvqsI0ZZ1Kzzi/XKEIWw+iHr
	BVReucgHwPKfyp/ZN8PYd1JNZ+oMkWcJ0ihT19ge/QN83GfgeWmqpATcDZP+ht55
	Vc7rW8exBA3xrmDRaI+KlMQhh2GsdnCYf9MTxu6Cg25T5ViuiQV/11NilP8d0u0o
	z65ur0w/hRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BDFC1EB07;
	Wed, 15 May 2013 18:08:11 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45D4F1EAFE;
	Wed, 15 May 2013 18:08:10 +0000 (UTC)
In-Reply-To: <vpqwqr0azz7.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 15 May 2013 19:56:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66D566A4-BD8A-11E2-9A81-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224435>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I think you are missing the entire point, which is not "is anyone
>> harmed?"
>
> Again, it is. If the new default is really harmful for too many people,
> then documentations will have to mention how to fix it.
>
> And really, I do not forsee any newbie-oriented starting with "here's
> how to disable colors in case you need it", because of the reasons
> mentionned in the message.
>
>> Our recommendation has been "use color=auto"
>
> Not really. Neither Documentation/gittutorial.txt nor
> Documentation/user-manual.txt mention colors. Pro Git mentions it, but
> more as a possibility than as a recommandation. This is the
> recommandation of the rest of the world, not "ours".

Do you mean the git users who learn and use Git without being in the
circle of people who updates Documentation/ hierarchy "the rest of
the world"?

I think that is a flawed mentality.  They are part of "us".

> It's not "either we update the docs or we update the code", it's "follow
> what the rest of the world is doing", and "rest of the world" has to
> imply a notion of majority (not all tutorials talk about color.ui).

Yes, exactly.

Read the statement you made again, with the assumption that
everybody ("the rest of the world") already knows (and/or agreed to)
colouring is a good thing.

> ... Other beginners do not know about
> color.ui=auto, and may not discover it by themselves, hence live with
> black&white outputs while they may have prefered colors.
>
> A few people (e.g. color-blind) prefer having no colors, but they can
> easily set color.ui=never for this (and googling "disable colors in git"
> already tells them how to do so).

Now, realize that after switching the default, these "few people"
have to live with distracting (or unreadable) output.  Because these
people are minority, their websearch "disable colors in git" will by
definition have smaller number of hits than "enable colors in git"
the above claims people "may not discover it by themselves".  In a
way, you are making things even harder because these minority do not
have many similar others to ask help for.

That is the honest way to express what you said in the second
paragraph.

If we really want to justify the changing of the default, we should
not try to weasel out by using asymmetric wording from the fact that
we are making things less convenient for one kind of people.  We
should be honest and say what we are doing: "it will make things
easier for majority while making it less convenient for minority".

I am however saying that in this case, we are better off not even
trying to come up with such a lame excuse for us to hurt color-blind
people in order to make things easier for majority.  Just saying
"the rest of the world prefer automatic color and that is what we
recommend, so make the code match" should be sufficient.
