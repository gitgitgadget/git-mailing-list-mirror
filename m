From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Sun, 5 Dec 2010 02:39:39 -0500
Message-ID: <20101205073938.GB15233@sigill.intra.peff.net>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aleksi Aalto <aga@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 08:40:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PP9D9-0002Nz-77
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 08:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab0LEHjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 02:39:43 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45093 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386Ab0LEHjn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 02:39:43 -0500
Received: (qmail 2636 invoked by uid 111); 5 Dec 2010 07:39:41 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 05 Dec 2010 07:39:41 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Dec 2010 02:39:39 -0500
Content-Disposition: inline
In-Reply-To: <7voc90wx36.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162930>

On Sat, Dec 04, 2010 at 10:30:21PM -0800, Junio C Hamano wrote:

> * aa/status-hilite-branch (2010-11-18) 1 commit
>  - status: show branchname with a configurable color
> 
> I am indifferent/uninterested; I don't see anything wrong with it, but I
> do not find coloring the field particularly useful myself.

I am not particularly interested, either, but FWIW, the gitcommit syntax
highlighting that ships with vim does highlight this, so there are at
least other people who think this is a good idea.

However, I'm not sure about the default. The original patch defaulted to
magenta. Your fixup defaults to "plain", but that is a regression
(albeit a minor one) for people who have status.header set. I think the
correct default is "the same as status.header", but that is sadly not
trivial to implement because of the way we parse and store colors.

I don't know if it is worth holding up the patch. It is only a
regression to the user's eyes, and it is reasonably easy for them to
tweak their config.

-Peff
