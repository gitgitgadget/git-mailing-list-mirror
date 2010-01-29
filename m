From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 13:58:33 -0800
Message-ID: <7viqakh8ty.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
 <7veil8iqnj.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291614550.1681@xanadu.home>
 <fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com>
 <alpine.LFD.2.00.1001291628510.1681@xanadu.home>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
 <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:58:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nayre-0001Ex-SD
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034Ab0A2V6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661Ab0A2V6s
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:58:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab0A2V6r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:58:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C05F595FC4;
	Fri, 29 Jan 2010 16:58:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qi1XYLMdpMpPS1N52w52OcgifBQ=; b=tTBqIm
	/qo1oA5jtFb+fwhZ/uUXKeIFz3TK2hcCngATuoDS+fgOQhedilQqN0NzYH5T1mID
	b+pULiDYDgvbVvFdNc4BiX9DmDm4sI0bEXZZWIJR9adn5gAAkJjwYcLG/CiLS/6l
	yxT+UrgDdmvjQRhsjplbWXToWDzJ+rQZamKzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aH9S6lbTvF19Joe4vqfKlYVsLP67Gf2T
	5PfF97R7iKdfb/zQ/YrbrfvUpMUy8Ydch2IFu9ctApDKflBjWww+tZuA/wQEOZmZ
	DJ5vmflRAsmzAFkmHvI9UgcTClOc12Exc8iyBw93BWHHawLM15g/uXh5uLgJoynJ
	nAnW7GoyCUE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D98695FC3;
	Fri, 29 Jan 2010 16:58:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E33B95FC1; Fri, 29 Jan
 2010 16:58:35 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001291641200.1681@xanadu.home> (Nicolas
 Pitre's message of "Fri\, 29 Jan 2010 16\:51\:18 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 764C5D9E-0D21-11DF-8D87-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138379>

Nicolas Pitre <nico@fluxnic.net> writes:

> What purpose does this "feature" serve?  Making sure people remain 
> stupid and get even more confused when the special dwimery doesn't work 
> because they don't know the difference between a local branch and a 
> remote tracking branch?
>
> And now people will be left wondering why after a fetch they don't get 
> the latest stuff when they do "git checkout topic" again.  Is this any 
> better?

Sverre's explanation does not match reality.

We used to just say "topic is not a rev nor path" and failed when the user
said "git checkout topic".  And the magic kicks in when there is only one
"remotes/*/topic".

Because this cannot be any request other than to check out a local branch
"topic", and because there is no place more sensible than the "topic"
taken from the "origin" (as that is the sole place that has "topic"), it
dwims as a shorthand for "checkout -b topic origin/topic" and tells you
that it did so.

So people _has_ to still know that local branches are the only thing they
can check out (iow, "checkout topic" is not a request to check out a
remote tracking branch).
