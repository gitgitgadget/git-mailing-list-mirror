From: Bill Lear <rael@zopyra.com>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 17:32:05 -0600
Message-ID: <17867.45813.15301.479436@lisa.zopyra.com>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<7vr6t13251.fsf@assigned-by-dhcp.cox.net>
	<17867.16740.875694.789664@lisa.zopyra.com>
	<20070208232404.GA9493@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:32:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIkl-0002x4-4j
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbXBHXcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965620AbXBHXcO
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:32:14 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61902 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965616AbXBHXcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:32:09 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l18NW7h04222;
	Thu, 8 Feb 2007 17:32:07 -0600
In-Reply-To: <20070208232404.GA9493@coredump.intra.peff.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39122>

On Thursday, February 8, 2007 at 18:24:04 (-0500) Jeff King writes:
>...
>Maybe I don't understand what you mean by sync here, but I don't see the
>mental leap. Whenever you fetch, from whatever branch, using the
>'origin' remote, it will update all tracking branches in your local
>repository. You can then selectively do merges to any local branches
>you're working on. You _can't_ do an operation that is "for every local
>branch I have, merge the matching remote branch into my local branch".
>And I don't think you'd want to: a merge may or may not be a trivial
>thing, since it might have conflicts.
>...

A very good point, and an obvious one in retrospect.  I guess I will
be entirely satisfied if I am on branch X I can just say 'git pull'
and it will NOT pull from any other branch.  You have added to my
understanding on this, and thank you for taking the time.


Bill
