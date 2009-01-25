From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Valgrind support: check for more than just
	programming errors
Date: Sun, 25 Jan 2009 18:42:49 -0500
Message-ID: <20090125234249.GE19099@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de> <20090121215318.GA9107@sigill.intra.peff.net> <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901260014470.14855@racer> <alpine.DEB.1.00.0901260019160.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREeI-0004BZ-OI
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbZAYXmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbZAYXmw
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:42:52 -0500
Received: from peff.net ([208.65.91.99]:60334 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbZAYXmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:42:52 -0500
Received: (qmail 29359 invoked by uid 107); 25 Jan 2009 23:42:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Jan 2009 18:42:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 18:42:49 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901260019160.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107135>

On Mon, Jan 26, 2009 at 12:20:21AM +0100, Johannes Schindelin wrote:

> While it is not strictly necessary to look through the whole PATH to
> find git binaries to override, it is in line with running an expensive
> test (which valgrind is) to make extra sure that no binary is tested
> that actually comes from the git.git checkout.

Should this be "...no binary is tested that _doesn't_ actually come from
the git.git checkout"?

-Peff
