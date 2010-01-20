From: Jeff King <peff@peff.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 18:06:18 -0500
Message-ID: <20100120230618.GC25051@coredump.intra.peff.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <4B576F5C.2050102@drmicha.warpmail.net>
 <7veilk1o3s.fsf@alter.siamese.dyndns.org>
 <7v3a201lpz.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001202354070.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Joey Hess <joey@kitenet.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 21 00:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXjdI-0006Pq-WC
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 00:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab0ATXG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 18:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348Ab0ATXGY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 18:06:24 -0500
Received: from peff.net ([208.65.91.99]:39643 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986Ab0ATXGW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 18:06:22 -0500
Received: (qmail 10815 invoked by uid 107); 20 Jan 2010 23:11:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 20 Jan 2010 18:11:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jan 2010 18:06:18 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1001202354070.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137599>

On Wed, Jan 20, 2010 at 11:58:07PM +0100, Johannes Schindelin wrote:

> I would agree with Peff about the mention of --pretty disabling notes 
> (unless asked for by a user format) in the commit notes as well as in the 
> pretty options, but I fully disagree on the need for tests.  We should not 
> have a thorough test suite that runs for days on end, but we should 
> concentrate on things that are more likely to get broken.  And the added 
> code is just too obvious for that.

Sure, we don't have to go all out. But I think there is some confusion
right now about just what behavior we _should_ have, so I think
documenting it in the form of tests is reasonable.

-Peff
