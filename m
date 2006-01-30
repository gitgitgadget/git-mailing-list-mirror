From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] diff: add --no-diff-deleted to make -p more pleasant
Date: Sun, 29 Jan 2006 16:38:20 -0800
Message-ID: <20060130003820.GE15482@Muzzle>
References: <20060129142403.GA15482@Muzzle> <7vy80ykd3j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 01:38:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3N3q-0007Sm-3i
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 01:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWA3AiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 19:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWA3AiX
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 19:38:23 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36564 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1751213AbWA3AiW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 19:38:22 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id 874322DC035;
	Sun, 29 Jan 2006 16:38:20 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sun, 29 Jan 2006 16:38:20 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy80ykd3j.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15255>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > This is a feature I've stol^Wborrowed from svn that I find very
> > useful since I usually don't care to see what I've deleted.
> 
> There is a thing called --diff-filter, and 
> 
> 	git diff -p --no-diff-deleted
> 
> is equivalent to
> 
> 	git diff -p --diff-filter=AM

Cool, didn't notice this feature before.  Thanks.

> when you are not using rename/copy detection (and a byte
> shorter).  Or maybe improve its syntax to also take:
> 
> 	--diff-filter=-D
> 
> That is, a minus followed by list of undesired change class
> letters.

Hmm.. maybe another day.  AM is good enough for now.

-- 
Eric Wong
