From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: preserving mtime
Date: Mon, 19 Nov 2007 15:38:55 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711191537030.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <473D63F9.4010201@inrim.it> <473D6DC6.8040804@op5.se>
 <20071117182236.GD23659@blorf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Wayne Davison <wayne@opencoder.net>
X-From: git-owner@vger.kernel.org Mon Nov 19 15:39:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu7mU-0002e0-4d
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 15:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbXKSOjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 09:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbXKSOjD
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 09:39:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:45309 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753357AbXKSOjB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 09:39:01 -0500
Received: (qmail invoked by alias); 19 Nov 2007 14:38:59 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp001) with SMTP; 19 Nov 2007 15:38:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ju08w/n1j25HtKpvNF2H9kGDVM2G2cbAeDcX3Yb
	hPIM3GF/cfGa/N
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20071117182236.GD23659@blorf.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65448>

Hi,

On Sat, 17 Nov 2007, Wayne Davison wrote:

> On Fri, Nov 16, 2007 at 11:15:34AM +0100, Andreas Ericsson wrote:
> >> is it possible to tell git to preserve the file modification time in
> >> a checked out copy?
> 
> > Fabrizio Pollastri wrote:
> > No. Doing so would seriously break build-systems.
> 
> I wish that the initial clone would set the modification time to the
> commit time.

Could you stop this discussion, please?  This subject comes up every once 
in a while, and in the meantime the archives contain more sane 
explanations why this would be a bad behaviour of git than I could tell 
off of my head.

So no, this is not a sane behaviour.

If you _must_ inist on this behaviour, write your own hook, don't tell 
anybody about it, especially not when things break.

Hth,
Dscho
