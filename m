From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Tue, 12 Jun 2007 01:16:48 +0200
Message-ID: <20070611231648.GC4649@steel.home>
References: <20070608202236.GJ25093@menevado.ms.com> <200706111656.33696.simon@lst.de> <81b0412b0706110844i12ebe52m21735815cc06effa@mail.gmail.com> <200706112042.16331.simon@lst.de> <20070611201232.GA4649@steel.home> <466DBCAB.8090006@slamb.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 01:16:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxt87-0008Fb-Hu
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 01:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbXFKXQx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 19:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbXFKXQx
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 19:16:53 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:44554 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbXFKXQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 19:16:52 -0400
Received: from tigra.home (Fca0c.f.strato-dslnet.de [195.4.202.12])
	by post.webmailer.de (mrclete mo62) (RZmta 7.2)
	with ESMTP id E0151dj5BLXKqg ; Tue, 12 Jun 2007 01:16:49 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 578F4277BD;
	Tue, 12 Jun 2007 01:16:49 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 00D09D261; Tue, 12 Jun 2007 01:16:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <466DBCAB.8090006@slamb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv0bw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49899>

Scott Lamb, Mon, Jun 11, 2007 23:20:43 +0200:
> >>>  git-p4 clone //depot/project/path [libs/project/path] [rev-range]
> >>
> >>I'm not sure I understand the libs/project/path part, ...
> >
> >Your client contains the mappings. It defines how the pathnames on the
> >p4 server relate to that on your computer. In the example above file
> >from the depot path //depot/project/path can be found in the directory
> >of the p4 client in the subdirectories libs/project/path.
> 
> git-p4 doesn't even use a p4 client, ...

I didn't say: "using p4 client, figure out where to put the files".
I said: _here_ is the mapping, put the files where I told you to.

> >>Han-Wen implemented also support for importing multiple depot paths at 
> >>the same time (and tracking them in one git branch).
> >
> >And where does he put the depot paths? As they are in depot? How does
> >this corelate to the setups done by genuine P4 users (the poor souls)
> >where the mappings are not always 1-to-1 right from the root? Or you
> >haven't got any?
> 
> Could you give a concrete example of what you have and what you are 
> trying to produce?

Get the p4 file //depot/project/file and put it into git as
libs/project/file.

> >>The environment I'm working in is not too big and fairly liberal and 
> >>reasonably disciplined.
> >
> >You must be very strange environment indeed. Carefully balanced.
> 
> Not that strange. My company's setup is pretty simple, too. The project 
> I'm working on just uses has each branch under 
> "//depot/project/BRANCH/...".

It is not a branch (as a "line of development"). It is merely a
directory with server-side backup. Why do people continue call them
branches, I wonder...

> Maybe your environment is the odd one?

Just what do you think is a client view? Ever wondered what the
right-hand side of lines in the "View:" section is for?
