From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 1/4] Simplify wildcards for match files to be ignored
Date: Fri, 17 Mar 2006 18:19:42 +0100
Message-ID: <20060317171942.GA12716@diku.dk>
References: <20060310144308.GB7920@diku.dk> <200603110008.k2B08aCO004834@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 17 18:20:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKIcG-0000Kb-F0
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 18:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWCQRTx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 12:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWCQRTx
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 12:19:53 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:17813 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1030214AbWCQRTw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 12:19:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 27E2C770083;
	Fri, 17 Mar 2006 18:19:51 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24358-01; Fri, 17 Mar 2006 18:19:49 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id A145377007A;
	Fri, 17 Mar 2006 18:19:42 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 51F7D6DFDB0; Fri, 17 Mar 2006 18:18:09 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 6A1B961E6D; Fri, 17 Mar 2006 18:19:42 +0100 (CET)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200603110008.k2B08aCO004834@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17667>

Horst von Brand <vonbrand@inf.utfsm.cl> wrote Fri, Mar 10, 2006:
> Jonas Fonseca <fonseca@diku.dk> wrote:
> > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> > 
> > ---
> > 
> >  Documentation/Makefile |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 3aad2fb..661c259 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -1,4 +1,4 @@
> > -CG_IGNORE=$(wildcard ../cg-X* ../cg-*.orig ../cg-*.rej ../cg-*.in)
> > +CG_IGNORE=$(wildcard ../cg-X* ../cg-*.*)
> 
> Nope. Better be specific in what you delete. It is not exactly
> performance-critical...

The intention was to ignore also cg-*.patch, but then ignoring any file
with a dot in makes sense and avoids a lot more errors when building
documentation in a dirty tree.

-- 
Jonas Fonseca
