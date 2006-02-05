From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] do not open editor in dumb terminal
Date: Sat, 04 Feb 2006 21:48:18 -0800
Message-ID: <7vlkwqmk4d.fsf@assigned-by-dhcp.cox.net>
References: <20060203114133.GA11499@kvasir.watson.ibm.com>
	<7vu0bgdxmh.fsf@assigned-by-dhcp.cox.net>
	<20060205003741.GB29021@kvasir.watson.ibm.com>
	<7voe1msef0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602042346380.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Amos Waterland <apw@us.ibm.com>, git@vger.kernel.org,
	boutcher@cs.umn.edu
X-From: git-owner@vger.kernel.org Sun Feb 05 06:48:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5cl8-0001Fp-4u
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 06:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWBEFsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 00:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWBEFsV
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 00:48:21 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19110 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964899AbWBEFsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 00:48:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060205054519.XRJI17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 00:45:19 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0602042346380.25300@iabervon.org> (Daniel
	Barkalow's message of "Sun, 5 Feb 2006 00:04:40 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15622>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I think that "ed" is a bit too obscure as something for people to use 
> interactively, and emacsclient is obviously not a sane default (since 
> people might not be using emacs in server mode). Probably the right thing 
> is to have it supply a default if the terminal isn't dumb, and abort with 
> an error if there is no editor set after defaults are supplied.

I tend to agree (I am a minority who used ed for a long time,
but I am well aware that I _am_ a minority).  If somebody wants
to send in a tested patch to be applied, I would suggest to
replace EDITOR=ed in the one I sent out with an error message
and exit(1).
