From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Wed, 11 Nov 2009 16:19:44 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911111617440.16711@xanadu.home>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <20091111184215.GG27518@vidovic>
 <alpine.LFD.2.00.0911111408380.16711@xanadu.home>
 <20091111210727.GN12890@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Nov 11 22:19:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8KbX-0002m6-VQ
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 22:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759263AbZKKVTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 16:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759245AbZKKVTk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 16:19:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52870 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759239AbZKKVTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 16:19:39 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSY00379R8W8E90@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Nov 2009 16:19:44 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091111210727.GN12890@machine.or.cz>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132704>

On Wed, 11 Nov 2009, Petr Baudis wrote:

> On Wed, Nov 11, 2009 at 02:50:22PM -0500, Nicolas Pitre wrote:
> > According to strace, data from sideband channel #2 (prefixed with 
> > "remote: ") pertaining to object compression is printed way after pack 
> > data has already started to arrive locally.  This is really weird.
> > 
> > And this occurs only when fetching from repo.or.cz and not from 
> > git.kernel.org for example.  So there is something to investigate on the 
> > server side.  Pasky: anything you changed in your git installation 
> > lately?
> 
> Yes, but nothing should have changed in git-daemon, that's the only part
> of the infrastructure that uses system-wide git (which it perhaps
> shouldn't). I cannot reproduce this problem, though. I have changed
> git-daemon to use my local git version (about one week old master), does
> this still happen for you?

No, it doesn't happen anymore.

What was the git-daemon version before?


Nicolas
