From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 16:29:25 -0800
Message-ID: <7viqakcu56.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com>
 <alpine.LFD.2.00.1001291628510.1681@xanadu.home>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
 <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
 <7viqakh8ty.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291716070.1681@xanadu.home>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, Git List <git@vger.kernel.org>,
	Ron1 <ron1@flownet.com>, Jacob Helwig <jacob.helwig@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 01:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb1Df-0004tp-BP
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 01:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311Ab0A3A3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 19:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754269Ab0A3A3k
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 19:29:40 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572Ab0A3A3k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 19:29:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F37695469;
	Fri, 29 Jan 2010 19:29:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/hu7jxNw1bpnqJJyQ+yFgwhoTCk=; b=OjGtmO
	MMRm+AXs7pmnNbpvgR/y1BDrx9pvUeQ90/R7apA3ifCKN61kfGrPzSu6gbOXuei7
	1ZM3TOr05lMMoqinL7DAelC9yMLNyfAMV2nkN/sfVuvQkKUKiKGJ6ec6qzG3dVAZ
	KlS6jx75+JWpf4coYGO+xwc9K4vqV4ZfGclXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OKFLOSiAGpqEqvq+RF7OJtKN47ppfVrF
	HetE7gLE8R5IylqowmAFz/i8Ayk11YYB3cltgevdtHprJrXXMgXuBLqorGVuao2g
	f+cb4zqRCRVnmPsk2na/5N4HVrbioJbsWCqmkBlC9Hbt2LBzHxCMpr5613EZWyIb
	t+tpgjaZHrg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B14795468;
	Fri, 29 Jan 2010 19:29:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3F8F95463; Fri, 29 Jan
 2010 19:29:26 -0500 (EST)
In-Reply-To: <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat\, 30 Jan 2010 01\:18\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 89824E04-0D36-11DF-8B0F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138408>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> I think the "this state" needs to be changed, it currently suggests
> what you mention earlier in you reply, that it's about the current
> state, even if you make commits on top of that. Maybe something in the
> spirit of "If you want to create a new branch from ?? where you are at
> the moment you follow these instructions ??".

True.  And I am a moron.

The "state" was not about the work-tree state, but about the
"detached HEAD" state, which I didn't make it clear.

I also didn't address "scariness" point from Nico.  And scariness can be
removed by describing things in a positive way.

How about this?

-- >8 -- not a patch -- >8 --
Note: 'master^0' isn't a local branch head;

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by checking out another branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new_branch_name>

HEAD is now at a9d7c95... Merge branch 'maint'
-- 8< -- not a patch -- 8< --

Again, everything except for the last line would disappear by setting the
advice.detachedHEAD configuration to false.
