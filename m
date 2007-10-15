From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 19:36:09 +0200
Message-ID: <20071015173609.GA2966@steel.home>
References: <20071014221446.GC2776@steel.home> <023101c80eb5$e3b6b310$2e08a8c0@CAM.ARTIMI.COM> <Pine.LNX.4.64.0710150059460.25221@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Korn <dave.korn@artimi.com>, 'Andreas Ericsson' <ae@op5.se>,
	'git list' <git@vger.kernel.org>,
	'Make Windows' <make-w32@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 20:42:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhTri-0003cm-0C
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 19:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999AbXJORgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 13:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757708AbXJORgR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 13:36:17 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:9467 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757461AbXJORgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 13:36:14 -0400
Received: from tigra.home (Fc8e3.f.strato-dslnet.de [195.4.200.227])
	by post.webmailer.de (mrclete mo34) (RZmta 13.4)
	with ESMTP id j00bdej9FFfDQ5 ; Mon, 15 Oct 2007 19:36:10 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 70CC8277AE;
	Mon, 15 Oct 2007 19:36:10 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0AA6656D22; Mon, 15 Oct 2007 19:36:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710150059460.25221@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow2U+g=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61017>

Johannes Schindelin, Mon, Oct 15, 2007 02:01:00 +0200:
> On Sun, 14 Oct 2007, Dave Korn wrote:
> > On 14 October 2007 23:15, Alex Riesen wrote:
> > > - it has only one argument (limited in size) passed to started
> > >   programs, which means that there is no possible way to safely pass
> > >   file and text arguments on command line (more than one, that is)
> > 
> >   Whuh?
> > 
> > http://msdn2.microsoft.com/en-us/library/y5zz48s1(VS.80).aspx
> 
> It does have an exec() call, yes, since that is required by the C 
> standard.  But internally, it converts that into one single command line.
> 
> In corner cases, you find problems with that.
> 

Like: "damn, it is just IMPOSSIBLE to implement without them corner
cases."
