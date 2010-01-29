From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 14:39:02 -0800
Message-ID: <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
 <7veil8iqnj.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291614550.1681@xanadu.home>
 <fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com>
 <alpine.LFD.2.00.1001291628510.1681@xanadu.home>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
 <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
 <7viqakh8ty.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291716070.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 23:39:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NazUp-0001Hb-DM
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870Ab0A2WjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755813Ab0A2WjS
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:39:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab0A2WjS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:39:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15E0D95627;
	Fri, 29 Jan 2010 17:39:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6n7W5xWyjb70Wf2chiNlX1aFcA0=; b=GTimuh
	nXUT62d0c4Gvr8xcOcd7lhPtye1dJDoMZ7hScB7jviOmt/vMSoUxOM5Tej+HfgNA
	KHa7fih6wOb9/DkgoB47NrNepkU1zWQG9fZNAX8DDTA5QdcTBW+SIWwZjUbS6pfy
	ZXbIuH//Tab6mvGRbYAKDJ6zUq1x8Lp4D7sxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mm6z6Rod79z1k8wJ5Qj5YHRuM2Sgljzv
	ArUJsOec9A9BxVL30uuf/veUW2LrM7r3KEKFA4FmcTAk2Vu+MxjiBow5zYqXcUct
	z7fcXLZTm2FRBx3fes0F3pZpxYrgto2AkBO8WMXj5EML/KEqAuTd0j0sTLNjozN3
	2kmdmLYckL4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4EF595623;
	Fri, 29 Jan 2010 17:39:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8091F95617; Fri, 29 Jan
 2010 17:39:04 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001291716070.1681@xanadu.home> (Nicolas
 Pitre's message of "Fri\, 29 Jan 2010 17\:34\:28 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1EDD4E8C-0D27-11DF-BE65-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138393>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Fri, 29 Jan 2010, Junio C Hamano wrote:
>
>> We used to just say "topic is not a rev nor path" and failed when the user
>> said "git checkout topic".  And the magic kicks in when there is only one
>> "remotes/*/topic".
>> 
>> Because this cannot be any request other than to check out a local branch
>> "topic", and because there is no place more sensible than the "topic"
>> taken from the "origin" (as that is the sole place that has "topic"), it
>> dwims as a shorthand for "checkout -b topic origin/topic" and tells you
>> that it did so.
>
> OK.  That is probably sensible.
>
> I don't think any improvement on the detached head message should 
> presume on this though.
>
> And it might be a good idea to say explicitly that what happened is the 
> creation of a detached HEAD, like in:

Any comment on my previous rewording patch ($gmane/138369)?

"Note: '%s' isn't a local branch head: creating a detached HEAD\n"
"If you want to create a new branch from this checkout, you may do so\n"
"(now or later) by using -b with the checkout command again. Example:\n"
"  git checkout -b <new_branch_name>\n", new->name);

A major difference I think is that I avoided a jargon (detached HEAD), and
chose not to say why the input was interpreted as a request to switch to
that state.

Oh, of course, I also added advice.detachedHEAD to squelch it ;-)
