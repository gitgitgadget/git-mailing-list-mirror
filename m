From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 05:13:04 -0400
Message-ID: <20080613091304.GC4474@sigill.intra.peff.net>
References: <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org> <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com> <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 11:14:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K75MB-0007UP-IW
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 11:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbYFMJNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 05:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbYFMJNI
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 05:13:08 -0400
Received: from peff.net ([208.65.91.99]:2558 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227AbYFMJNH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 05:13:07 -0400
Received: (qmail 9008 invoked by uid 111); 13 Jun 2008 09:13:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 05:13:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 05:13:04 -0400
Content-Disposition: inline
In-Reply-To: <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84856>

On Fri, Jun 13, 2008 at 10:43:59AM +0200, Wincent Colaiuta wrote:

> While this may be true for codebases which move forward quickly, what  
> about one which is basically finished and tends not to get touched in a 
> long time. A situation arises, you stash something, the phone rings, and 
> for whatever reason the stash gets forgotten and you don't revisit the 
> project at all for days, weeks, months. It wouldn't be nice to eventually 
> come back and discover that your in-progress work had been "garbage" 
> collected for you.

I think this argues more for increasing the expiration period on
reflogs, if your project moves very slowly.

-Peff
