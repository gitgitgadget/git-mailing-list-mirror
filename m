From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [NEW REPLACEMENT PATCH] git-checkout: Add a test case for relative
 paths use.
Date: Thu, 8 Nov 2007 23:04:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711082304310.4362@racer.site>
References: <11945276321726-git-send-email-dsymonds@gmail.com>
 <Pine.LNX.4.64.0711081427450.4362@racer.site> <7v7iks31lm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 00:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqGsh-00081H-Jj
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 00:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399AbXKHXM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 18:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761348AbXKHXM0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 18:12:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:54728 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758374AbXKHXMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 18:12:25 -0500
Received: (qmail invoked by alias); 08 Nov 2007 23:05:00 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp021) with SMTP; 09 Nov 2007 00:05:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lJLhlq9llLLccICQXFVvcRXGp1ogLVeOwRuyilk
	n9sONG0rtLpjLs
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7iks31lm.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64085>

Hi,

On Thu, 8 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> +	mkdir dir2 &&
> >> +	echo bonjour > dir2/file2 &&
> >> +	git add dir2/file2 &&
> >> +	git commit -m "populate tree"
> >> +
> >> +'
> >
> > Please lose the empty line before the closing quote.  (This applies to all 
> > tests.)
> 
> I personaly find the extra blank lines before and after the
> indented test body easier to read. 

Personally, I don't.  But you are the maintainer.

Ciao,
Dscho
