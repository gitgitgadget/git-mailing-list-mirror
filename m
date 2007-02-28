From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Broken dependencies..
Date: Wed, 28 Feb 2007 16:00:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702281600280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0702271543080.12485@woody.linux-foundation.org>
 <200702280900.22982.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 16:01:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQIf-0005NS-B0
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbXB1PA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbXB1PA7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:00:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:40805 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932484AbXB1PA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:00:58 -0500
Received: (qmail invoked by alias); 28 Feb 2007 15:00:57 -0000
X-Provags-ID: V01U2FsdGVkX1/Ycyxi3I3Y92q13bO/F49WGOu4mkwP1iZjAEnYTG
	7SnA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702280900.22982.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40931>

Hi,

On Wed, 28 Feb 2007, Andy Parkins wrote:

> On Tuesday 2007 February 27 23:46, Linus Torvalds wrote:
> 
> > doing proper dependencies, but I'm too lazy to fix it. Any ideas on 
> > how to generate real dependency data so that we don't have these kinds 
> > of things (I bet there are other files than just fetch.c that lack the 
> > full header file dependencies, this one just happened to trigger now)?
> 
> Would gcc's "-MM" help?  I think qmake uses them when it's generating 
> Makefiles.

Would that play nicely with Sun' CC some people seem to use to compile 
Git?

Ciao,
Dscho
