From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Adding color to git-add--interactive
Date: Wed, 10 Oct 2007 23:09:58 +0200
Message-ID: <20071010210958.GA16635@steel.home>
References: <91EBB71E-BB4E-4089-8C33-6B0C4A61223A@steelskies.com> <20071009234020.GA20952@coredump.intra.peff.net> <Pine.LNX.4.64.0710101604350.4174@racer.site> <20071010170621.GA5444@coredump.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan del Strother <maillist@steelskies.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:10:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifiou-0005HZ-DT
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252AbXJJVKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbXJJVKE
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:10:04 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:13776 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228AbXJJVKB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:10:01 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (fruni mo28) (RZmta 13.4)
	with ESMTP id 302d9fj9AIfoyi ; Wed, 10 Oct 2007 23:09:59 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2200A277AE;
	Wed, 10 Oct 2007 23:09:59 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A2B94C502; Wed, 10 Oct 2007 23:09:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071010170621.GA5444@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60541>

Jeff King, Wed, Oct 10, 2007 19:06:21 +0200:
> On Wed, Oct 10, 2007 at 04:06:09PM +0100, Johannes Schindelin wrote:
> 
> > I think the reason git-add--interactive does not use it is that some 
> > people (me included) experienced heavy problems with perl modules.  
> > However, I do not recall to which extent they have been solved.  I guess 
> > when git-add--interactive goes Git.pm and stops working for me, I'll do my 
> > famous "aargh, I'll just make it a builtin" song.
> 
> I had thought this was the case, too (and in fact, I started to write
> "we don't have a good solution for sharing perl code"), but it looks
> like git-remote, git-svn, and git-send-email are all using Git.pm these
> days.
> 

And strangely enough, git-remote is even usable on cygwin.
Can't say for others though.
