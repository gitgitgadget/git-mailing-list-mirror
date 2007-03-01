From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Thu, 1 Mar 2007 02:09:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703010208070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702281303.11951.andyparkins@gmail.com> <45E5D0D7.5070305@dawes.za.net>
 <Pine.LNX.4.63.0702282042000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45E5F3D4.8000509@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Rogan Dawes <discard@dawes.za.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:10:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMZo2-0004Bp-MG
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 02:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbXCABJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 20:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932887AbXCABJ7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 20:09:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:41767 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932886AbXCABJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 20:09:59 -0500
Received: (qmail invoked by alias); 01 Mar 2007 01:09:57 -0000
X-Provags-ID: V01U2FsdGVkX1/bskA0yIjbEpKw4m3oZotK3OhtbfsHZtE9axqvPz
	HPPg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E5F3D4.8000509@dawes.za.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41026>

Hi,

On Wed, 28 Feb 2007, Rogan Dawes wrote:

> Johannes Schindelin wrote:
> 
> > On Wed, 28 Feb 2007, Rogan Dawes wrote:
> > 
> > > How about showing the size of the changes between the 2 files via 
> > > the libxdiff binary patch function?
> > 
> > I briefly considered this, too. But what would it tell you in the case 
> > of a jpg? I think it has more disadvantages than advantages...
> 
> It would still tell you the extent of the changes. i.e. Did we change 
> only 10 bytes of the file, or is it a dramatic change?

I was not explicit enough, okay. I was not so worried about the case where 
only 10 bytes changed. If you insert a single dot in a jpg image, chances 
are that your binary content will change _a lot_.

So, no problem deducing from 10 bytes changed that it was a minor change. 
But you cannot deduce the opposite of a 1MB change!

Hth,
Dscho
