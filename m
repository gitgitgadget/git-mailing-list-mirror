From: Jeff King <peff@peff.net>
Subject: Re: [RFC] require-work-tree wants more than what its name says
Date: Thu, 5 May 2011 00:28:05 -0400
Message-ID: <20110505042805.GA10547@sigill.intra.peff.net>
References: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
 <20110504073850.GA8512@sigill.intra.peff.net>
 <7vliymfp4t.fsf@alter.siamese.dyndns.org>
 <20110504212848.GA27779@sigill.intra.peff.net>
 <7v62ppdhh5.fsf@alter.siamese.dyndns.org>
 <20110505042319.GA10243@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 06:28:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHqAf-0006E2-Gs
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 06:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097Ab1EEE2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 00:28:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38152
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070Ab1EEE2H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 00:28:07 -0400
Received: (qmail 26603 invoked by uid 107); 5 May 2011 04:30:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 00:30:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 00:28:05 -0400
Content-Disposition: inline
In-Reply-To: <20110505042319.GA10243@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172793>

On Thu, May 05, 2011 at 12:23:19AM -0400, Jeff King wrote:

> > Add a function "require_work_tree_exists" that implements the check
> > this function originally intended (this is so that third-party scripts
> > that rely on the current behaviour do not have to get broken), and
> > update all the in-tree users to use it.
> 
> Overall, I think this is a good thing to do. And for the existing
> working cases (i.e., when you are in the repo) it should be a no-op.  It

Sorry, this should have been the more specific: "i.e., when are you are
in the _working tree_".

-Peff
