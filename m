From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix parallel make problem
Date: Fri, 31 Aug 2007 08:44:12 -0700
Message-ID: <7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>
	<20070831081517.GB17637@mellanox.co.il>
	<7v4pig2j91.fsf@gitster.siamese.dyndns.org>
	<20070831152120.GC17637@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Aug 31 17:44:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR8fn-0006sX-V7
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 17:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbXHaPoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 11:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758175AbXHaPoS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 11:44:18 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947AbXHaPoS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 11:44:18 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D058A12BD2F;
	Fri, 31 Aug 2007 11:44:35 -0400 (EDT)
In-Reply-To: <20070831152120.GC17637@mellanox.co.il> (Michael S. Tsirkin's
	message of "Fri, 31 Aug 2007 18:21:20 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57175>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> > So how did this end up in your mail?
>> 
>> Because it is not a format-patch output.
>> 
>> I often run "git diff --stat -p HEAD" from inside MUA in order
>> to get the patch from my work tree, write a proposed commit
>> message, and then reset the change away without committing after
>> sending that message (yes I do not need "git stash" --- gmane
>> and vger are my stashes, Mwhhhaaaa).
>
> So maybe we can suppress the warning when the output is not a tty?

What's your point?

I did not even want to apply that "empty diff --git removal"
patch.  I certainly do _NOT_ want to suppress that replacement
warning anywhere.

You are seriously tempting me to revert the commit
fb13227e089f22dc31a3b1624559153821056848 (git-diff: squelch
"empty" diffs)...
