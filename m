From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-merge.txt: Expand the How Merge Works 
 section
Date: Fri, 18 Jul 2008 17:32:19 -0700
Message-ID: <7vprpa67e4.fsf@gitster.siamese.dyndns.org>
References: <20080717162922.12081.96582.stgit@localhost>
 <7v3am8gytp.fsf@gitster.siamese.dyndns.org>
 <20080717185451.GJ10151@machine.or.cz>
 <7vd4lcfgoo.fsf@gitster.siamese.dyndns.org>
 <20080718131800.GP10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 19 02:33:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK0O6-0003mU-DO
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 02:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbYGSAc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 20:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbYGSAc1
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 20:32:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbYGSAc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 20:32:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0047032C0C;
	Fri, 18 Jul 2008 20:32:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C24BD32C0B; Fri, 18 Jul 2008 20:32:22 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 293B2B12-552A-11DD-B573-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89089>

Petr Baudis <pasky@suse.cz> writes:

>> However, I think we may want to talk about "How to tell if your merge did
>> not even touch your index nor working tree" somewhere in the manual.
>> "When there are conflicts, these things happen" part talks about how to
>> resolve conflicts, but when merge refuses to avoid losing local changes,
>> the instruction in that part does not apply.
>
>   I'm not sure if this is worth pondering about? The action would feel
> rather obvious to me - get rid of the local changes somehow, either
> committing them or stashing them or wiping them out. Is that worth
> elaborating, or is there more to it?

Oh, the necessary action is obvious.  That's not the issue.  You either
forget about the merge and in that case your index and working tree is
intact and you can keep going.  Or stash to merge first.

But what I was wondering was if we have given the users enough clues to
tell if the above is the right action.  If merge started and conflicted,
then forgetting about it and keep going is _not_ the right thing, and the
user needs to be able to tell these two very distinct cases apart.
