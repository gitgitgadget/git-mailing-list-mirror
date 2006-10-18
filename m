From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 15:02:15 -0700
Message-ID: <7vac3tz3iw.fsf@assigned-by-dhcp.cox.net>
References: <20061018185225.GU20017@pasky.or.cz>
	<20061018185907.GV20017@pasky.or.cz>
	<7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610181510510.1971@xanadu.home>
	<20061018191834.GA18829@spearce.org>
	<Pine.LNX.4.64.0610181525410.1971@xanadu.home>
	<20061018204626.GA19194@spearce.org>
	<Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
	<20061018213225.GD19194@spearce.org>
	<7vlkndz4fr.fsf@assigned-by-dhcp.cox.net>
	<20061018215219.GG19194@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 00:02:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJUS-0006BK-Ex
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 00:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423063AbWJRWCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 18:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWJRWCR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 18:02:17 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:7387 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751514AbWJRWCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 18:02:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018220215.TJRX2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Oct 2006 18:02:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id by2K1V00G1kojtg0000000
	Wed, 18 Oct 2006 18:02:19 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061018215219.GG19194@spearce.org> (Shawn Pearce's message of
	"Wed, 18 Oct 2006 17:52:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29287>

Shawn Pearce <spearce@spearce.org> writes:

> However what do we do about the case where we mmap over 1 GiB worth
> of pack data (because the mmap succeeds and we have at least that
> much in .pack and .idx files) and then the application starts to
> demand a lot of memory via malloc?...
>
> The other configuration option is the size of the mmap window.
>...
> Earlier this summer we discussed this exact issue and said this
> value probably needs to be configurable if only to facilitate the
> unit tests.

I see.  So you are allowing users to control individual window
size and total mmap memory.  That makes sense.
