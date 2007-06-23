From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 100%
Date: Sat, 23 Jun 2007 12:33:15 -0700
Message-ID: <7vk5tu4gas.fsf@assigned-by-dhcp.pobox.com>
References: <20070621030622.GD8477@spearce.org>
	<alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
	<Pine.LNX.4.64.0706211248420.4059@racer.site>
	<20070621131915.GD4487@coredump.intra.peff.net>
	<Pine.LNX.4.64.0706220214250.4059@racer.site>
	<467B777D.C47BFE0E@eudaptics.com>
	<Pine.LNX.4.64.0706221122200.4059@racer.site>
	<86ps3oi7ma.fsf_-_@lola.quinscape.zz>
	<Pine.LNX.4.64.0706221347480.4059@racer.site>
	<86abusi1fw.fsf@lola.quinscape.zz>
	<Pine.LNX.4.64.0706230222330.4059@racer.site>
	<467CF380.6060603@lsrfire.ath.cx>
	<Pine.LNX.4.64.0706231154300.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 21:33:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2BME-0003AS-PB
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 21:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbXFWTdR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 15:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbXFWTdR
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 15:33:17 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:34443 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbXFWTdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 15:33:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070623193315.TJFV3133.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Jun 2007 15:33:15 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id F7ZF1X00U1kojtg0000000; Sat, 23 Jun 2007 15:33:16 -0400
In-Reply-To: <Pine.LNX.4.64.0706231154300.4059@racer.site> (Johannes
	Schindelin's message of "Sat, 23 Jun 2007 11:56:19 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50747>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> By the same reasoning, you could say "never round down to 0%, because I 
> want to know when there is no similarity".
>
> You cannot be exact when you have to cut off fractions, so why try for 
> _exactly_ one number?

R0 or C0 would not happen in real life, so 0% is a moot issue.

However, wasn't that you who did follow that "certain numbers
are special" logic in diffstat?

You advocated "diff --stat" should draw at least one +/- for a
patch that adds/removes lines.  And I (and others) agreed
because zero is special in the context of that application.

I think reserving R100 to mean "identical byte sequences" has
value, when people look at --name-status output, in the context
of "similarity index".
