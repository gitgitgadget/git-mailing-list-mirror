From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] rebase -i --root: simplify code
Date: Mon, 26 Jan 2009 01:44:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260143540.14855@racer>
References: <alpine.DEB.1.00.0901260029480.14855@racer> <alpine.DEB.1.00.0901260031460.14855@racer> <200901260049.25563.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 26 01:45:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRFbD-0007hA-3F
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 01:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbZAZAnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 19:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbZAZAnq
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 19:43:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:47400 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750947AbZAZAnp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 19:43:45 -0500
Received: (qmail invoked by alias); 26 Jan 2009 00:43:43 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp060) with SMTP; 26 Jan 2009 01:43:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/d7lCaot/d0i0G9lz1GMhm0UeVtIG8C+paemfg3
	Jv9zsrkY2jie+g
X-X-Sender: gene099@racer
In-Reply-To: <200901260049.25563.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107149>

Hi,

On Mon, 26 Jan 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > 
> > When we rebase with --root, what we are actually picking are the commits
> > in $ONTO..$HEAD.  So $ONTO is really our $UPSTREAM.  Spell it out.
> [...]
> > +			UPSTREAM=$ONTO
> 
> While I think the simplification is reasonable, it breaks this check:
> 
>   get_saved_options () {
>   # ...
>           test ! -s "$DOTEST"/upstream && REBASE_ROOT=t
>   }
> 
> So you'll have to change that too.

Will fix tomorrow.

Thanks,
Dscho
