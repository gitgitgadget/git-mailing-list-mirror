From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not run git-pack-refs by default for now from git-gc
Date: Tue, 13 Feb 2007 11:55:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131151520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7ium1k7s.fsf@assigned-by-dhcp.cox.net> <7vzm7iz8uv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702131101400.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070213102951.GA14903@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 11:56:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGvKT-0004Vp-C3
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 11:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbXBMK4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 05:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXBMK4F
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 05:56:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:55424 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750994AbXBMK4E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 05:56:04 -0500
Received: (qmail invoked by alias); 13 Feb 2007 10:56:01 -0000
X-Provags-ID: V01U2FsdGVkX19+nWgD1D5+RWRyaCpQXULTj4c53wuaEotSyO6tAl
	Wj+A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070213102951.GA14903@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39514>

Hi,

On Tue, 13 Feb 2007, Jeff King wrote:

> On Tue, Feb 13, 2007 at 11:03:32AM +0100, Johannes Schindelin wrote:
> 
> > It seems to me that the reason are dumb transports, which are very 
> > likely to run only from bare repositories. How about checking for a 
> > bare repository explicitely, and only if it _is_ bare, check for 
> > gc.packrefs, too?
> 
> The way you have stated it, I think we will get a lot of "I set 
> gc.packrefs, but it doesn't do anything!" complaints. I think a 
> tri-state "yes/no/notbare" defaulting to "notbare" makes more sense. But 
> maybe you meant the other way around in the first place.

No, I meant it as you understood it. But your solution is evidently way 
more elegant.

Ciao,
Dscho
