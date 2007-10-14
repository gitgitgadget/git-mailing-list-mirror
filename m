From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add color to git-add--interactive diffs (Take 2: now
 without spurious line break!)
Date: Sun, 14 Oct 2007 18:15:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141814100.25221@racer.site>
References: <1192351494.7226.18.camel@athena> <EFADE863-FC59-4A50-B165-9D30D9648B97@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tom Tobin <korpios@korpios.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 19:16:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih740-0000Tl-5I
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 19:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbXJNRPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 13:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755080AbXJNRPa
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 13:15:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:60515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753556AbXJNRPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 13:15:30 -0400
Received: (qmail invoked by alias); 14 Oct 2007 17:15:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 14 Oct 2007 19:15:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vUFQuTwqvxF1y8RaPT/dZ6KBevEanI+HfD3Or60
	G7l7n5KS/mHSih
X-X-Sender: gene099@racer.site
In-Reply-To: <EFADE863-FC59-4A50-B165-9D30D9648B97@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60875>

Hi,

On Sun, 14 Oct 2007, Wincent Colaiuta wrote:

> > +sub parse_color {
> 
> You could simplify the manual escape sequence construction that you're 
> doing here by using Term::ANSIColor like the other patches did. I see 
> that git-send-email.perl uses that module too, so I guess depending on 
> that module is ok.

Wrong.  Depending on that module is not correct, you always have to wrap 
it into an "if (<is_color>) {...}".

I use git add -i quite often, and I _never_ use git send-email.  My guess 
is that I am not alone with that.

Ciao,
Dscho
