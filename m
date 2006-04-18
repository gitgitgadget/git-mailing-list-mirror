From: Junio C Hamano <junkio@cox.net>
Subject: Re: Log message printout cleanups
Date: Tue, 18 Apr 2006 09:48:53 -0700
Message-ID: <7vodyyg77u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
	<7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
	<7vodyzkehq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171647380.3701@g5.osdl.org>
	<7vejzvka09.fsf@assigned-by-dhcp.cox.net>
	<7v7j5nk9bf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171751540.3701@g5.osdl.org>
	<7vd5ffig70.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604180827040.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604180854550.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 18:49:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVtNr-0000J5-B4
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 18:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWDRQsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 12:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWDRQsz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 12:48:55 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61578 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751096AbWDRQsy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 12:48:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060418164854.DOXY18224.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Apr 2006 12:48:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604180854550.3701@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 18 Apr 2006 09:06:02 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18860>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio, I just tested the "master" branch, and "git log --stat" doesn't 
> work there.

Ahhhh.

>  			opt.diffopt.output_format = DIFF_FORMAT_PATCH;
> -		if (opt.diffopt.output_format == DIFF_FORMAT_PATCH)
> +		if (opt.diffopt.output_format == DIFF_FORMAT_PATCH ||
> +		    opt.diffopt.output_format == DIFF_FORMAT_DIFFSTAT)
>  			opt.diffopt.recursive = 1;

When pointed out in a patch from, it looks so obvious.  *BLUSH*

Thanks.
