From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 09:16:30 -0700
Message-ID: <7vabvsswtd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705241201270.4648@racer.site>
	<20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241230410.4648@racer.site>
	<20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241315290.4648@racer.site>
	<8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
	<7vabvuywix.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
	<20070524175519.GU942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241908040.4648@racer.site>
	<20070525100030.GB942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Sven Verdoolaege <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Fri May 25 18:16:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrcT1-0005wk-EL
	for gcvg-git@gmane.org; Fri, 25 May 2007 18:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbXEYQQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 12:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbXEYQQd
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 12:16:33 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59918 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbXEYQQb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 12:16:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525161631.MYNJ6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 25 May 2007 12:16:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 3UGW1X0041kojtg0000000; Fri, 25 May 2007 12:16:30 -0400
In-Reply-To: <20070525100030.GB942MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Fri, 25 May 2007 12:00:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48391>

Sven Verdoolaege <skimo@kotnet.org> writes:

> I'm obviously not going to stop anyone from putting URLs in .gitmodules
> and I can see that it would be useful in practice, but I still think
> that it doesn't matter where the submodule was located at any
> given point in history (from the point of view of the superproject).
> It only matters where the submodule is located now.
>
> You may be bisecting a problem and you may need to clone a submodule
> for a point in history when the submodule was placed somewhere else.
> (You may not have had a need to checkout the submodule before,
> or it may simply not be used in the current version of the supermodule.)
> So, I think it would still be useful to have an optional additional
> out-of-tree mechanism of getting usable URLs if the URLs in .gitmodules
> or your local config don't work.

I thought that was already solved in my original two-level
strawman and can naturally be extended to the three-level
strawman.  What am I missing?

gmane=http://article.gmane.org/gmane.comp.version-control.git/

	$gmane/47502
	$gmane/47548
	$gmane/47621
