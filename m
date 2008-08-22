From: Jeff King <peff@peff.net>
Subject: Re: [bug] git `next' does not do trivial merges
Date: Fri, 22 Aug 2008 15:31:17 -0400
Message-ID: <20080822193117.GA6361@coredump.intra.peff.net>
References: <g8lmpn$jvk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 21:32:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWcN1-0003NC-3c
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 21:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbYHVTbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 15:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbYHVTbV
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 15:31:21 -0400
Received: from peff.net ([208.65.91.99]:4451 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbYHVTbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 15:31:21 -0400
Received: (qmail 24184 invoked by uid 111); 22 Aug 2008 19:31:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 22 Aug 2008 15:31:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2008 15:31:17 -0400
Content-Disposition: inline
In-Reply-To: <g8lmpn$jvk$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93345>

On Fri, Aug 22, 2008 at 08:36:39AM +0200, Paolo Bonzini wrote:

> I had already posted this bug report yesterday but it was hidden in a  
> cover letter at  
> http://permalink.gmane.org/gmane.comp.version-control.git/93143 -- so  
> I'll copy the relevant info here:

Sadly, this bisects to 1c7b76b (Build in merge).

-Peff
