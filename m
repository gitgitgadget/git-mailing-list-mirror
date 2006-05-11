From: Nicolas Pitre <nico@cam.org>
Subject: Re: Implementing branch attributes in git config
Date: Wed, 10 May 2006 21:53:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605102148310.24505@localhost.localdomain>
References: <1147037659.25090.25.camel@dv>
 <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
 <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
 <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
 <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>
 <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE>
 <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org>
 <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com>
 <Pine.LNX.4.64.0605100823350.3718@g5.osdl.org>
 <46a038f90605101617x1aa9bd2du959ead77ebf61795@mail.gmail.com>
 <Pine.LNX.4.64.0605101629230.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	sean <seanlkml@sympatico.ca>, junkio@cox.net,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 11 03:53:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fe0Ml-0001Xy-Uf
	for gcvg-git@gmane.org; Thu, 11 May 2006 03:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWEKBxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 21:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWEKBxS
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 21:53:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45680 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965116AbWEKBxS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 21:53:18 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IZ2005SVVWTUQM0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 May 2006 21:53:17 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0605101629230.3718@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19901>

On Wed, 10 May 2006, Linus Torvalds wrote:

> 	[branch "origin"]
> 		remote = git://git.kernel.org/pub/scm/git/git.git
> 		branch master

I totally agree with the principle, but I find the above really 
confusing.  Which "branch" means what?  At least if it was "remote_url" 
and "remote_branch" then there wouldn't be any possibility for 
confusion.


Nicolas
