From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] stash: end commit log with a newline
Date: Tue, 3 Jul 2007 12:29:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031228460.4071@racer.site>
References: <20070703085906.GA4963@lala>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 13:29:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5gZq-0000Cq-Pu
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 13:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757671AbXGCL3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 07:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757524AbXGCL3s
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 07:29:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:47120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757460AbXGCL3s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 07:29:48 -0400
Received: (qmail invoked by alias); 03 Jul 2007 11:29:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 03 Jul 2007 13:29:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Pm6cOkSzP/+vfMYYieChpeOeuNE4icCaVncA9bi
	rPpyjkJeLpaSMs
X-X-Sender: gene099@racer.site
In-Reply-To: <20070703085906.GA4963@lala>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51476>

Hi,

On Tue, 3 Jul 2007, Uwe Kleine-K?nig wrote:

> -	w_commit=$(printf 'WIP on %s' "$msg" |
> +	w_commit=$(printf 'WIP on %s\n' "$msg" |

Why not

	w_commit=$(echo "WIP on $msg" |

Hmm? It is shorter and more to the point. IMHO it is also more common.

Ciao,
Dscho
