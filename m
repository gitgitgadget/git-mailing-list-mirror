From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] autoconf: Preliminary check for working mmap
Date: Wed, 06 Sep 2006 00:17:38 -0700
Message-ID: <7v1wqpa2gd.fsf@assigned-by-dhcp.cox.net>
References: <200609050054.24279.jnareb@gmail.com>
	<200609050056.52590.jnareb@gmail.com>
	<7vy7szjjal.fsf@assigned-by-dhcp.cox.net> <edidlp$d3d$1@sea.gmane.org>
	<20060905030929.GA29865@spearce.org>
	<7vu03mkiei.fsf@assigned-by-dhcp.cox.net>
	<20060905062531.GA30496@spearce.org>
	<7v1wqqkbbv.fsf@assigned-by-dhcp.cox.net>
	<20060906034054.GB30598@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 09:17:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKrfI-00073R-NZ
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 09:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWIFHRh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 03:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWIFHRh
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 03:17:37 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28606 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751590AbWIFHRg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 03:17:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906071735.YCTG13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Wed, 6 Sep 2006 03:17:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JvHU1V00F1kojtg0000000
	Wed, 06 Sep 2006 03:17:28 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060906034054.GB30598@spearce.org> (Shawn Pearce's message of
	"Tue, 5 Sep 2006 23:40:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26505>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>> 
>> > I don't know if I've made this more complex than I really need to
>> > but I've permitted multiple windows per pack.  There is just one
>> > LRU of all windows across all packs and a maximum amount of address
>> > space to use for pack mappings.  Least recently used window gets
>> > tossed when we need a different window.  This permits us to keep
>> > say a window active on the front of a pack (near the commits) and
>> > another different active window closer to the back (near the blobs).
>> 
>> Sounds good. That is exactly what I was expecting it to be done.
>
> So I have this implemented but its against the 32 bit index.
> It passes the full test suite and appears to be working as intended.
>
> I am going to rebase the changes to the 64 bit index in `pu`
> and clean up my history.  Its currently one massive commit with
> lots of changes that should be broken down into slightly more
> digestable chunks.
>
> I'll try to do that tonight and get a patch series out.  My email
> is currently proving to be unstable so you may not get the series
> until later on Wed.

Take your time.  My usual git day is Wednesday but this week it
is shot and I won't be doing much gitting until later this week.
