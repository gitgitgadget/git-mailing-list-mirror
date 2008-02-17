From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Sun, 17 Feb 2008 20:51:38 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802172050090.30505@racer.site>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org> <7vd4r24ox6.fsf@gitster.siamese.dyndns.org> <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org> <m3d4qvbt40.fsf@localhost.localdomain> <7vtzk7xqg3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 21:52:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQqUr-0003lz-Sc
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 21:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbYBQUvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 15:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbYBQUvu
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 15:51:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:46724 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752691AbYBQUvu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 15:51:50 -0500
Received: (qmail invoked by alias); 17 Feb 2008 20:51:48 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp048) with SMTP; 17 Feb 2008 21:51:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xl2Rzk5SxRyyZCXU8BHk6UIGKEjpdRoTIrbsqzK
	8aqtGvoEvUQdol
X-X-Sender: gene099@racer.site
In-Reply-To: <7vtzk7xqg3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74182>

Hi,

On Sun, 17 Feb 2008, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> >>   commit: discard index after setting up partial commit
> >
> > IIRC there was also request for proper solution; this was more a hack.
> 
> It is not a hack at all.
> 
> The more fundamental improvement was along the lines of what I suggested 
> soon after Kristian's initial round was posted, but what the current 
> code does is not wrong nor hack.  It is about a partial commit after all 
> and is not performance critical either.

You mean: at this point, it is not necessary to be careful about the 
index, as the index that will be reloaded will already have the most 
recent timestamps, right?

Ciao,
Dscho
