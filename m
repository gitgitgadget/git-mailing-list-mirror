From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Thu, 26 Jul 2012 12:59:49 -0400
Message-ID: <20120726165949.GB13942@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <50092993.6010203@alum.mit.edu>
 <20120720154403.GB2862@sigill.intra.peff.net>
 <5009892E.9010808@kdbg.org>
 <20120720170913.GA14057@sigill.intra.peff.net>
 <CACsJy8BtcvuW2HKPSki7meyHMsvpLS0b8QG5M_083HEwy=-9EQ@mail.gmail.com>
 <10DD3DE0-E554-4BE3-A20B-FDBC73219646@gmail.com>
 <vpq8ve6qxui.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexey Muranov <alexey.muranov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 26 19:00:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuRPp-0002C1-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 18:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab2GZQ7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 12:59:52 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37358 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab2GZQ7v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 12:59:51 -0400
Received: (qmail 8830 invoked by uid 107); 26 Jul 2012 16:59:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 12:59:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 12:59:49 -0400
Content-Disposition: inline
In-Reply-To: <vpq8ve6qxui.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202277>

On Thu, Jul 26, 2012 at 06:41:09PM +0200, Matthieu Moy wrote:

> > How about simply deprecating "/" in branch name?
> 
> Err, it's not like nobody's using this feature (Junio does a heavy use
> of it in particular) ...

Not to mention git itself, as it splits up the refs/remotes hierarchy
into subdirectories. I think deprecating "/" is out of the question.

-Peff
