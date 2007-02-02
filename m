From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/3] provide a nice @{...} syntax to always mean the current branch reflog
Date: Thu, 01 Feb 2007 17:15:16 -0800
Message-ID: <7v1wl9nyvv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
	<20070201191323.GA18608@spearce.org>
	<7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
	<45C25BA6.1000301@fs.ei.tum.de>
	<Pine.LNX.4.64.0702011710120.3021@xanadu.home>
	<20070201221758.GA15213@moooo.ath.cx>
	<Pine.LNX.4.64.0702011725150.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 02:15:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCn1R-0008Gm-9k
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 02:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423055AbXBBBPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 20:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423057AbXBBBPU
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 20:15:20 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:55981 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423055AbXBBBPS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 20:15:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202011517.QJTL1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Feb 2007 20:15:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JRFG1W01C1kojtg0000000; Thu, 01 Feb 2007 20:15:17 -0500
In-Reply-To: <Pine.LNX.4.64.0702011725150.3021@xanadu.home> (Nicolas Pitre's
	message of "Thu, 01 Feb 2007 17:29:33 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38442>

Nicolas Pitre <nico@cam.org> writes:

> This is shorter than HEAD@{...} and being nameless it has no semantic 
> issues.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---
>
> On Thu, 1 Feb 2007, Matthias Lederhofer wrote:
>
>> Nicolas Pitre <nico@cam.org> wrote:
>> > I really like "@{...}" to mean whatever branch I'm on.  Given that it 
>> > has no real name it can happily change meaning with branch switches.
>> Ack.
>
> Here it is, on top of my previous patches.

I think with this it makes a lot of sense to disallow HEAD@{}
until we are ready.
