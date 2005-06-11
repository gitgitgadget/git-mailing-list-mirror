From: "Tommy M. McGuire" <mcguire@crsr.net>
Subject: Re: do people use the 'git' command?
Date: Sat, 11 Jun 2005 11:01:35 -0500
Message-ID: <20050611160135.GA6522@immutable.crsr.net>
References: <E1DgodI-0003ov-Fl@highlab.com> <7vy89h4m9r.fsf@assigned-by-dhcp.cox.net> <E1DgyW0-0004PE-Ct@highlab.com> <2cfc403205061023346c03a25b@mail.gmail.com> <7vpsutz88z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jon@blackcubes.dyndns.org, Sebastian Kuzminsky <seb@highlab.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 17:57:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh8Me-0004Ha-DX
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 17:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVFKQB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 12:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVFKQB6
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 12:01:58 -0400
Received: from [65.98.21.155] ([65.98.21.155]:62478 "EHLO immutable.crsr.net")
	by vger.kernel.org with ESMTP id S261553AbVFKQBx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2005 12:01:53 -0400
Received: from mcguire by immutable.crsr.net with local (Exim 3.35 #1 (Debian))
	id 1Dh8QS-0001hl-00; Sat, 11 Jun 2005 11:01:36 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsutz88z.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 11, 2005 at 12:02:20AM -0700, Junio C Hamano wrote:
> But the real point of "git" wrapper is merely to present CVS and SVN
> refugees the structure they are familiar with: a single command having
> a set of subcommands.

CVS and SVN refugees (like me :-)) should probably be pointed to
porcelain.  Showing them a mixture of relatively unpolished "git
<subcommand>" and "git-*" commands is not likely to impress them with
the simplicity and elegance of the tool.  I don't think the surface
structure of "<command> <subcommand>" is an important factor, and
the first time they see a 40-hex-digit number, they'll be headed for the
hills.

> Personally I think removal of "git" script is a bad idea.

I'd agree, for the opposite reason: the git script is a decent interface
for power users who don't want to use anything porcelainish.  It also
provides a good place to hang custom functionality.

-- 
Tommy McGuire
