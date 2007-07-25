From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: index-pack died on pread
Date: Wed, 25 Jul 2007 22:48:17 +0200
Message-ID: <20070725204817.GA3645@steel.home>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com> <81b0412b0707230832w438613d0rdaa8dc97013962a6@mail.gmail.com> <333e1ca10707251307k21b5f58bjb8e5803173e3d9b3@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Michal Rokos <michal.rokos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:49:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDnn4-000780-4l
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 22:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758824AbXGYUsX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 16:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762693AbXGYUsW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 16:48:22 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:62840 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763329AbXGYUsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 16:48:20 -0400
Received: from tigra.home (Fcabf.f.strato-dslnet.de [195.4.202.191])
	by post.webmailer.de (mrclete mo15) (RZmta 10.3)
	with ESMTP id U07219j6PJRNkl ; Wed, 25 Jul 2007 22:48:18 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id DF600277BD;
	Wed, 25 Jul 2007 22:48:17 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 6807EBDD0; Wed, 25 Jul 2007 22:48:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <333e1ca10707251307k21b5f58bjb8e5803173e3d9b3@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv/vsc=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53718>

Michal Rokos, Wed, Jul 25, 2007 22:07:50 +0200:
> On 7/23/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> >On 7/23/07, Michal Rokos <michal.rokos@gmail.com> wrote:
> >> fatal: cannot pread pack file: No such file or directory (n=0,
> >> errno=2, fd=3, ptr=40452958, len=428, rdy=0, off=123601)
> >> fatal: index-pack died with error code 128
> >
> >strange. pread(2) should not return ENOENT. Not in HP-UX
> >not anywhere.
> >
> >Could you recompile with NO_PREAD=1 and try again?
> >Maybe HP-UX pread(2) implementation is just broken.
> 
> When I tried to recompile with NO_PREAD=1 the problem disappeared.

I think that's a fair indication for HP-UX has a broken pread(2).

> Do you want me to try something more with it?

No. Put NO_PREAD=1 in your config.mak on HP-UX.
