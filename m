From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach diff machinery to display other prefixes than "a/"
 and "b/"
Date: Tue, 18 Dec 2007 16:58:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181654410.23902@racer.site>
References: <1197992574-3464-1-git-send-email-pascal@obry.net>
 <Pine.LNX.4.64.0712181619550.23902@racer.site> <4767F935.8060207@obry.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:58:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4fmQ-00089B-EK
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbXLRQ6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 11:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754711AbXLRQ6X
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:58:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:54239 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754157AbXLRQ6X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 11:58:23 -0500
Received: (qmail invoked by alias); 18 Dec 2007 16:58:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 18 Dec 2007 17:58:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181MjxC+8I1omqVmNFmvVA9s/xlF4/h4KlGPVv7MS
	Gk8PYhKc0sG84y
X-X-Sender: gene099@racer.site
In-Reply-To: <4767F935.8060207@obry.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68782>

Hi,

On Tue, 18 Dec 2007, Pascal Obry wrote:

> Johannes Schindelin a ?crit :
> > With the new option "--prefix=<prefix1>[:<prefix2>]" you can change 
> > the shown prefix, or suppress it (by specifying the empty string).
> 
> Why not ? But do you have a motivation for this change ? I mean why 
> would you want to use a completely different prefix ?

I vaguely remember that somebody once asked for something a la GNU patch's 
-B option.

Besides, why restrict ourselves?  I mean, really, my patch only adds 6/4 
added/removed lines relative to your patch (part of which stems from the 
fact that I did not forget the "diff --git" line).  Why not take the added 
value virtually for free?

Ciao,
Dscho
