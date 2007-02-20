From: Eric Wong <normalperson@yhbt.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 20 Feb 2007 00:20:20 -0800
Message-ID: <20070220082020.GA27084@localdomain>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 09:20:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJQF6-0008Nr-Li
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 09:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbXBTIUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 03:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbXBTIUY
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 03:20:24 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33199 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965235AbXBTIUX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 03:20:23 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 58FDD7DC091;
	Tue, 20 Feb 2007 00:20:21 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 20 Feb 2007 00:20:20 -0800
Content-Disposition: inline
In-Reply-To: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40209>

Junio C Hamano <junkio@cox.net> wrote:
> * js/diff-2 (Sun Feb 18 12:44:43 2007 +0100) 1 commit
>  - Add `git diff2`, a GNU diff workalike
> 
> Undecided.  Perhaps will merge to 'next' to see if somebody else
> comes up with a better naming idea.

With this, we can get rid of any test dependency on an external diff
and have a consistent replacement for cmp[1], as well.

`git gdiff`?  `git xdiff`?  `gdiff` would be easier on the fingers
(assuming querty), but `xdiff` is probably a more accurate name.

[1] - <200702172225.12758.johannes.sixt@telecom.at>
-- 
Eric Wong
