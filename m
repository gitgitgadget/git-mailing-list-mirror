From: Junio C Hamano <junkio@cox.net>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 20:33:12 -0800
Message-ID: <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	<20070211225326.GC31488@spearce.org>
	<9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	<Pine.LNX.4.64.0702112022430.1757@xanadu.home>
	<7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
	<9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 05:33:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGSsP-0004IH-MC
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 05:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944AbXBLEdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 23:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932946AbXBLEdO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 23:33:14 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:44447 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932944AbXBLEdN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 23:33:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212043314.ROHZ1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 23:33:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NUZC1W00e1kojtg0000000; Sun, 11 Feb 2007 23:33:13 -0500
In-Reply-To: <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
	(Jon Smirl's message of "Sun, 11 Feb 2007 23:29:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39361>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> All wireless-dev are all dead.
> I can still get to Linus' tree without problem. wireless-2.6 tree is ok too.
>
> jonsmirl@jonsmirl:/extra$ git clone
> git://git.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git
> Initialized empty Git repository in /extra/wireless-dev/.git/
> fatal: The remote end hung up unexpectedly

Are you sure the above is ".../linux/kernel/gt/linville/..."?
