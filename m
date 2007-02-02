From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Fri, 2 Feb 2007 11:48:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702021146440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070201234706.GP17617@mellanox.co.il>
 <Pine.LNX.4.63.0702020050190.18870@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz3xmju9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 11:48:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCvxx-0000GH-9T
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 11:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422841AbXBBKsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 05:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422843AbXBBKsN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 05:48:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:50904 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422841AbXBBKsM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 05:48:12 -0500
Received: (qmail invoked by alias); 02 Feb 2007 10:48:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 02 Feb 2007 11:48:11 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz3xmju9.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38489>

Hi,

On Thu, 1 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 2 Feb 2007, Michael S. Tsirkin wrote:
> > ...
> >> One can always get more branches later, is my approach.
> >
> > Yes. But in the same vein, one can add _one_ branch to an empty repo 
> > either. So, with your reasoning, your patch wouldn't be needed to begin 
> > with.
> 
> Indeed.
> 
> > But I find it useful. Even the version where you are not limited to one 
> > branch.
> 
> I am not against the general idea of tracking a subset of
> branches, but issues include:
>
> [explains why git-remote is a better place for this]

Seeing your patch to git-remote, it feels more natural, too. Especially 
since that (or which? :-D) does not give the term "clone" a 
Microsoft'esque completely new meaning.

Ciao,
Dscho
