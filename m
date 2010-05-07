From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 07 May 2010 17:12:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005071708090.14468@xanadu.home>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
 <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
 <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>
 <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>
 <alpine.LFD.2.00.1005071529050.14468@xanadu.home>
 <m2g32541b131005071236u962d2c73n85d25093d1e048bb@mail.gmail.com>
 <alpine.LFD.2.00.1005071626040.14468@xanadu.home>
 <n2l32541b131005071400uf90ab0e8se882fce6b3abf522@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 23:13:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAUrL-00006j-3S
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 23:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758552Ab0EGVM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 17:12:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44455 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758547Ab0EGVMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 17:12:25 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L2200EAXIWOV8M0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 May 2010 17:12:25 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <n2l32541b131005071400uf90ab0e8se882fce6b3abf522@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146600>

On Fri, 7 May 2010, Avery Pennarun wrote:

> On Fri, May 7, 2010 at 4:29 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 7 May 2010, Avery Pennarun wrote:
> >> Since the options it *does* have are exactly the same as .git/config,
> >> however, naming it .gitconfig makes sense.
> >
> > Well, I disagree.
> >
> >> I'd say just print a
> >> warning when reading options that are going to be ignored for security
> >> reasons (or because they're not known at all, or whatever).
> >
> > Or just make it .gitparams (or anything you wish) which is not the same
> > as gitconfig. This way it is less likely to get bogus bug reports for
> > options that aren't supported.
> 
> It has exactly the same syntax as ~/.gitconfig, and the options it
> does support can all be carried over literally to ~/.gitconfig.

Absolutely not.

Most options for ~/.gitconfig simply make no sense in a distributed 
.gitconfig file.

> Calling it something else would imply that it deserves its own man
> page, which would need to repeat all the options that are already
> documented for ~/.gitconfig.

No because most of those options don't and can't apply to a distributed 
option file.

> I'd say something that's syntactically identical, and in some cases
> actually interchangeable, should have the same name.

Indeed.  But this is not the case here.


Nicolas
