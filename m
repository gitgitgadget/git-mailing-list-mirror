From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC] 'git cat-file' needs a better design on its option interface
Date: Thu, 24 Sep 2009 15:30:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909241528110.4997@xanadu.home>
References: <3a3680030909240804w1399ed7fhd6367300544f34f@mail.gmail.com>
 <alpine.LFD.2.01.0909241021120.3303@localhost.localdomain>
 <vpqy6o4kv24.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Li Hong <lihong.hi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 24 21:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqu4l-0003Jo-EX
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 21:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbZIXTal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 15:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbZIXTah
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 15:30:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20431 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbZIXTad (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 15:30:33 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQH001T1Q6W0MA0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 24 Sep 2009 15:30:33 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqy6o4kv24.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129057>

On Thu, 24 Sep 2009, Matthieu Moy wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > 'git cat-file' is really really low-level plumbing. Humans should 
> > generally never use it.
> 
> ... except to understand Git better ;-). I enjoyed being able to to a
> 'git cat-file' on a tree or commit object when I started with Git.

In the context of learning git at that level, the current option 
interface for cat-file shouldn't look too strange though.


Nicolas
