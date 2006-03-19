From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Sun, 19 Mar 2006 11:43:48 -0800
Message-ID: <7vbqw2qky3.fsf@assigned-by-dhcp.cox.net>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
	<20060227184641.GA21684@hand.yhbt.net>
	<20060227185557.GA32142@delft.aura.cs.cmu.edu>
	<20060227192422.GB9518@hand.yhbt.net>
	<46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com>
	<Pine.LNX.4.64.0602271634410.22647@g5.osdl.org>
	<20060301065138.GC21684@hand.yhbt.net> <44056BF1.6000109@op5.se>
	<20060319191243.GB18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 19 20:44:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL3oi-0003e0-8P
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 20:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWCSTnx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 14:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWCSTnx
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 14:43:53 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:26307 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750782AbWCSTnw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 14:43:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060319194207.XOPA20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Mar 2006 14:42:07 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060319191243.GB18185@pasky.or.cz> (Petr Baudis's message of
	"Sun, 19 Mar 2006 20:12:44 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17720>

Petr Baudis <pasky@suse.cz> writes:

> Actually, I'm almost inclined to suggest making Git fail violently in
> case of an ambiguous name.

I am also inclined to suggest that or alternatively making it
warn, but having been almost burned by a bug or two coming from
the complexity of implementing it, I am not so enthused to start
hacking away again on this right now myself.
