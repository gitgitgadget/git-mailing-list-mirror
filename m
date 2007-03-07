From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] make t8001 work on Mac OS X again
Date: Tue, 06 Mar 2007 17:00:54 -0800
Message-ID: <7vr6s1n9yx.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703061557j1cade6f6k4577da5e447a4e2a@mail.gmail.com>
	<20070307001410.GA26050@spearce.org>
	<20070307004859.GA26262@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:00:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOkWZ-0004h8-5t
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbXCGBA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbXCGBA4
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:00:56 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33868 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbXCGBAz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:00:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307010055.YIAM26279.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Mar 2007 20:00:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xd0u1W00T1kojtg0000000; Tue, 06 Mar 2007 20:00:55 -0500
In-Reply-To: <20070307004859.GA26262@spearce.org> (Shawn O. Pearce's message
	of "Tue, 6 Mar 2007 19:48:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41630>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> It has a broken sed which adds a newline to the last line, if it does
> not end with one.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>
> 	From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 	> Does this work for you?
>
> 	Yes.  ;-)

Thanks. Strictly speaking, sed is *supposed* to end its output
of pattern space with newline, so the test is at fault, not
Macintosh sed.

Will apply.
