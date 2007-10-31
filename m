From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cpio command not found
Date: Wed, 31 Oct 2007 14:20:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710311420330.4362@racer.site>
References: <18216.31314.990545.518458@lisa.zopyra.com>
 <20071031133039.GA29065@diana.vm.bytemark.co.uk> <20071031140655.GA8802@gateway.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Karl Hasselstr?m <kha@treskal.com>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Erik Mouw <mouw@nl.linux.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:21:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InES2-0002SE-9o
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 15:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbXJaOVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 10:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755917AbXJaOVc
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 10:21:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:36216 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755303AbXJaOVb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 10:21:31 -0400
Received: (qmail invoked by alias); 31 Oct 2007 14:21:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 31 Oct 2007 15:21:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19H2tBCHKlHRjJkZQPrb+Rnk/Z3H69f53r9S+aby9
	szdzGZfRvyBPim
X-X-Sender: gene099@racer.site
In-Reply-To: <20071031140655.GA8802@gateway.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62836>

Hi,

On Wed, 31 Oct 2007, Erik Mouw wrote:

> On Wed, Oct 31, 2007 at 02:30:39PM +0100, Karl Hasselstr?m wrote:
> > On 2007-10-31 06:51:30 -0600, Bill Lear wrote:
> > 
> > > I don't remember this dependence from earlier versions of git. I 
> > > have been running git 1.4.xx on this machine for a while...
> > 
> > When you clone with -l, git uses cpio to hardlink to the original 
> > repository. What has changed is that -l is now used by default when 
> > cloning a repository that's accessed via the file system (as opposed 
> > to over some network protocol).
> 
> Why cpio? What is wrong with ln(1) (every Unix should have one) or
> link(2) ?

Patch, please?

Ciao,
Dscho
