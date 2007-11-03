From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-format-patch: Number patches when there are more
 than one
Date: Sat, 3 Nov 2007 16:31:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031631020.4362@racer.site>
References: <Pine.LNX.4.64.0710221044080.25221@racer.site>
 <1194104694-12530-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>,
	spearce@spearce.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 17:32:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoLvI-0007Bq-6Z
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 17:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500AbXKCQcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 12:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572AbXKCQcT
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 12:32:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:58484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754447AbXKCQcS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 12:32:18 -0400
Received: (qmail invoked by alias); 03 Nov 2007 16:32:17 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp049) with SMTP; 03 Nov 2007 17:32:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/C3fJKZJTCoZfDtyW0f5P8A8glmCMCdXhvaaVRoX
	+Fh8oyJXHluh0B
X-X-Sender: gene099@racer.site
In-Reply-To: <1194104694-12530-1-git-send-email-mh@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63290>

Hi,

On Sat, 3 Nov 2007, Mike Hommey wrote:

> Automagically enable numbering if we output more than one patch.
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
> 
> On Mon, Oct 22, 2007 at 10:44:12AM +0100, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Sun, 21 Oct 2007, Andreas Ericsson wrote:
> > 
> > > [PATCH 1/1] looks a bit silly, and automagically handling this in 
> > > git-format-patch makes some scripting around it a lot more pleasant.
> > 
> > I think you should not use "-n" if you do not want to have the numbers.  
> > In circumstances as yours, where you can have patch series larger than 
> > one, I imagine that the "[PATCH 1/1]" bears an important information, 
> > which is not present in "[PATCH]": this patch series contains only one 
> > patch.
> > 
> > IOW I do not like your patch: too much DWIDNS (Do What I Did NOT Say) for 
> > me.
> 
> How about the contrary ?

Still DWIDNSAA.

Ciao,
Dscho
