From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-rev-list --invert-match
Date: Fri, 21 Sep 2007 10:10:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709210904210.28395@racer.site>
References: <20070919202615.GK3076@jukie.net> <Pine.LNX.4.64.0709201132381.28395@racer.site>
 <20070920123849.GD12076@jukie.net> <Pine.LNX.4.64.0709201403540.28395@racer.site>
 <20070921041821.GA28245@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 11:11:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYeXf-00010G-K3
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 11:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbXIUJLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 05:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbXIUJLL
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 05:11:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:57997 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752551AbXIUJLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 05:11:09 -0400
Received: (qmail invoked by alias); 21 Sep 2007 09:11:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 21 Sep 2007 11:11:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JgEVTxsaJ4C7PIanoTRzgh/JeF799hcoVwFwv3V
	H+loVTltLg4Mex
X-X-Sender: gene099@racer.site
In-Reply-To: <20070921041821.GA28245@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58835>

Hi,

On Fri, 21 Sep 2007, Jeff King wrote:

> On Thu, Sep 20, 2007 at 02:12:54PM +0100, Johannes Schindelin wrote:
> 
> > Further, it probably makes sense to have the option to say _both_: "Find 
> > me a commit that contains Bart in one line, but not Simpson, and that 
> > does not contain the word "Sverdoolaege" at all."
> 
> This is perhaps a little hack-ish compared to better grep support in the
> core, but I find complex logic through command line options to be
> somewhat unreadable. I prefer something more Perl-ish like this:
> 
>   git-revgrep 'message =~ /bart/i
>                && message !~ /Simpson/
>                && author_name !~ /Sverdoolaege/'

Indeed, it has a certain elegance to it.  However, I cannot specify any 
rev-list options with your method, not even "--stat" or 
"--pretty=format:%H(%s)".

So while your script is a good interim solution, I'd like to see a 
generic grep support for this feature.

Ciao,
Dscho
