From: Junio C Hamano <junkio@cox.net>
Subject: Re: warning merge message
Date: Fri, 22 Dec 2006 15:00:56 -0800
Message-ID: <7vy7ozv8lz.fsf@assigned-by-dhcp.cox.net>
References: <867728.44872.qm@web31814.mail.mud.yahoo.com>
	<200612222142.15489.Josef.Weidendorfer@gmx.de>
	<7vodpvy6sf.fsf@assigned-by-dhcp.cox.net>
	<200612222349.54363.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 00:01:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxtNs-0006zC-SM
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 00:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbWLVXA6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 18:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbWLVXA6
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 18:00:58 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:44157 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbWLVXA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 18:00:57 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222230057.CRMY20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 18:00:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1z0E1W00H1kojtg0000000; Fri, 22 Dec 2006 18:00:14 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200612222349.54363.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Fri, 22 Dec 2006 23:49:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35244>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> In a previous discussion, you talked about switching to
> the new behavior (ie. getting rid of this "first set of
> branches" rule) when there is at least one branch.*.merge
> setting in the config file.
>
> Unfortunately I can not see an easy way to check this with
> repo-config, as there is no wildcard support for keys
> (Ok, I can do a list of keys and grep).

I think --get-regexp is what you want -- see my "patch for
discussion".

> I think it is better to provide an option
> "pull.do-not-follow-the-first-set-of-branches-rule".
> And we should make this the default after init-db or clone.

Yes, but the problem is that old timers do make new clones.

pull.i-like-the-first-set-of-branches in ~/.gitconfig is the
only thing I can think of but that is too ugly and is already on
the slippery slope of user.expert configuration which I do not
think we want.
 
