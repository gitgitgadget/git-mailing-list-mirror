From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 05 Apr 2009 23:24:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904052315210.6741@xanadu.home>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic>
 <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic>
 <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic>
 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 05:26:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqfU5-0002yv-S4
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 05:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbZDFDYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 23:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbZDFDYf
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 23:24:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63862 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbZDFDYf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 23:24:35 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHN003RVTGRJPT0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 05 Apr 2009 23:24:28 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115758>

On Sun, 5 Apr 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Sun, Apr 5, 2009 at 23:28,  <david@lang.hm> wrote:
> > Guys, back off a little on telling the gentoo people to change.
> 
> I agree here, we should either say "look, we don't really support big
> repositories because [explanation here], unless you [workarounds
> here]" OR we should work to improve the support we do have. Of course,
> the latter option does not magically create developer time to work on
> that, but if we do go that way we should at least tell people that we
> are aware of the problems and that it's on the global TODO list (not
> necessarily on anyone's personal TODO list though).

For the record... I at least am aware of the problem and it is indeed on 
my personal git todo list.  Not that I have a clear solution yet (I've 
been pondering on some git packing issues for almost 4 years now).

Still, in this particular case, the problem appears to be unclear to me, 
like "this shouldn't be so bad".

> Of course, the problem can sometimes be solved by splitting the
> repository, but I think it is important to have an official policy
> here, do we want Git to support huge repositories, or do we not?

I do.


Nicolas
