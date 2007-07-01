From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sun, 1 Jul 2007 13:12:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707011301540.4438@racer.site>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
 <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net> <20070630194335.GK7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <7vtzsoami9.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0706301955560.1172@woody.linux-foundation.org>
 <7vsl8894tc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Carlos Rica <jasampler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 14:12:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4yI4-0000VN-PO
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 14:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672AbXGAMMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 08:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbXGAMMW
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 08:12:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:59140 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755164AbXGAMMW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 08:12:22 -0400
Received: (qmail invoked by alias); 01 Jul 2007 12:12:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 01 Jul 2007 14:12:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+q7btIU5OqXeGUqmxLBT77ujl0ExCbBoUmfSJkqE
	abWgmx7i9Yltuy
X-X-Sender: gene099@racer.site
In-Reply-To: <7vsl8894tc.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51289>

Hi,

On Sat, 30 Jun 2007, Junio C Hamano wrote:

> Your patch _closes the door_ for us to implement overriding aliases 
> later if we wanted to; we would need to go back to the scripts and say 
> "git --no-alias xyzzy" again.

No, it does not.

Carlos had a cute idea on IRC, but was too shy to mention it here. There 
is a central place for Git's shell script, git-sh-setup. Defining an 
environment variable there, GIT_NO_ALIAS, and honouring that in the Git 
wrapper. Something similar is possible in Git.pm for perl scripts.

Note: I am opposed to overriding default parameters via alias. I am only 
stating that it is still possible.

I am in favour of Linus' patch. Here's why: quite some times, I have been 
asked (at a very late stage) "What still confuses me: what is the 
difference between git-xyz and git xyz?" It _is_ confusing for beginners, 
even if it is easy to explain.

Ciao,
Dscho
