From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git log filtering
Date: Fri, 9 Feb 2007 01:45:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702090144310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
 <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org>
 <20070208061654.GA8813@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702081905570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070208223336.GA9422@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702090115180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070209002344.GF1556@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 01:45:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJt8-0005wb-J5
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 01:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422976AbXBIApP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 19:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423156AbXBIApP
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 19:45:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:32906 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422976AbXBIApN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 19:45:13 -0500
Received: (qmail invoked by alias); 09 Feb 2007 00:45:12 -0000
X-Provags-ID: V01U2FsdGVkX1/PVx4B12zPY/jGVaIeaHj+Gaq/l9efEcxvx6iaY0
	f5vg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070209002344.GF1556@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39143>

Hi,

On Thu, 8 Feb 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > We included libxdiff _exactly_ to ensure consistency between different 
> > git installations (remember, diff behaves quite differently on 
> > different platforms, and even GNU diff behaves differently depending 
> > on which version you use).
> 
> pcre is covered by the BSD license.  Can we ship it with git, like we 
> ship libxdiff?  I want to say Apache ships with pcre, but they use the 
> Apache License so it might be easier for them to do so.

If we bundle it like we do with libxdiff, I do not have any objections. It 
would also help MinGW.

Ciao,
Dscho
