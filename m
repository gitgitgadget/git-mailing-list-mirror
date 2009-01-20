From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #04; Mon, 19)
Date: Mon, 19 Jan 2009 23:44:47 -0500
Message-ID: <20090120044447.GF30714@sigill.intra.peff.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 05:46:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP8VD-00039h-Hj
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 05:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbZATEox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 23:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754521AbZATEow
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 23:44:52 -0500
Received: from peff.net ([208.65.91.99]:58033 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445AbZATEow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 23:44:52 -0500
Received: (qmail 31507 invoked by uid 107); 20 Jan 2009 04:44:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 19 Jan 2009 23:44:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jan 2009 23:44:47 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106438>

On Mon, Jan 19, 2009 at 02:08:48PM +0100, Johannes Schindelin wrote:

> > * jk/valgrind (Thu Oct 23 04:30:45 2008 +0000) 2 commits
> >  . valgrind: ignore ldso errors
> >  . add valgrind support in test scripts
> 
> Could you put this in pu, at least, please?

I don't think I've really touched this since it was posted. One of the
things I didn't like about it was that the valgrind wrapper directory
was created in the Makefile. I think creating it inside the trash
directory for each test run that wants to use valgrind makes more sense
(probably as .git/valgrind, which is unlikely to hurt anything but will
stay out of the way of most of the tests).

I doubt I will have the chance to look at it anytime soon, so please
feel free to pick up the topic if you are interested.

-Peff
