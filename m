From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git as an sfc member project
Date: Fri, 22 Oct 2010 14:48:09 -0700
Message-ID: <7vd3r1lx0m.fsf@alter.siamese.dyndns.org>
References: <20101022183027.GA12124@sigill.intra.peff.net>
 <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 23:48:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9PTO-0005u4-Dr
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 23:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541Ab0JVVsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 17:48:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab0JVVsU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 17:48:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 62DE4DFEEF;
	Fri, 22 Oct 2010 17:48:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F7vQnK94AyMdBUI6EUaPi/xdrCw=; b=OQncuh
	gvPNkiYwKcon2l4wScT8L2JLBtGW4NXeWm0oY7GlWr2+RcS6OnxJAcQXHdhQHnm3
	FzMfh5XIQChjLg7yn3t9nLhqPLuTYew/BnbFlxNnzaQDAdgfF4++gn4F92tG2Skn
	8pGujh1E+xjVhuQdBZ0UZrmFiJJOisadAYlnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjI7uc3ZLCfNNGuswY42p3OXV7X8xIwa
	s1vr3qxGiGz+Vprx7jfv5NgVWnxqkIeScJ8mDO2AE/SRQKgXUED6y9CP02S+vUhO
	CRQAX6Xix+TyDiXP5/GTLM2HNnZQXVI9kEkeI/GhDkJ/drMSCRAUijJqzXZz02Kl
	l4Twwc9Ovn4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22574DFEEE;
	Fri, 22 Oct 2010 17:48:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45A36DFEED; Fri, 22 Oct
 2010 17:48:11 -0400 (EDT)
In-Reply-To: <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
 (Shawn Pearce's message of "Fri\, 22 Oct 2010 12\:19\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 12DF00BE-DE26-11DF-8C9D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159755>

Shawn Pearce <spearce@spearce.org> writes:

> The people listed in 2 as the leadership structure of git.
> ...
>>     Personally, I favor a small group which can approve new people to
>>     join, and which can leave at will. Having more than one person
>>     avoids hit-by-bus problems (or even just dropped-off-net problems).
>>     There is little enough power in such a position that I'm not too
>>     worried about some crazed egomaniac becoming the Git-SFC liaison.
>
> I agree.
>
> I think a committee of at least 3 people and at most 5, any of whom
> can be a benevolent SFC liasion, is fine.  As far as selection goes,
> the committee can elect or remove a member through a majority vote,
> and should base its decisions based on surviving contributions to the
> code base, but shouldn't be tied to that (just in case someone
> contributes a lot of good code and then becomes a jerk).

Small group like 3 to 5 to avoid bus factor sounds reasonable to me.

Because my involvement in the project does not relate to monetizing git, I
can safely be included in them, I think.  If people do not mind me being
that jerk you meantioned, that is ;-)

>>  3. How much money should we give to the SFC?
>>
>>     A big chunk of their budget comes from taking a percentage of
>>     member project money. As a project, we set the percentage we give
>>     them. So we can give them nothing if we want. But they do provide
>>     useful services, and even without direct benefit to git, the SFC is
>>     promoting free software. So probably it makes sense to choose some
>>     non-zero number.
>
> I agree, a non-zero number.  2-5%?  Any idea what is typical?

As you two agreed 10% sounds fair to me.
