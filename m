From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 14:42:32 -0700
Message-ID: <7vlkndz4fr.fsf@assigned-by-dhcp.cox.net>
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
	<20061018213225.GD19194@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:42:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJBR-0002SC-0g
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423013AbWJRVmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423016AbWJRVmf
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:42:35 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:21704 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1423013AbWJRVme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:42:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018214233.SKSS2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Oct 2006 17:42:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bxic1V0071kojtg0000000
	Wed, 18 Oct 2006 17:42:36 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061018213225.GD19194@spearce.org> (Shawn Pearce's message of
	"Wed, 18 Oct 2006 17:32:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29276>

Shawn Pearce <spearce@spearce.org> writes:

> ...  Although it would add
> a new pair of configuration options to .git/config.  Is that change
> too radical?  :-)

I wonder what you would need the configuration options for.

If mmap() pack works well, it works well, and if it is broken
nobody has reason to enable it.  The code should be able to
adjust the mmap window to appropriate size itself and its
automatic adjustment does not even have to be the absolute
optimum (since the user would not know what the optimum would be
anyway), so maybe your configuration options would not be
"enable" nor "window-size" -- and I am puzzled as to what they
are.
