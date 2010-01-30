From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 18:59:44 -0800
Message-ID: <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
 <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
 <7viqakh8ty.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291716070.1681@xanadu.home>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
 <ron1-F006CF.18381129012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 04:10:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb3jR-0003dY-UP
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 04:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129Ab0A3C7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 21:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756099Ab0A3C7z
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 21:59:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab0A3C7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 21:59:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F48B953AF;
	Fri, 29 Jan 2010 21:59:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Tee3VuU/VQW4wEzKQOtEbsvP+k=; b=Vzq6iS
	ih/LqyKkCqXWlMqulCMFj6R6tZWPpmYIAiXR8zhws23dDHTsteWDCWKXHuUWlZU1
	v+HyGfmCAXWptVhdbKp2uKQ3LoVZOs7Ael7m9uFChEHCkCe+ytME78S/4WjRn5b+
	GijglxLJ2DfdqAVFucApSl2DM3/kLztBiemAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hLBSCy6ENlEbXfS8kPkF0ZWTkEIbj6v4
	zSdlOwhwO+vrPj+1VIPRMIM+OTgvs8bWVzqM9Lt4egMnO38UvJDXWYvEmrIgWM3C
	1XTrBaLX0zwkgttwOT0xH4lSRUbhXovufcpX+dyyu1zrJR1Kg20zHz/Kt2mdbYPY
	CM8RBEY5d0c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B649953A8;
	Fri, 29 Jan 2010 21:59:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56F4A953A7; Fri, 29 Jan
 2010 21:59:46 -0500 (EST)
In-Reply-To: <ron1-F006CF.18381129012010@news.gmane.org> (Ron Garret's
 message of "Fri\, 29 Jan 2010 18\:38\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8780BB58-0D4B-11DF-9AE3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138430>

Ron Garret <ron1@flownet.com> writes:

> 1.  The term "detached HEAD" is inherently misleading.  A detached HEAD 
> isn't detached from anything, it's just pointing to the middle of a 
> branch, which is to say, to a commit that happens to already have 
> descendants.  For that matter, the name HEAD is itself misleading, since 
> HEAD need not be the head of a branch (though normally it is).  A better 
> name for HEAD would have been CURRENT or ACTIVE.  I recognize it's 
> probably too late to change it now.

This description, especially the phrase "middle of a branch" shows that
you don't understand git yet.  A git branch is _not_ a line (nor multiple
lines) of development.  It is merely a _point_ in the history.

"A commit that is in the middle of an ancestry chain with existing
descendants" can be at the tip of a branch and does not have anything to
do with detached HEAD state.

When HEAD points at a branch, making a commit advances _that_ branch.  And
we say you are "on that branch".  When HEAD is detached, because it is not
attached to anything, it advances no branch.  "detached HEAD" is detached
in the very real sense.  It is not attached to _any_ branch.

> 2.  There are a lot of things in the documentation that turn out, now 
> that I understand what is going on, to be subtly misleading.  For 
> example, "A single git repository can track development on multiple 
> branches. It does this by keeping a list of heads which reference the 
> latest commit on each branch."  That last part is only true if the heads 
> are not "detached".

This is from old terminology.  We used to use "head" (lowercase) and
"branches" pretty much interchangeably and the quoted description is from
the era _before_ detached HEAD was invented, as a way to quickly get a
temporary state where you can browse around freely and without having to
worry about having to clean up afterwards even if you made commits in that
state by simply going back to an attached state.

So do a "s/a list of heads/a list of branch pointers/" replacement and you
will be fine.

> Another example: "The HEAD then refers to the SHA-1 of the commit 
> instead of to a branch, and git branch shows that you are no longer on a 
> branch:"  But you *are* on a branch, you just aren't at the head of the 
> branch.

No, you are _literally_ not on _any_ branch at that point.

Making a commit from that state does not advance _any_ branch and doing
"reset --hard $commit" from that state does not affect _any_ branch.
