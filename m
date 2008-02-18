From: Jeff King <peff@peff.net>
Subject: Re: What's in git.git (stable)
Date: Sun, 17 Feb 2008 20:43:01 -0500
Message-ID: <20080218014301.GA6642@sigill.intra.peff.net>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org> <7vd4r24ox6.fsf@gitster.siamese.dyndns.org> <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org> <m3d4qvbt40.fsf@localhost.localdomain> <7vtzk7xqg3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802172050090.30505@racer.site> <7v3arrxd7q.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802180133150.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 02:43:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQv2k-0003Lo-No
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 02:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbYBRBnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 20:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYBRBnG
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 20:43:06 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2840 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbYBRBnF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 20:43:05 -0500
Received: (qmail 5642 invoked by uid 111); 18 Feb 2008 01:43:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 17 Feb 2008 20:43:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Feb 2008 20:43:01 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802180133150.30505@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74215>

On Mon, Feb 18, 2008 at 01:34:50AM +0000, Johannes Schindelin wrote:

> Well, my workflow has lots of these moments.  I do not even feel "oops" 
> about it.  More like "by the way, this needs committing _now_".
> 
> So I guess I'll be the guinea pig for this patch, and if it is too 
> painful, I'll just go and fix it.

Just to be clear, this patch discards the cache after preparing the
partial index but before doing the status. This is in contrast to the
current 'master' and v1.5.4, which discard the cache _three_ times
during the status process.

So no, the performance will probably not be a big deal. It is better
than it has been in any released version of git.

-Peff
