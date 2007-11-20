From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: quilt/0.46-1 misbehaviour...
Date: Wed, 21 Nov 2007 01:54:58 +0200
Message-ID: <20071120235458.GT6372@mea-ext.zmailer.org>
References: <20071120055149.GQ6372@mea-ext.zmailer.org> <20071120183402.GC3461@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 00:55:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IucwX-0000GE-M1
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 00:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763943AbXKTXzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 18:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756275AbXKTXzG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 18:55:06 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:33462 "EHLO z2.cat.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762357AbXKTXzE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 18:55:04 -0500
Received: (mea@mea-ext) by mail.zmailer.org id S3540317AbXKTXy6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 01:54:58 +0200
Content-Disposition: inline
In-Reply-To: <20071120183402.GC3461@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65581>

On Tue, Nov 20, 2007 at 07:34:02PM +0100, Alex Riesen wrote:
> Matti Aarnio, Tue, Nov 20, 2007 06:51:49 +0100:
> > .. or perhaps Exim, but odd result in arriving and thus outgoing headers anyway.
> >
> ...
> > Diagnostic-Code: smtp; 554 (Reject, id=10432-16 - BAD_HEADER: Duplicate header field: "From")
> > 
> > From:	clameter@sgi.com
> > From:	Christoph Lameter <clameter@sgi.com>
> > To:	ak@suse.de
> > Cc:	akpm@linux-foundation.org
> > Cc:	travis@sgi.com
> > Cc:	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> > Cc:	linux-kernel@vger.kernel.org
> ...
> > Remote-MTA: dns; cartero.cs.tu-berlin.de (130.149.17.20|25|209.132.176.167|39031)
> > Last-Attempt-Date: Mon, 19 Nov 2007 20:17:31 -0500
> > Diagnostic-Code: smtp; 554 (Reject, id=10432-16 - BAD_HEADER: Duplicate header field: "From")
> ...
> > Date: Mon, 19 Nov 2007 17:11:41 -0800
> > Subject: [rfc 09/45] cpu alloc: IA64 support
> > From: clameter@sgi.com
> > From: Christoph Lameter <clameter@sgi.com>
> > Message-Id: <20071120011333.850453474@sgi.com>
> 
> Is this the problem: duplicate From: and quadriplicate Cc:?

That kind of header multiples are are triggering spam filters all over the place,
because spammers used to use such tricks as recently as 2 years ago.

Duplicate "From:" is plain simply broken, multiple "Cc:" is just questionable..

git-tools should not produce such.

  /Matti Aarnio
