From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Userdiff patterns for C#
Date: Wed, 11 Aug 2010 15:37:39 -0400
Message-ID: <20100811193739.GC8106@coredump.intra.peff.net>
References: <1281488961-5884-1-git-send-email-gsvick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Bjorn Steinbrink <B.Steinbrink@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>
To: Petr Onderka <gsvick@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 21:37:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjH7X-0007J5-KB
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309Ab0HKThp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 15:37:45 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33675 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755602Ab0HKThp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:37:45 -0400
Received: (qmail 6540 invoked by uid 111); 11 Aug 2010 19:37:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Wed, 11 Aug 2010 19:37:42 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Aug 2010 15:37:39 -0400
Content-Disposition: inline
In-Reply-To: <1281488961-5884-1-git-send-email-gsvick@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153292>

On Wed, Aug 11, 2010 at 01:09:21AM +0000, Petr Onderka wrote:

> Add userdiff patterns for C#. This code is an improved version of
> code by Adam Petaccia from 21 June 2009 mail to the list.
> [...]
>  t/t4018-diff-funcname.sh |    2 +-
>  userdiff.c               |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletions(-)

Can you also add a line in Documentation/gitattributes.txt so that
people know your pattern is there? In the "custom hunk-header"
section, there is already a list to add to.

-Peff
