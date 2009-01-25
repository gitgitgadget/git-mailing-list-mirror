From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] valgrind: ignore ldso and more libz errors
Date: Sun, 25 Jan 2009 18:32:43 -0500
Message-ID: <20090125233243.GD19099@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de> <20090121215318.GA9107@sigill.intra.peff.net> <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901260014470.14855@racer> <alpine.DEB.1.00.0901260019000.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:34:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREUT-0001rV-Lq
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbZAYXcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbZAYXcp
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:32:45 -0500
Received: from peff.net ([208.65.91.99]:49211 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbZAYXcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:32:45 -0500
Received: (qmail 29257 invoked by uid 107); 25 Jan 2009 23:32:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Jan 2009 18:32:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 18:32:43 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901260019000.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107133>

On Mon, Jan 26, 2009 at 12:19:12AM +0100, Johannes Schindelin wrote:

> 
> On some Linux systems, we get a host of Cond and Addr errors
> from calls to dlopen that are caused by nss modules. We
> should be able to safely ignore anything happening in
> ld-*.so as "not our problem."
> 
> [Johannes: I added some more...]
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Your 0/3 cover letter lists this me as the author of this patch, but
there is no "From:" line at the top of this email. I don't particularly
care one way or the other for this patch, but I wanted to point it out
as a potential issue with your patch-sending workflow.

-Peff
