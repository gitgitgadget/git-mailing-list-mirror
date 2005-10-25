From: Junio C Hamano <junkio@cox.net>
Subject: Re: Convention for help in git commands?
Date: Tue, 25 Oct 2005 11:56:34 -0700
Message-ID: <7vfyqpe87x.fsf@assigned-by-dhcp.cox.net>
References: <200510251508.43552.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 20:56:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUTyR-0000iZ-4v
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 20:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVJYS4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 14:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVJYS4g
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 14:56:36 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:16859 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932302AbVJYS4g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 14:56:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051025185553.CFFN24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 14:55:53 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10610>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> * All git commands should react on command line option "-h"
> for help, dumping a few lines to stderr, prefixed by "usage:", giving
> the command usage without further descriptions. For the usage
> output, use the base name of the command, and not the absolute
> path to the binary.

It drives me nuts when an error message shows only basename not
full path and I find out that I was running a wrong executable
much later after wasting a lot of time trying to debug it.  But
I think "usage: " saying the basename only is user friendly and
a good convention.

> * For commands which need at least one argument, the usage
> is also printed, if the command is run without argument

This is slightly debatable.  I'd rather see it error out for one
thing, and we might want to do a sane default given no arguments
later.

> Perhaps these things should be done only for commands of the
> git lightwight porcelain?

Probably.
