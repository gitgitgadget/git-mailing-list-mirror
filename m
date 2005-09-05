From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Sun, 04 Sep 2005 20:54:12 -0400
Message-ID: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 03:13:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC5XB-00070w-13
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 03:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVIEBMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 21:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVIEBMT
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 21:12:19 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53381 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932152AbVIEBMT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2005 21:12:19 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j850sC3D023778;
	Sun, 4 Sep 2005 20:54:12 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Sun, 04 Sep 2005 17:03:07 MST." <7vmzmsbcuc.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8075>

Junio C Hamano <junkio@cox.net> wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> writes:
> >> 3. Non-binaries are called '*-scripts'.
> >> 
> >>    In earlier discussions some people seem to like the
> >>    distinction between *-script and others; I did not
> >>    particularly like it, but I am throwing this in for
> >>    discussion.

> > I for one think this makes the command name dependent on a non-essential
> > implementation detail, so -script should go.

> I had the same opinion.  The counter-argument people raised when
> this topic came up on the list was that it would help grepping
> in the source tree.

Grepping for what?

It is not /that/ much more expensive to run file(1) over the tree if you
want to know what is a script and what isn't. Furthermore, the "-script"
extension doesn't work for this as of today (see your own message a while
back ;-). Keeping it requires discipline that tools don't help enforcing
today (and the extension use itself is very un-Unix-like), so further
"mistakes" /will/ happen.

In any case, this would be for a very specialized, developer-only,
occasional task. I don't see how that warrants a fractured tool namespace
for /all/ users /all/ the time.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
