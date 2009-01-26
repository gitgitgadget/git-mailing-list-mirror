From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] valgrind: ignore ldso and more libz errors
Date: Mon, 26 Jan 2009 01:02:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260101030.14855@racer>
References: <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de> <20090121215318.GA9107@sigill.intra.peff.net> <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901260014470.14855@racer> <alpine.DEB.1.00.0901260019000.14855@racer>
 <20090125233243.GD19099@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 01:03:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREwq-00008d-27
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 01:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbZAZAB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 19:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbZAZABz
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 19:01:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:44023 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750797AbZAZABy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 19:01:54 -0500
Received: (qmail invoked by alias); 26 Jan 2009 00:01:52 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp004) with SMTP; 26 Jan 2009 01:01:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18x1gVBD5gxJitVHQEe6vq1w8zW0WWJWeIg24MRhU
	06CVVHrUPCgeYt
X-X-Sender: gene099@racer
In-Reply-To: <20090125233243.GD19099@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107143>

Hi,

On Sun, 25 Jan 2009, Jeff King wrote:

> On Mon, Jan 26, 2009 at 12:19:12AM +0100, Johannes Schindelin wrote:
> 
> > On some Linux systems, we get a host of Cond and Addr errors from 
> > calls to dlopen that are caused by nss modules. We should be able to 
> > safely ignore anything happening in ld-*.so as "not our problem."
> > 
> > [Johannes: I added some more...]
> > 
> > Signed-off-by: Jeff King <peff@peff.net>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Your 0/3 cover letter lists this me as the author of this patch, but 
> there is no "From:" line at the top of this email. I don't particularly 
> care one way or the other for this patch, but I wanted to point it out 
> as a potential issue with your patch-sending workflow.

Yep, sorry.  I would not touch send-email with lead-protected gloves, so 
what I do is to edit all patches I send.  And in this case, I missed the 
fact that there was another "From:".  I am sorry.

Ciao,
Dscho "who is burning midnight oil again"
