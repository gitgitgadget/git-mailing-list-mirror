From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 3/4] run-command: help callers distinguish errors
Date: Wed, 28 Jan 2009 02:43:34 -0500
Message-ID: <20090128074334.GB31951@coredump.intra.peff.net>
References: <20090128073059.GD19165@coredump.intra.peff.net> <20090128073639.GC31884@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:45:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS56s-00014X-BH
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbZA1Hnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbZA1Hnh
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:43:37 -0500
Received: from peff.net ([208.65.91.99]:45263 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbZA1Hng (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:43:36 -0500
Received: (qmail 19724 invoked by uid 107); 28 Jan 2009 07:43:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 02:43:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 02:43:34 -0500
Content-Disposition: inline
In-Reply-To: <20090128073639.GC31884@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107498>

On Wed, Jan 28, 2009 at 02:36:39AM -0500, Jeff King wrote:

> +#define IS_RUN_COMMAND_ERR(x) (x >= ERR_RUN_COMMAND_FORK)

<sigh> This should be "<= -ERR_RUN_COMMAND_FORK", since we expect the
negated status.

Maybe it is time I wrote a test for a failed external.

-Peff
