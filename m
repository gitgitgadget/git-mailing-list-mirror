From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 22:26:47 +0200
Message-ID: <20070823202647.GA3516@steel.home>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site> <86mywjcwv7.fsf@lola.quinscape.zz>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:26:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOJGa-0007fx-MJ
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 22:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbXHWU0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 16:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758216AbXHWU0x
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 16:26:53 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:37431 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878AbXHWU0w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 16:26:52 -0400
Received: from tigra.home (Faaab.f.strato-dslnet.de [195.4.170.171])
	by post.webmailer.de (fruni mo57) (RZmta 10.3)
	with ESMTP id w01c0ej7NHWrV1 ; Thu, 23 Aug 2007 22:26:50 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CCE29277BD;
	Thu, 23 Aug 2007 22:26:49 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C8000BE01; Thu, 23 Aug 2007 22:26:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86mywjcwv7.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolCoDQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56524>

David Kastrup, Wed, Aug 22, 2007 19:17:16 +0200:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > And not making the scripts builtins helps Windows users how,
> > exactly?
> 
> Red herring.  The proposal was not to do nothing, but rather give git
> a dedicated scripting language internal to it.  Two suggestions of
> mine with different advantages were git-busybox and Lua.

Different "disadvantages". How do you do pipes and safe inter-program
argument passing in Lua? Portably?
What do you propose to do about gitbox becoming a dependency for
others, who inevitably start using it (why not? It promised to be
portable enough for Git itself!)

> A third one was once proposed by Linus with some code example:
> starting a scripting language from scratch.

It was all about pipes.
