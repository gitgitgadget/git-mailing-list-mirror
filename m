From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2014: Summary so far, discussion starter: how to improve?
Date: Tue, 22 Oct 2013 14:31:35 -0700
Message-ID: <xmqqli1lro08.fsf@gitster.dls.corp.google.com>
References: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Oct 22 23:31:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYjYF-0002U5-R9
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 23:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147Ab3JVVbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 17:31:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754647Ab3JVVbj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 17:31:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 579734C3BD;
	Tue, 22 Oct 2013 21:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VfEYI4/hglgZW4yvE6bVbNMzJOA=; b=HOoPo5
	9SZXz8n4fplCYugAa2DEuSzeAnJb65xqqiZrR5o/aatYYeyjjOBzXQC/yMf2bru+
	U7Ly7EqL+ScGYl7QFRcN9rDyECLarF+3uEuPIBiCgg8a85yVt41uGlS365RLZW+8
	vAOV4537Q5bFQ5lasmd7a1/D7cIO/HVyH1v4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hWyt48POm2PPgDWwaA3Arxrodrz/+xis
	L5SGQANdQJkhnHL3UQ+3pJLIbU+xNIj7LlpS0dLQ6qZtv1M2LjNFiUhP/ibQY+XT
	5tiV1pdCaZkjigaQAx5N9HhC4Wn34FdY49+d3RmadgUJBKU8m933q397nIvVcCXC
	J3LI0a4BxAo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BFBA4C3B9;
	Tue, 22 Oct 2013 21:31:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B8C34C3B8;
	Tue, 22 Oct 2013 21:31:37 +0000 (UTC)
In-Reply-To: <8761stx04i.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Sat, 19 Oct 2013 08:09:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5513D022-3B61-11E3-A380-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236491>

Thomas Rast <tr@thomasrast.ch> writes:

> Theories
> ========
>
> These are the hypotheses that I have heard (mostly in [1] and [2]) as
> to what is bad about Git's prior GSoC participations.
>
> * Aiming far too high, focusing on cool/shiny projects with a large
>   impact.  This also affects the students, who tend to cluster around
>   the largest, shiniest project suggestions.
>
> * Diminishing returns: Git is too mature, with little low-hanging
>   fruit left, making such projects harder

This needs to be qualified. There probably are little low-hanging
fruit left that still are shiny and cool for a newcomer to tackle.
That does not mean there are little low-hanging fruits that would
help our users; there still are a lot. Just that they are not as
glamorous.

> * Projects are too political, progress depending on non-technical
>   arguments

I do not recall any such.

> * Scope creep: projects tend to get blocked on some bigger
>   refactoring/restructuring task that was not in the original
>   proposal.

I think that is a sign that the original proposal did not look
enough at the existing code, dreaming of a pie-in-the-sky shiny
features in a green-field setting. What needs to be done within the
constraint of the existing code (including a total rewrite, if
necessary, while keeping the project's codebase maintainable is part
of the healthy develpment.

> Ideas and Suggestions
> =====================
>
> These are mostly from [2].  There were some suggestions that we learn
> from Matthieu Moy's very successful student projects (eg. [4]).
>
> * View GSoC much more as a lot of work than free labor
> ...
> * Mentoring improvements:
>   - Always have a co-mentor
>   - Focus on social aspects (who to Cc, etc.)
>   - Nominate separate "review mentors" to ensure fast review cycles

Good.

> * Have students review some patches

I am not sure if this would help.

Reviewing the patches to find style violations and off-by-one errors
is relatively easy as it can be done with knowledge on a narrow
isolated part of the system. Reviewing the design to make sure that
the change fits the way how existing subsystems work, ranging from
the internal API implementation level to consistency a changed
behaviour is presented at the UI level, however, needs understanding
of the far wider entire project than only the parts of the system
the proposed change updates. It will be even more true if the chosen
topic is a cool/shiny one.
