From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] Add valgrind support in test scripts
Date: Sun, 25 Jan 2009 18:42:04 -0500
Message-ID: <20090125234204.GA19202@coredump.intra.peff.net>
References: <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de> <20090121215318.GA9107@sigill.intra.peff.net> <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901260014470.14855@racer> <alpine.DEB.1.00.0901260018340.14855@racer> <20090125232954.GC19099@coredump.intra.peff.net> <alpine.DEB.1.00.0901260034520.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREeI-0004BZ-0L
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbZAYXmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbZAYXmH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:42:07 -0500
Received: from peff.net ([208.65.91.99]:54357 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbZAYXmG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:42:06 -0500
Received: (qmail 29330 invoked by uid 107); 25 Jan 2009 23:42:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Jan 2009 18:42:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 18:42:04 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901260034520.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107136>

On Mon, Jan 26, 2009 at 12:35:31AM +0100, Johannes Schindelin wrote:

> > I actually kind of liked the original atomic version over the one with
> > locking. But I find this one acceptable.
> 
> The locking is only in there because of you...

I know it came out of our discussion, but I thought it was going a bit
far. That is, what should ideally be a little chunk of code to make some
links keeps getting more and more complex. And as your locking patch
came after my "OK, I guess this is fine" comments, I thought you
realized I was accepting it as-is.

So sorry to make you to go to extra work (and please don't go to extra
work ripping it out on my account -- I just wanted to make clear that I
decided your analysis was sane, and that I am OK with any of the
iterations you posted).

-Peff
