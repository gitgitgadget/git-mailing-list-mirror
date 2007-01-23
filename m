From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: code movements in diffs, was Re: [PATCH 2/2] Allow fetch-pack to
 decide keeping the fetched pack without exploding
Date: Tue, 23 Jan 2007 12:07:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231205110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <ep4phb$fef$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 12:07:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9JVG-0007V7-B1
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 12:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbXAWLHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 06:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932958AbXAWLHr
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 06:07:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:42480 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932964AbXAWLHr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 06:07:47 -0500
Received: (qmail invoked by alias); 23 Jan 2007 11:07:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 23 Jan 2007 12:07:45 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ep4phb$fef$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37498>

Hi,

On Tue, 23 Jan 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > P.S.: These patches make me dream of yet another diff format enhancement: 
> > code moves! Of course, for this to be really usable, you'd also have to 
> > automatically determine indent changes... You may say I'm a dreamer. But 
> > I'm not the only one...
> 
> I wonder if it could be done with e.g.
> 
> --- a/fromfile
> +++ b/somefile
> <code movement or copying>
> 
> --- a/somefile
> +++ b/somefile
> <other changes>
> 
> The problem is that context differs usually for code movement.

There is a more fundamental problem here: both "diff" and "patch" walk the 
file pair in a direction. The whole "code movement" stuff would break this 
paradigm. What you found is just _one_ consequence.

But as I said: a man can still dream, can't he?

Ciao,
Dscho
