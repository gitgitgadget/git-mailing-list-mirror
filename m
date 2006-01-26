From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: git describe fails without tags
Date: Thu, 26 Jan 2006 09:45:54 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060126084554.GC2941@informatik.uni-freiburg.de>
References: <20060125074725.GA2768@informatik.uni-freiburg.de> <7vek2wws61.fsf@assigned-by-dhcp.cox.net> <20060126074421.GA2941@informatik.uni-freiburg.de> <7vmzhjif8i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 09:46:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F22mN-0001S7-Rg
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 09:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWAZIqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 03:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWAZIqx
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 03:46:53 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:13472 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751162AbWAZIqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 03:46:52 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F22mJ-0006Qs-Br
	for git@vger.kernel.org; Thu, 26 Jan 2006 09:46:51 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0Q8kpQ8004808
	for <git@vger.kernel.org>; Thu, 26 Jan 2006 09:46:51 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0Q8kpoA004807
	for git@vger.kernel.org; Thu, 26 Jan 2006 09:46:51 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzhjif8i.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15153>

Hello Junio,

Junio C Hamano wrote:
> Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:
> 
> > Yes, I wrote a script that automatically build git and install it to
> > ${HOME}/usr/stow/git-`git describe HEAD` and then stow(8)s it.  Writing
> > a similar script for sparse cannot use git describe because there are no
> > tags ...
> > ...
> > It's a pity your not particularly interested, I like that patch's idea.
> > git describe dies with an error here in a situation where there is the
> > possibility to do something sensible.
> 
> I think I understand the problem pretty well, and actually I am
> sympathetic to the cause.
> 
> Having said that, I do not agree with the approach of your
> patch.  It makes it inconvenient for scripts to tell describable
> and indescribable revs apart by checking the exit status from
> the command.
OK, that's fine for me.  Then it would be sensible to add a note to the
docs describing the exit codes.

Thanks for your suggestion for my script.

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=sin%28pi%2F2%29
