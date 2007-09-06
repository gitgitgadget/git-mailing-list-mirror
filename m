From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Invoke "git gc --auto" from "git add" and "git fetch"
Date: Thu, 6 Sep 2007 13:02:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061301250.28586@racer.site>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
 <7vhcm8j1bp.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 14:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITG4D-0003i5-43
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 14:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbXIFMCd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 08:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbXIFMCc
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 08:02:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:43472 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752954AbXIFMCb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 08:02:31 -0400
Received: (qmail invoked by alias); 06 Sep 2007 12:02:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 06 Sep 2007 14:02:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lpnZh+KtlGmBPhNr5OmjdyZC64nPtM8IVxRZKQa
	7gjVZPWvN0O9og
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcm8j1bp.fsf_-_@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57871>

Hi,

On Wed, 5 Sep 2007, Junio C Hamano wrote:

>  * This is obviously a follow-up to the previous one that allows
>    you to say "git gc --auto".  I somewhat feel dirty about
>    calling cmd_gc() bypassing fork & exec from "git add",
>    though...

Since all git-gc seems to do is to fork() and exec() other git programs, 
this should be fine (have not looked at cmd_gc() in a while, though).

Ciao,
Dscho
