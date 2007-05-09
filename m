From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Wed, 9 May 2007 23:39:02 +0200
Message-ID: <20070509213902.GA2593@steel.home>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home> <46413565.3090503@zytor.com> <81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com> <4641FDAF.3090608@zytor.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed May 09 23:40:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlttG-0001BY-0x
	for gcvg-git@gmane.org; Wed, 09 May 2007 23:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbXEIVj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbXEIVj7
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 17:39:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:36523 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955AbXEIVj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 17:39:59 -0400
Received: from tigra.home (195.4.202.222)
	by post.webmailer.de (klopstock mo57) (RZmta 5.9)
	with ESMTP id I01e71j49K1Ns8 ; Wed, 9 May 2007 23:39:02 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B5B34277BD;
	Wed,  9 May 2007 23:39:02 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2BFF6D171; Wed,  9 May 2007 23:39:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4641FDAF.3090608@zytor.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTj/u1c=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46793>

H. Peter Anvin, Wed, May 09, 2007 18:58:23 +0200:
> >>
> >> Mine stops already at the directory -> symlink checkin (the above is the
> >> symlink -> directory one), but your trick of using "git checkout" as a
> >> trick to resolve things helped for both... eventually :-/
> > 
> > Hmm. What Git version do you have?
> 
> Not sure anymore, because I ran a systemwide upgrade late last night.
> *Now* I have git-1.5.1.4, but I think I had 1.5.1.2 before.

... and the rebase you tried originally works now? Or you didn't try?
There were changes (substantial changes) in this area, so it might be
fixed. If not, I'd like to hear, I personally rely on rebase heavily.

> >> Either way, it's still a bug that it stops for either checkin, ...
> > 
> > Right. And because it is a bug, I'd like to have it fixed.
> > So, what did you do in that fixup?
> 
> I'm sorry, I'm not sure I understand the question, in particular, I'm
> getting the feeling I'm not sure what "that fixup" refers to.
> 

>From your original report:

"git rebase dies horribly; on the first change it requires manual fixup,
but it crashes on the second, with or without -m."

You mentioned that on the first change (I assumed it is the first time
git-rebase stopped, complained, and asked for your help) "it" requires
a "manual fixup". Which I assume you did, as it crashed on "second"
(stop?). The "manual fixup" from the original report, what was it?
Can you remember or find the sequence of commands you did before "it
crashed on second"?
