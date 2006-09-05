From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] autoconf: Preliminary check for working mmap
Date: Tue, 05 Sep 2006 00:43:32 -0700
Message-ID: <7v1wqqkbbv.fsf@assigned-by-dhcp.cox.net>
References: <200609050054.24279.jnareb@gmail.com>
	<200609050056.52590.jnareb@gmail.com>
	<7vy7szjjal.fsf@assigned-by-dhcp.cox.net> <edidlp$d3d$1@sea.gmane.org>
	<20060905030929.GA29865@spearce.org>
	<7vu03mkiei.fsf@assigned-by-dhcp.cox.net>
	<20060905062531.GA30496@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 09:43:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKVab-0006aD-7k
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 09:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWIEHnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 03:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWIEHnH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 03:43:07 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26853 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932066AbWIEHnE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 03:43:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905074304.DFFB13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 03:43:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JXj41V00h1kojtg0000000
	Tue, 05 Sep 2006 03:43:05 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060905062531.GA30496@spearce.org> (Shawn Pearce's message of
	"Tue, 5 Sep 2006 02:25:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26465>

Shawn Pearce <spearce@spearce.org> writes:

> I don't know if I've made this more complex than I really need to
> but I've permitted multiple windows per pack.  There is just one
> LRU of all windows across all packs and a maximum amount of address
> space to use for pack mappings.  Least recently used window gets
> tossed when we need a different window.  This permits us to keep
> say a window active on the front of a pack (near the commits) and
> another different active window closer to the back (near the blobs).

Sounds good. That is exactly what I was expecting it to be done.
