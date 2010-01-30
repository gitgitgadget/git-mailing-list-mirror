From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 16:14:56 -0800
Message-ID: <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
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
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 01:15:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb0zf-0004nc-8G
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 01:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057Ab0A3APM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 19:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754880Ab0A3APM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 19:15:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab0A3APK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 19:15:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 40F5C952C1;
	Fri, 29 Jan 2010 19:15:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mrDohJUFyNBeoAVW5fS/lkpiZBY=; b=njZ8MT
	GHJ9njwGtGEwMT2JpaxatL9KliOqLk9kKiWruLKTtmkKxjywu5eJes8bPYCBY+iA
	aXHL2K3CDKO2kUEWyooO0HbhCyk2tTo7aiYeTA2x7TAX/dPWAor4VviXjtxbpruU
	4ZyLSvbpQV+Cf5c7CO77BcB0l6Si3rg5jfmuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eiiWYPydCt6S+nCe6Mi1vTm+YnKRpDnW
	trniUMuIEkzvn2o+AZbmw+uLRfPjjcVcO8TdCe9bEOb8V1IUEdu83nLhUeW51PKQ
	3TC31d1oqDg2JwfY7sNSRkaFGGqwKQ8Gl3WDPoJNctvSVpjBp2fA+mk/36AcWfT8
	TrJlSTMUX4c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6301952BD;
	Fri, 29 Jan 2010 19:15:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6C5E952BA; Fri, 29 Jan
 2010 19:14:57 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001291833580.1681@xanadu.home> (Nicolas
 Pitre's message of "Fri\, 29 Jan 2010 18\:43\:41 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8371CA46-0D34-11DF-ADC4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138404>

Nicolas Pitre <nico@fluxnic.net> writes:

> To the contrary, I think it is about time we use proper Git jargon.  
> Otherwise how can we expect people to relate to the documentation where 
> that jargon is indeed used?  Even on this very mailing list we refer to 
> that state as a "detached HEAD".  And Google gives precisely the right 
> info with "detached HEAD" while any other verbiage might not.
>
> And just saying that "you're not on any branch anymore" is still leaving 
> the user wondering why.  At least with the "isn't a local branch head" 
> the user has 2 clues: it has to be a _local_ branch and a branch _head_ 
> not to create a detached HEAD.  So I still prefer the above rewording.

I can buy that argument, except for three minor points:

 - I think we also should give information necessary to judge if the user
   wants to stay in the detached HEAD state.  IOW, "Why am I getting an
   insn to create a new branch?  What is wrong with this detached HEAD
   state?  Why would I want a local branch?" are still not explained with
   the updated message.

 - Do we "create" a detached HEAD, or are we just "detaching HEAD"?

 - Running "checkout -b" now will create a new branch from that checkout,
   but doing so _later_ won't necessarily do so from that _checkout_.

So how about doing this (changes to advice.[ch] are omitted)?

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 5277817..41fc00a 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -522,8 +522,16 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
 			   REF_NODEREF, DIE_ON_ERR);
 		if (!opts->quiet) {
-			if (old->path)
-				fprintf(stderr, "Note: moving to '%s' which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
+			if (old->path && advice_detached_head)
+				fprintf(stderr,
+"Note: '%s' isn't a local branch head.\n\n"
+"HEAD is detached at that commit. You can look around, even make changes\n"
+"and record them in new commits, but any new commit you make from now on\n"
+"will be lost when you check out another branch.\n"
+"If you want to create a new branch from this state, you may do so\n"
+"(now or later) by using -b with the checkout command again. Example:\n"
+"  git checkout -b <new_branch_name>\n\n",
+					new->name);
 			describe_detached_head("HEAD is now at", new->commit);
 		}
 	}
