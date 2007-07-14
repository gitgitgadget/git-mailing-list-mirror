From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Draft release notes for v1.5.3, as of -rc1
Date: Sat, 14 Jul 2007 11:13:57 -0700
Message-ID: <7vvecmj1ju.fsf@assigned-by-dhcp.cox.net>
References: <7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
	<7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
	<7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
	<7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
	<7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
	<7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net>
	<7vlkdkq00o.fsf_-_@assigned-by-dhcp.cox.net>
	<20070713092908.GO1528MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0707141517450.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 14 20:14:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9m8C-0003F2-Nd
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 20:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772AbXGNSOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 14:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758706AbXGNSOA
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 14:14:00 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47034 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758766AbXGNSN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 14:13:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714181358.EZBC1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Jul 2007 14:13:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PWDy1X0061kojtg0000000; Sat, 14 Jul 2007 14:13:58 -0400
In-Reply-To: <Pine.LNX.4.64.0707141517450.14781@racer.site> (Johannes
	Schindelin's message of "Sat, 14 Jul 2007 15:22:22 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52493>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It is really unfortunate that rewrite-commits came in so late in the 
> release cycle, and I am quite sure it should not be in 1.5.3.  There is 
> just too much new in it, and too many things to flesh out.
>
> Junio, if you want to include it in 1.5.3, it should be marked as alpha 
> code, as it has not seen any time in "next", let alone "master".

I am not considering rewrite-commits for inclusion right now.

I was hoping that filter-branch will stay.  Its interface is
something people are already familiar with since the days of its
its older incarnation cg-admin-rewritehist, and it would be
really really nice that anything that attempts to replace it
builds on and extends its external interface.

Maybe rewrite-commits can be used to delegate the implementation
of heavy lifting from filter-branch?  IOW can the latter be
just a thin wrapper around the former?
