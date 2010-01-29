From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 13:49:27 -0800
Message-ID: <7vr5p8h994.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
 <7veil8iqnj.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291614550.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:49:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nayiq-0002ZU-UF
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab0A2Vtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804Ab0A2Vtn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:49:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab0A2Vtl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:49:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B68595E7E;
	Fri, 29 Jan 2010 16:49:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GXl6+2Eb4h9A5gP4FZ1s+9/n9fg=; b=PmGkeR
	oTcFcqsLxt8wRVkaajwi77VCGresHrbD7bwbhqTdFtsKBbDFEE25WANb09Nf1zd+
	j/8ou1SUXFA6WP+zA5xLXRPhY68CT1QN6V0VPac8pxY+XfGVuX8fn12BEvWDvTCh
	ZFMLMrn1DcTpx1zxF43iHgmzGpRwXGn/eQULI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HYXC0acblXZMZF1gddx/mIcFXL7GOFqq
	VDh94WeFKFOEw6N8mZBfXlMzJtoQgJNQu+ErovHYv9fwscQ3922X2e2HqmVFyLL0
	efeMjlNeKoOh76qFJt3y4zQWwvgxz1qiP78IQ8lqLCe30G2bVGE7L5iFsCxZZC7I
	2HAhk+nZ+Z8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2968D95E77;
	Fri, 29 Jan 2010 16:49:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2620A95E6E; Fri, 29 Jan
 2010 16:49:29 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001291614550.1681@xanadu.home> (Nicolas
 Pitre's message of "Fri\, 29 Jan 2010 16\:20\:38 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30B0D54A-0D20-11DF-8B45-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138375>

Nicolas Pitre <nico@fluxnic.net> writes:

>> These days, you can say "git checkout topic" to automagically create a
>> local "topic" branch that forks from "origin/topic" remote tracking branch
>> when you have one, thanks to Dscho's UI improvement ideas (one less
>> reason you may end up on a detached HEAD state without wanting to).
>
> If this is the case then I'm really disappointed.
>
> With all due respects, I don't share Dscho's sentiment about Git's 
> alleged non user-friendliness.  And I always praised Git's ability to 
> use a detached head to check out a remote branch, and never had any 
> problem teaching this concept to people.  So the above is not a UI 
> improvement at all to me.

Just in case you misunderstood...

This is "git checkout topic", not "git checkout origin/topic".  The rule
kicks in when you do not have local branch "topic" and there is a unique
"refs/remotes/*/topic".  Existing ways to explicitly ask for detaching are
unaffected, so "checkout origin/topic" or "checkout origin/topic^0" do
what you expect.

We used to just say "topic is not a rev nor path" and failed when the user
sayd "git checkout topic".

Because this cannot be any request other than to check out a local branch
"topic", and because there is no place more sensible than the "topic"
taken from the "origin" (as that is the sole place that has "topic"), it
dwims as a shorthand for "checkout -b topic origin/topic" and tells you
that it did so.
