From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git log filtering
Date: Fri, 9 Feb 2007 01:18:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702090115180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
 <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org>
 <20070208061654.GA8813@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702081905570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070208223336.GA9422@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 01:18:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJSt-0000kc-JC
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 01:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422767AbXBIASG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 19:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbXBIASG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 19:18:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:44884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965596AbXBIASD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 19:18:03 -0500
Received: (qmail invoked by alias); 09 Feb 2007 00:18:01 -0000
X-Provags-ID: V01U2FsdGVkX1+6gkYarCe6whOwuZi5MlYernLvB9z7rIYC+NUEbD
	1T8g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070208223336.GA9422@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39136>

Hi,

On Thu, 8 Feb 2007, Jeff King wrote:

> On Thu, Feb 08, 2007 at 07:06:25PM +0100, Johannes Schindelin wrote:
> 
> > May I register a complaint? This is yet _another_ dependency.
> 
> Unlike other dependencies, I think it's quite natural to make it a
> conditional dependency. If you have pcre, you get more featureful
> regular expressions. If you don't, you get posix regular expressions.
> Do you object to a few extra lines in the Makefile?

Yes, I do. Not because of the extra lines, but because of the inconsistent 
interface.

We included libxdiff _exactly_ to ensure consistency between different git 
installations (remember, diff behaves quite differently on different 
platforms, and even GNU diff behaves differently depending on which 
version you use).

So no, I do not like the idea of using git on some random box, only to 
realize that what I have grown used to does not work.

Ciao,
Dscho
