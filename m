From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Sun, 16 Oct 2005 19:10:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510161906220.25573@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> <434EABFD.5070604@zytor.com>
 <434EC07C.30505@pobox.com> <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
 <435264B1.2010204@de.bosch.com> <Pine.LNX.4.63.0510161122570.23242@iabervon.org>
 <20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Hengeveld <nickh@reactrix.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 16 19:10:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERC1f-0005XY-Js
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 19:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVJPRKU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 13:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVJPRKU
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 13:10:20 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34529 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751337AbVJPRKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 13:10:18 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3E0CE13EB7F; Sun, 16 Oct 2005 19:10:15 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1188AB4D6E; Sun, 16 Oct 2005 19:10:15 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EAE515987A; Sun, 16 Oct 2005 19:10:14 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 655E513EB7F; Sun, 16 Oct 2005 19:10:11 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Brian Gerst <bgerst@didntduck.org>
In-Reply-To: <43527E86.8000907@didntduck.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10163>

Hi,

On Sun, 16 Oct 2005, Brian Gerst wrote:

> Nick Hengeveld wrote:
> > On Sun, Oct 16, 2005 at 11:44:46AM -0400, Daniel Barkalow wrote:
> > 
> > > This is the problem: it's impossible to download only a few objects from a
> > > pack file from an HTTP server, because those don't exist on the server as
> > > separate files.
> > 
> > Is it possible to determine the object locations inside the remote pack
> > file?  If so, it would be possible to use Range: headers to download
> > selected objects from a pack.
> > 
> 
> Not possible because the entire pack is compressed.

Maybe we should introduce an option which only packs objects of a minimal 
age (something like "pack only objects 2 days and older")? This could be 
used to autopackage as long as HTTP is the preferred protocol, so that if 
you update daily, you already have those objects.

Alternatively, git-prune-packed could have an option to prune only those 
objects older than 2 days.

Ciao,
Dscho
