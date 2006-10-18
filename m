From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 15:13:37 -0700
Message-ID: <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net>
References: <20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
	<20061018185907.GV20017@pasky.or.cz>
	<7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610181510510.1971@xanadu.home>
	<20061018191834.GA18829@spearce.org>
	<Pine.LNX.4.64.0610181525410.1971@xanadu.home>
	<20061018204626.GA19194@spearce.org>
	<Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
	<20061018214143.GF19194@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 00:13:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJfS-0008Hg-R2
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 00:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423072AbWJRWNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 18:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423073AbWJRWNj
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 18:13:39 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2250 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1423072AbWJRWNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 18:13:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018221338.IBQI28934.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Oct 2006 18:13:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id byDh1V01D1kojtg0000000
	Wed, 18 Oct 2006 18:13:42 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061018214143.GF19194@spearce.org> (Shawn Pearce's message of
	"Wed, 18 Oct 2006 17:41:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29291>

Shawn Pearce <spearce@spearce.org> writes:

> Ideally that thin pack would be repacked (along with the other
> existing packs) as quickly as possible into a self-contained pack.

It should not be hard to write another program that generates a
packfile like pack-object does but taking a thin pack as its
input.  Then receive-pack can drive it instead of
unpack-objects.
