From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Contributed bash completion support for core Git tools.
Date: Mon, 18 Sep 2006 01:23:45 -0700
Message-ID: <7virjlr3am.fsf@assigned-by-dhcp.cox.net>
References: <20060918004831.GA19851@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 10:24:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPEPv-0001k3-0L
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 10:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965569AbWIRIXr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 04:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965577AbWIRIXr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 04:23:47 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:18907 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965575AbWIRIXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 04:23:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918082346.VEUU12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Sep 2006 04:23:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PkPZ1V00C1kojtg0000000
	Mon, 18 Sep 2006 04:23:33 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060918004831.GA19851@spearce.org> (Shawn Pearce's message of
	"Sun, 17 Sep 2006 20:48:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27243>

Shawn Pearce <spearce@spearce.org> writes:

> +_git_log ()
> +{
> +...
> +}
> +...
> +_git_whatchanged ()
> +{
> +...
> +}

These two look the same.  Probably not very easy to maintain in
the long run.

It would be nice to have git-show as well but it usually does
not take ranges unlike these two. It is more like "git branch"
from completion purposes.
