From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 17:32:05 -0500
Message-ID: <20090123223205.GA11491@coredump.intra.peff.net>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com> <7vwscm4xx0.fsf@gitster.siamese.dyndns.org> <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com> <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de> <bd6139dc0901221847u6b8aeadcl580a091751de3d26@mail.gmail.com> <alpine.DEB.1.00.0901230419080.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:33:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQUak-0005uM-Gl
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 23:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758649AbZAWWcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 17:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758295AbZAWWcI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 17:32:08 -0500
Received: from peff.net ([208.65.91.99]:33744 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758218AbZAWWcH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 17:32:07 -0500
Received: (qmail 12025 invoked by uid 107); 23 Jan 2009 22:32:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 23 Jan 2009 17:32:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jan 2009 17:32:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901230419080.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106924>

On Fri, Jan 23, 2009 at 04:20:34AM +0100, Johannes Schindelin wrote:

> Probably.  Note, however, that scripts might rely on a fail if there were 
> problems.
> 
> But then, scripts have no business cloning repositories (fetching, yes.  
> But cloning?)

Really? I have scripts that call clone (usually followed by building the
result). Are you proposing that all scripts should "git init && git
remote add && git fetch"?

So I am strongly in favor of telling the difference between failure and
emptiness.

-Peff
