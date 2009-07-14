From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re: Make 'git show' more useful
Date: Tue, 14 Jul 2009 03:25:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907140324140.3155@pacific.mpi-cbg.de>
References: <7vtz1gi67v.fsf@alter.siamese.dyndns.org> <1247528614-24590-1-git-send-email-bonzini@gnu.org> <alpine.LFD.2.01.0907131652120.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 03:24:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQWkg-0007NV-Mh
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 03:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbZGNBX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 21:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbZGNBX6
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 21:23:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:59942 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752333AbZGNBX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 21:23:58 -0400
Received: (qmail invoked by alias); 14 Jul 2009 01:23:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 14 Jul 2009 03:23:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18emAFxRtAerKL+X/1gFJ0jrU9HhcSXws4QIjxjxg
	uwMLS/XCgUL4aW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.01.0907131652120.13838@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123216>

Hi,

On Mon, 13 Jul 2009, Linus Torvalds wrote:

> The actual "--no-walk" flag was then added over a year later by Dsco, in 
> commit 8e64006eee ("Teach revision machinery about --no-walk").
> 
> Doing a "git log -p -S--no-walk", I have to admit that I don't find a 
> single actual _use_ of --no-walk.

Actually, I remember very precisely why I introduced it.  The difference 
between "git log --no-walk a b c" and "git show a b c" is that "git log" 
sorts the commits by commit time, which is pretty important in my case.

So I'd appreciate not doing away with that option.

Thanks,
Dscho "whose name has an h in it"
