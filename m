From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: fix interrupted squashing
Date: Fri, 27 Jul 2007 20:35:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707272032480.14781@racer.site>
References: <20070723225402.GB22513@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0707240005240.14781@racer.site> <20070724200510.GA27610@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0707242139370.14781@racer.site> <Pine.LNX.4.64.0707271817100.14781@racer.site>
 <7v1wet1wmw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 21:35:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVbO-0002fS-6k
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763265AbXG0Tfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762571AbXG0Tfv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:35:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:33297 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760952AbXG0Tfu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:35:50 -0400
Received: (qmail invoked by alias); 27 Jul 2007 19:35:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 27 Jul 2007 21:35:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19W0jNAuD9W2oU+LyuDRVbgiT99BwXbjzLifJo+gk
	vC/O06skZh5fYv
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wet1wmw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53956>

Hi,

On Fri, 27 Jul 2007, Junio C Hamano wrote:

> Thanks for reminding.
> 
> I thought I read the patch, felt satisfied and already applied,
> but obviously I forgot the last step.  Anything else that should
> be in 1.5.3 I forgot?

I'll try to fix that unpack bug I talked about lately, and I'd like to get 
in a little bit saner filter-branch.  One where you can read in the 
documentation "pruning paths without --subdirectory-filter is not yet 
supported, and likewise pruning by --grep".

I guess the proper fix would be to build a rev-list command line leaving 
out all the parameters which can prune the commits that the passed refs 
point to, but that is probably a little painful, to say the least.

> BTW, I _think_ somebody between your brain and my mbox mangled
> umlaut in Uwe's name.  I'll fix it up.

Thanks.

Ciao,
Dscho
