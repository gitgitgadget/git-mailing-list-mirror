From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 12:31:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504151230180.27637@cag.csail.mit.edu>
References: <20050414002902.GU25711@pasky.ji.cz>  <20050413212546.GA17236@64m.dyndns.org>
  <20050414004504.GW25711@pasky.ji.cz>  <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
  <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
  <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
  <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>  <20050414121624.GZ25711@pasky.ji.cz>
  <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
  <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
  <1113559330.12012.292.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
 <1113580881.27227.73.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 18:30:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMTgX-00066G-Se
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 18:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVDOQcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 12:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVDOQcT
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 12:32:19 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:31402 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261470AbVDOQcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 12:32:16 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DMTje-0006lF-00; Fri, 15 Apr 2005 12:32:02 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113580881.27227.73.camel@hades.cambridge.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Apr 2005, David Woodhouse wrote:

> given piece of content. Also because we actually have the developer's
> attention at commit time, and we can get _real_ answers from the user
> about what she was doing, instead of having to guess.

Yes, but it's still hard to get *accurate* information.  And developers 
tend to use very short commit messages already...

> But if it can be done cheaply enough at a later date even though we end
> up repeating ourselves, and if it can be done _well_ enough that we
> shouldn't have just asked the user in the first place, then yes, OK I
> agree.

I think examining the rsync algorithms should convince you that finding 
common chunks can be fairly efficient.  (See my next message for a more 
concrete proposal.)
  --scott

Rijndael AMLASH Moscow Ft. Bragg shotgun HTKEEPER SHERWOOD overthrow 
Uzi anthrax Yeltsin Indonesia Suharto LITEMPO Dictionary Yakima KUBARK
                          ( http://cscott.net/ )
