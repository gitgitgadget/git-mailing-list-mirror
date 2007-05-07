From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Checkout fails when one branch contains a directory with the
 name of a file in the other branch
Date: Mon, 7 May 2007 15:00:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705071500210.4167@racer.site>
References: <ubqgw51tf.fsf@assurancetourix.xs4all.nl>
 <Pine.LNX.4.64.0705071329170.4167@racer.site> <463F0E5E.6000204@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tom Koelman <tkoelman@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon May 07 15:00:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl2pX-0002hR-V9
	for gcvg-git@gmane.org; Mon, 07 May 2007 15:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933681AbXEGNAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 09:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933688AbXEGNAl
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 09:00:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:48773 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933681AbXEGNAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 09:00:40 -0400
Received: (qmail invoked by alias); 07 May 2007 13:00:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp016) with SMTP; 07 May 2007 15:00:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19y1dlczYdywYaYvqcPeHYnqYFUhtZxpzAxNgNdA5
	uXV0a1na8JxXbK
X-X-Sender: gene099@racer.site
In-Reply-To: <463F0E5E.6000204@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46462>

Hi,

On Mon, 7 May 2007, Tom Koelman wrote:

> Johannes Schindelin wrote:
> 
> > On Mon, 7 May 2007, Tom Koelman wrote:
> > 
> > > I am not sure whether this is intentional or not. I am wondering why
> > > this scenario fails, and if it is by design, how I should handle this
> > > situation:
> > > 
> > > [...]
> > > 
> > > $ git checkout master
> > > fatal: Untracked working tree file 'aFile' would be overwritten by merge.
> > 
> > I tried to reproduce this behaviour, but it worked here. What Git version
> > do you use? Mine says "git version 1.5.2.rc2.2435.ge5a9b".
> > 
> > Hth,
> > Dscho
> 
> I tried 1.5.1.3 under cygwin and 1.5.0.6 under Linux FC5.

I can confirm that it reproduces with 1.5.1.3. So, it has been fixed in 
1.5.2.rc2.

Ciao,
Dscho
