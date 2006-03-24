From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cogito: Avoid slowness when timewarping large trees.
Date: Fri, 24 Mar 2006 03:01:35 -0800
Message-ID: <7v3bh814z4.fsf@assigned-by-dhcp.cox.net>
References: <20060324084423.GA30213@coredump.intra.peff.net>
	<7vd5gc16u2.fsf@assigned-by-dhcp.cox.net>
	<20060324105543.GA2543@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 12:01:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMk36-0005nt-G8
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 12:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWCXLBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 06:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWCXLBk
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 06:01:40 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:60845 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751139AbWCXLBk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 06:01:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324110139.MWKP20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Mar 2006 06:01:39 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20060324105543.GA2543@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 24 Mar 2006 05:55:44 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17909>

Jeff King <peff@peff.net> writes:

> ... Should the first read-tree actually
> be:
>   git-read-tree --reset "$base"

Exactly.  That's what I meant.  Thanks.

Originally I wrote "git reset" there, but this being Cogito I
thought Pasky preferred to use the true Plumbing and I botched
it X-<.
