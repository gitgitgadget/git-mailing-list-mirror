From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Mon, 26 Jan 2009 11:54:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901261152320.14855@racer>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu>
 <20090126031206.GB14277@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 11:55:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRP7r-00006W-Fh
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 11:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbZAZKx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 05:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbZAZKx6
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 05:53:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:59352 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751273AbZAZKx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 05:53:57 -0500
Received: (qmail invoked by alias); 26 Jan 2009 10:53:55 -0000
Received: from pD9EB294D.dip0.t-ipconnect.de (EHLO noname) [217.235.41.77]
  by mail.gmx.net (mp071) with SMTP; 26 Jan 2009 11:53:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fpTQRPpnfta1mjyHefe0rhkadPL+ZXdLzcLaQ7K
	XnjFe9XNVW9r4F
X-X-Sender: gene099@racer
In-Reply-To: <20090126031206.GB14277@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107185>

Hi,

On Sun, 25 Jan 2009, Jeff King wrote:

> So if you just want this from the command line, then I think it is safe 
> to have "git diff" always respect "diff.primer", and scripts shouldn't 
> be impacted.

But as Keith made clear, he wanted to use it from _git-gui_.  Which 
-- naturally -- _has_ to use plumbing, to guarantee a stable interface.

So "fixing" this in "git diff" is the wrong place; anything else than 
teaching "git gui" to remember user-defined diff options and to use them 
would be a complicator's glove.

Ciao,
Dscho
