From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] git-submodule - Follow top-level remote on
 init/update/clone
Date: Tue, 12 Feb 2008 01:10:08 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802120109270.3870@racer.site>
References: <1202576245-284-1-git-send-email-mlevedahl@gmail.com> <alpine.LSU.1.00.0802112152050.3870@racer.site> <47B0EFA2.9070903@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 02:11:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOjfx-00066a-MK
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 02:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857AbYBLBKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 20:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbYBLBKI
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 20:10:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:36842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752933AbYBLBKB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 20:10:01 -0500
Received: (qmail invoked by alias); 12 Feb 2008 01:09:58 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp032) with SMTP; 12 Feb 2008 02:09:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18S/vFefRcSZobKhoGY5MkTV/sOJllbihfYS/N++Y
	EWbV2QmkeODRE9
X-X-Sender: gene099@racer.site
In-Reply-To: <47B0EFA2.9070903@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73616>

Hi,

On Mon, 11 Feb 2008, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> 
> > > @@ -107,7 +112,7 @@ module_clone()
> > >  	test -e "$path" &&
> > >  	die "A file already exist at path '$path'"
> > >  -	git-clone -n "$url" "$path" ||
> > > +	git-clone -n -o "$remote" "$url" "$path" ||
> > >  	die "Clone of '$url' into submodule path '$path' failed"
> > >  }
> > >      
> > 
> > If you do _that_, you will _force_ the submodule to have no "origin" 
> > remote.  As discussed _at length_, this is not what you should do.  
> > The only reason to use "-o <other-nick-name>" is if you plan _not_ to 
> > use the same URL for the default remote.
>
> This *must* define the remote using the same name as flowed down from 
> top-level, whatever that name is.

At this point, I give up my review in despair,
Dscho
