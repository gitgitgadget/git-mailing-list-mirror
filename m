From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Wed, 18 Feb 2009 19:46:33 -0500
Message-ID: <20090219004633.GC25808@coredump.intra.peff.net>
References: <e2b179460902170129s7ae613cehe237619be5e84936@mail.gmail.com> <20090217163413.GB31297@sigill.intra.peff.net> <e2b179460902171000s605675dct1f499a9425c3ebb2@mail.gmail.com> <20090217202731.GA16586@coredump.intra.peff.net> <20090218064121.GA16611@coredump.intra.peff.net> <alpine.DEB.1.00.0902181113210.6274@intel-tinevez-2-302> <20090218101615.GA23035@coredump.intra.peff.net> <alpine.DEB.1.00.0902181251160.6274@intel-tinevez-2-302> <20090219003727.GA25808@coredump.intra.peff.net> <alpine.DEB.1.00.0902190142440.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 01:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZx5A-0002PF-Ra
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 01:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbZBSAqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 19:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbZBSAqg
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 19:46:36 -0500
Received: from peff.net ([208.65.91.99]:59222 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbZBSAqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 19:46:35 -0500
Received: (qmail 18173 invoked by uid 107); 19 Feb 2009 00:46:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 19:46:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 19:46:33 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902190142440.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110599>

On Thu, Feb 19, 2009 at 01:46:28AM +0100, Johannes Schindelin wrote:

> Even if they were in POSIX, I'd suggest not to change the constructs.  
> rebase is _bound_ to be built in.
> 
> Even if Stephan is not a fan of my recent changes to rebase -i -p (which I 
> will present on this list once they all work as I want them to), I think I 
> can talk him into continuing the sequencer effort: he was not discussing 
> the design in the open, so he should have expected the process to be 
> dragged out.

Having a sequencer in C would make me even happier. ;)

-Peff
