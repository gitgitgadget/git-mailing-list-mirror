From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git log filtering
Date: Fri, 9 Feb 2007 14:13:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702091410230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
 <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org>
 <20070208061654.GA8813@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702081905570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070208223336.GA9422@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702090115180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070209015925.GD10574@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 14:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFVZ6-0005WO-Px
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 14:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946437AbXBINNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 08:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946444AbXBINNV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 08:13:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:54639 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946437AbXBINNU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 08:13:20 -0500
Received: (qmail invoked by alias); 09 Feb 2007 13:13:18 -0000
X-Provags-ID: V01U2FsdGVkX18MDscEpYwMgt1I4hsUBgAgr+Kg9EmMa5Tt8XmvEp
	ZJ1w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070209015925.GD10574@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39178>

Hi,

On Thu, 8 Feb 2007, Jeff King wrote:

> On Fri, Feb 09, 2007 at 01:18:01AM +0100, Johannes Schindelin wrote:
> 
> > Yes, I do. Not because of the extra lines, but because of the inconsistent 
> > interface.
> 
> OK, so we may either:
>   1. always use the lowest common denominator (i.e., no pcre support)
>   2. force a dependency for new features (i.e., require pcre)
>   3. have inconsistency between builds (i.e., conditional dependency)
>   4. include all dependencies, or re-write them natively
> 
> I agree that 4 can make some sense in limited situations, but I worry
> that it will eventually cease to be scalable (we don't get improvements
> or bugfixes automatically from other packages, we potentially re-invent
> the wheel). We already have '3' for other things: openssl, curl, expat,
> even perl.

The difference, of course, is that with the "other things", we either have 
no alternative (if you do not have curl, you cannot use HTTP transport), 
or we have workalikes (if you don't use openssl, the (possibly slower) 
SHA1 replacements take effect).

We _used_ to rely on external "diff" and "merge", but have them as inbuilt 
components, exactly to avoid "if you have a slightly differing setup, 
git behaves differently".

Ciao,
Dscho
