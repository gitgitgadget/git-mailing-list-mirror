From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-add.txt: Explain --patch option in
 layman terms
Date: Sun, 30 Aug 2009 15:13:08 -0700
Message-ID: <7vskf954sr.fsf@alter.siamese.dyndns.org>
References: <87ocpxb46g.fsf@jondo.cante.net>
 <7vab1hdppb.fsf@alter.siamese.dyndns.org> <87tyzp9da4.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 00:13:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhsee-0002Lp-K5
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 00:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbZH3WNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 18:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbZH3WNS
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 18:13:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbZH3WNR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 18:13:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 230F31F8CD;
	Sun, 30 Aug 2009 18:13:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iaD0EF2LNBOn++dMa5HGenLAT/E=; b=ruqUzp
	JI9LZx/rFXCAlVmpJppqtuXg95Q8hFwB0/Q2z8gmdhyZ7CEwcPIzS7EpkwqsIH7x
	4alS+J1Bh7TmDWZRHdOfn5kpdbjEeUZLvrDszEktYh8hcCs0NmxfACIfpyRoEHUF
	fvvKjggWUOz8n1gHicC+B4OtUdCV3dgzelh+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hWi7Gqp7KlVULbZufwNB1qlHBuCufiEc
	CPEmPBTLh2ue/mK9n0Fd9OE/zOQX+1vzvVN9oH6VfW5aLJAubJClVoJLMJLj9qHf
	YAYyYaR/eh7U9puK2Bmwkd6brvvmdn8aMhJuGIfCyBb6CCVHeHicZ4BhQ3XjhXE3
	xrJM2qZXeJk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0280B1F8CC;
	Sun, 30 Aug 2009 18:13:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72F141F8CA; Sun, 30 Aug
 2009 18:13:13 -0400 (EDT)
In-Reply-To: <87tyzp9da4.fsf@jondo.cante.net> (Jari Aalto's message of "Mon\,
 31 Aug 2009 00\:56\:19 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50CA0A30-95B2-11DE-A06E-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127441>

Jari Aalto <jari.aalto@cante.net> writes:

> It is not shouting, but standard practise to refer to manual page
> section in ALL CAPS, when they are top level headings, like in this
> case.

Why are you making excuses, ignoring the fact that you didn't have a
matching update to make the section also in caps in the patch?

Sections that are common in all manual pages (e.g. NAME, SYNOPSIS,
DESCRIPTION, EXAMPLES, SEE ALSO) are often spelled in and referred to in
caps.  You do not have to explain that to me ;-)

If you wanted to add "Interactive mode" to that set of "common sections"
and spell it in caps, do so consistently.

See http://www.kernel.org/pub/software/scm/git/docs/git-add.html#_interactive_mode
for what I mean.

>> I personally think fixing misworded phrase "initial command loop" would be
>> sufficient.  It should read "initial command menu".  Perhaps like this.
>>
>> 	Run ``add --interactive``, but bypass the initial command menu and
>> 	directly jump to `patch` subcommand.  See ``Interactive mode'' for
>> 	details.
>
> It's still too technical. The 1st line should go right into business:
>
>  	Patch each file on command line interactively. This is this is
>  	the same as ``add --interactive``, but bypass the initial
>  	command menu and directly jump to `patch` subcommand. See
>  	``Interactive mode'' for details.

Even if we ignore the double "this is this is", I do not think it is
better than the original.

What does "Patch each file" mean?  When read naively (and that is the
whole point of your "too technical" comment), a reader would expect there
will be changes made _to_ the work tree files.

If you want to start the description with "What it does/what it is used
for", I think it is a good idea.  I already made a suggestion for such an
improvement in my message you are responding to.

If you want to make a counterproposal, at least please do that with a
counter-proposal that is better.
