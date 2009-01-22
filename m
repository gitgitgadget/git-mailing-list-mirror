From: Jeff King <peff@peff.net>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
	#04; Mon, 19)
Date: Thu, 22 Jan 2009 00:39:35 -0500
Message-ID: <20090122053935.GA15762@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <7vr62wb28h.fsf@gitster.siamese.dyndns.org> <20090122005901.GA10826@sigill.intra.peff.net> <alpine.DEB.1.00.0901220601500.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 06:41:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPsJL-0002sD-Q1
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 06:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbZAVFjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 00:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbZAVFjj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 00:39:39 -0500
Received: from peff.net ([208.65.91.99]:47322 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbZAVFjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 00:39:39 -0500
Received: (qmail 24262 invoked by uid 107); 22 Jan 2009 05:39:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 22 Jan 2009 00:39:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2009 00:39:35 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901220601500.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106723>

On Thu, Jan 22, 2009 at 06:02:51AM +0100, Johannes Schindelin wrote:

> I _suspect_ that the svn tests already use different ports (or can work 
> with the same httpd), as I have subversion installed and run with -j50 
> regularly.

I think you're just not running them; it looks like they bail if
SVN_HTTPD_PORT isn't set by the user.

-Peff
