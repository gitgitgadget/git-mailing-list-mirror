From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] git push --track
Date: Fri, 15 Jan 2010 09:30:20 +0900
Message-ID: <87y6k06wgz.fsf@catnip.gol.com>
References: <op.u6g8jnixg402ra@nb-04>
	<be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com>
	<20100114070316.GC1528@rm.endoftheinternet.org>
	<7vr5ps5jx1.fsf@alter.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rudolf Polzer <divVerent@alientrap.org>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 01:30:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVa5G-0004TW-OM
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 01:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab0AOAaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 19:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126Ab0AOAae
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 19:30:34 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:33724 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab0AOAae (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 19:30:34 -0500
Received: from 218.231.177.74.eo.eaccess.ne.jp ([218.231.177.74] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1NVa4z-0007Wv-2S; Fri, 15 Jan 2010 09:30:21 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 4C832DF74; Fri, 15 Jan 2010 09:30:20 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <7vr5ps5jx1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 14 Jan 2010 15:46:50 -0800")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137045>

Junio C Hamano <gitster@pobox.com> writes:
> Yes, "push --track" lets you postpone the decision; branching, working on
> it, pushing it out _and_ _then_ using your "branch -f" trick will let you
> postpone the decision even further.

Nonetheless, "push --track" is by far the most natural UI for the most
common case, I think.

> And it doesn't add --track to the UI.

That's not a positive...

None of this is _necessary_, it's to make git more convenient.

Halfway-measures seem like "oh the user can just use this branch
command" seem like, well, halfway measures.  Sure, it would be nice to
have a branch command _too_, just to make it easier for branch
maintenance, but it's not what's really wanted.

-Miles

-- 
Faith, n. Belief without evidence in what is told by one who speaks without
knowledge, of things without parallel.
