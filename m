From: Jeff King <peff@peff.net>
Subject: Re: [RFC] require-work-tree wants more than what its name says
Date: Wed, 4 May 2011 17:28:48 -0400
Message-ID: <20110504212848.GA27779@sigill.intra.peff.net>
References: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
 <20110504073850.GA8512@sigill.intra.peff.net>
 <7vliymfp4t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:29:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHjcw-0003VT-5q
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 23:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab1EDV2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 17:28:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40681
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab1EDV2v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 17:28:51 -0400
Received: (qmail 22416 invoked by uid 107); 4 May 2011 21:30:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 May 2011 17:30:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2011 17:28:48 -0400
Content-Disposition: inline
In-Reply-To: <7vliymfp4t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172769>

On Wed, May 04, 2011 at 08:42:58AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... but I worry about compatibility. We can audit our in-tree scripts,
> > but git-sh-setup is part of the recommended API for external scripts,
> > no?
> 
> I am Ok with renaming the thing to "require_work_tree_exists", and all the
> worry will go away.

Yeah, that seems like a fine solution to me.

-Peff
