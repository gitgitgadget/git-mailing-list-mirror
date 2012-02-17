From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] api-config documentation leftovers
Date: Fri, 17 Feb 2012 03:17:43 -0500
Message-ID: <20120217081743.GA11389@sigill.intra.peff.net>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
 <20120214214729.GA24711@sigill.intra.peff.net>
 <7vmx8l5aw3.fsf@alter.siamese.dyndns.org>
 <20120214220953.GC24802@sigill.intra.peff.net>
 <20120216080102.GA11793@sigill.intra.peff.net>
 <7v1upuzgfr.fsf@alter.siamese.dyndns.org>
 <20120217001438.GD4756@sigill.intra.peff.net>
 <7vty2quq9r.fsf@alter.siamese.dyndns.org>
 <20120217031723.GA5738@sigill.intra.peff.net>
 <20120217032325.GB5738@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 12:38:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyM95-0006CP-Pa
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 12:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab2BQLia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 06:38:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41020
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab2BQLi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 06:38:27 -0500
Received: (qmail 6372 invoked by uid 107); 17 Feb 2012 08:24:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Feb 2012 03:24:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2012 03:17:43 -0500
Content-Disposition: inline
In-Reply-To: <20120217032325.GB5738@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190949>

On Thu, Feb 16, 2012 at 10:23:25PM -0500, Jeff King wrote:

> > Since you are re-rolling, these are the documentation fixes I had
> > squashed in based on your earlier review (though come to think of it,
> > the new patches should now also describe `git_config_with_options`).
> 
> Looks like you just reverted the "include" patch instead of the merge of
> the whole topic.  I'll prepare a few documentation fixups on top, then.

Here they are, on top of what you have in jk/config-include. Squashing
would involve breaking apart the second one into the "introduce
git_config_with_options" part and the "and now it learns
respect_includes" part. So it's probably not worth the effort.

  [1/2]: docs/api-config: minor clarifications
  [2/2]: docs/api-config: describe git_config_with_options

-Peff
