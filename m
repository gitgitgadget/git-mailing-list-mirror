From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Tue, 18 Dec 2007 06:11:36 -0500
Message-ID: <20071218111136.GA6266@coredump.intra.peff.net>
References: <20071215004230.GF7300@mail.oracle.com> <alpine.LFD.0.999999.0712142114400.8467@xanadu.home> <20071217200920.GB19816@mail.oracle.com> <alpine.LFD.0.999999.0712171517320.8467@xanadu.home> <7v3au16myj.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712171641460.8467@xanadu.home> <7vbq8o4yxc.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712172212110.8467@xanadu.home> <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com> <7vlk7s38aq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Nicolas Pitre <nico@cam.org>,
	Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 12:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4aMs-0005c1-M8
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 12:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbXLRLLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 06:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbXLRLLj
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 06:11:39 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4528 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517AbXLRLLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 06:11:39 -0500
Received: (qmail 18582 invoked by uid 111); 18 Dec 2007 11:11:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 18 Dec 2007 06:11:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2007 06:11:36 -0500
Content-Disposition: inline
In-Reply-To: <7vlk7s38aq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68730>

On Mon, Dec 17, 2007 at 09:01:49PM -0800, Junio C Hamano wrote:

> There indeed are handful scheduled removals.  I do not mind declaring
> that 1.6.0 comes after 1.5.4, or just relabel the removal schedule for
> 1.6.0 and keep the scheduled change on hold a bit longer.

I can think of two other user-visible changes which have been discussed
that might warrant such a version bump:
  - option parsing tweaks (hopefully these should be minor, but it is
    clear that we cannot be 100% consistent while retaining the
    identical previous behavior)
  - moving dashed forms out of paths

-Peff
