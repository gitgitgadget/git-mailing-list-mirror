From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Fri, 19 Jan 2007 17:21:00 -0800
Message-ID: <7vbqkubiir.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45AF5F83.6090207@fs.ei.tum.de>
	<Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vps9ag58g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvej2bkn2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 02:21:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84up-0001mz-MP
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 02:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbXATBVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 20:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbXATBVE
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 20:21:04 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:43890 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965099AbXATBVB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 20:21:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120012101.IMCY2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 20:21:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DDMJ1W00J1kojtg0000000; Fri, 19 Jan 2007 20:21:18 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701200213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 02:18:08 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37242>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> OTOH we can expect people _not_ to use --reverse with format-patch when 
> they don't know what it does! I mean, I don't go and use "ls" with an 
> option I saw in the man page, just because it has a cool ring to it.
>
> P.S.: Perhaps you should just stop worrying and learn to love --reverse 

I usually do not worry, especially while I am running 'next'
myself.

It's just unintended consequences I am worried about by touching
somewhere deep in the revision machinery after -rc1.
