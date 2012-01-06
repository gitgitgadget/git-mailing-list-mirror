From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse_object: try internal cache before reading object db
Date: Fri, 6 Jan 2012 17:46:19 -0500
Message-ID: <20120106224619.GA13654@sigill.intra.peff.net>
References: <20120105210001.GA30549@sigill.intra.peff.net>
 <7vipkpn87d.fsf@alter.siamese.dyndns.org>
 <20120106191654.GA11022@sigill.intra.peff.net>
 <7v8vlkjzcj.fsf@alter.siamese.dyndns.org>
 <20120106223324.GB13106@sigill.intra.peff.net>
 <7vmxa0ih6s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 23:46:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjIYM-0003p3-B5
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 23:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759061Ab2AFWqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 17:46:22 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59724
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759030Ab2AFWqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 17:46:21 -0500
Received: (qmail 9666 invoked by uid 107); 6 Jan 2012 22:53:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Jan 2012 17:53:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2012 17:46:19 -0500
Content-Disposition: inline
In-Reply-To: <7vmxa0ih6s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188053>

On Fri, Jan 06, 2012 at 02:45:15PM -0800, Junio C Hamano wrote:

> > Did you want to leave the parse_object optimization until next cycle,
> > too? It's not loosening checks, but it's such a core piece of code that
> > it makes me nervous somebody somewhere is abusing "struct object" in a
> > way that will break it.
> 
> I was just updating the "What's cooking" report and my current thinking is
> that we should keep all three in "next" to give it a bit of exposure for
> now, and merge them to "master" early in the 1.7.10 cycle.

That sounds perfect. Thanks.

-Peff
