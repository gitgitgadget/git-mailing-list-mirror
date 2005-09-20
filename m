From: Paul Mackerras <paulus@samba.org>
Subject: Re: Joining cg-*-id
Date: Tue, 20 Sep 2005 22:32:05 +1000
Message-ID: <17200.325.128562.160145@cargo.ozlabs.ibm.com>
References: <1127166049.26772.26.camel@dv>
	<20050919215608.GA13845@pasky.or.cz>
	<Pine.LNX.4.58.0509191505470.2553@g5.osdl.org>
	<7vy85s9tgk.fsf@assigned-by-dhcp.cox.net>
	<pan.2005.09.20.10.11.38.565694@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 14:34:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHhIG-0000dH-Jt
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 14:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVITMcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 08:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVITMcL
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 08:32:11 -0400
Received: from ozlabs.org ([203.10.76.45]:51682 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964999AbVITMcK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 08:32:10 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 45F6A68348; Tue, 20 Sep 2005 22:32:05 +1000 (EST)
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.09.20.10.11.38.565694@smurf.noris.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8993>

Matthias Urlichs writes:

> One feature I'd like to see in this context is a gitk tree view that lists
> nodes in date order, instead of the "walk down one branch as far as
> possible before doing the next one" process it currently uses.

It's there already: the -d flag to gitk does that.

That shows them in date order subject to the constraint that children
are shown before parents.  Yes, it is possible to have a commit that
is older than its parent(s), if it or its parent(s) were created on a
machine whose date is set wrong.

Paul.
