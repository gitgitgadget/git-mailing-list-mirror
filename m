From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] parse-opt: make PARSE_OPT_STOP_AT_NON_OPTION
	available to git rev-parse
Date: Wed, 29 Apr 2009 00:08:04 -0400
Message-ID: <20090429040804.GB14912@coredump.intra.peff.net>
References: <1240950564-15124-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Apr 29 06:08:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz15m-0002Ve-4w
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 06:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbZD2EIL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 00:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbZD2EIJ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 00:08:09 -0400
Received: from peff.net ([208.65.91.99]:60406 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbZD2EII (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 00:08:08 -0400
Received: (qmail 2595 invoked by uid 107); 29 Apr 2009 04:08:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 29 Apr 2009 00:08:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2009 00:08:04 -0400
Content-Disposition: inline
In-Reply-To: <1240950564-15124-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117845>

On Tue, Apr 28, 2009 at 10:29:23PM +0200, Uwe Kleine-K=C3=B6nig wrote:

> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/git-rev-parse.txt |    5 +++++
>  builtin-rev-parse.c             |    8 ++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)

I expected there to be a shell caller here or in patch 2/2, but there
isn't. Is this for topgit?

-Peff
