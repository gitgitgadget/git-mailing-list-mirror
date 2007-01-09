From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Pushing into a repository with working directory?
Date: Tue, 9 Jan 2007 14:51:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701091449320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070102045108.GC27690@spearce.org> <459E1182.201@shadowen.org>
 <7vwt41j1le.fsf@assigned-by-dhcp.cox.net> <20070105193646.GC8753@spearce.org>
 <45A24CE6.5060201@shadowen.org> <7vd55pt3ts.fsf@assigned-by-dhcp.cox.net>
 <20070109033213.GC1904@spearce.org> <45A35D30.3070305@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 14:51:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4HOE-0000T0-Qi
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 14:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbXAINvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 08:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbXAINvk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 08:51:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:57111 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932088AbXAINvj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 08:51:39 -0500
Received: (qmail invoked by alias); 09 Jan 2007 13:51:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 09 Jan 2007 14:51:37 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <45A35D30.3070305@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36357>

Hi,

On Tue, 9 Jan 2007, Andreas Ericsson wrote:

> Shawn O. Pearce wrote:
> > 
> > Pushing into the current branch of a repository with a working 
> > directory probably shouldn't be allowed by default as users probably 
> > don't want to do that.
> 
> 
> I do this all the time. I develop on my laptop and send changes to a 
> testserver where I check out the revision I just pushed to the working 
> directory attached to it.

This is still possible. I also do it all the time. Only I do not update 
the _current_ branch, but a throwaway one.

> Since we can determine if there's a working directory or not, why not 
> just allow the fast-forward case if the working directory is clean and 
> update the working directory for the user?

Because maybe that user could be working on them right now?

The behaviour is safe as is.

Ciao,
Dscho
