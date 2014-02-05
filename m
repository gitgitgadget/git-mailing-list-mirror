From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/13] move LESS/LV pager environment to Makefile
Date: Wed, 5 Feb 2014 14:23:50 -0500
Message-ID: <20140205192350.GA16009@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
 <20140205180857.GM15218@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 20:24:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB84j-0003TZ-BE
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 20:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbaBETXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 14:23:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:45224 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751384AbaBETXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 14:23:52 -0500
Received: (qmail 12622 invoked by uid 102); 5 Feb 2014 19:23:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 13:23:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 14:23:50 -0500
Content-Disposition: inline
In-Reply-To: <20140205180857.GM15218@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241645>

On Wed, Feb 05, 2014 at 01:08:57PM -0500, Jeff King wrote:

> +quote() {
> +	echo "$1" | sed 's/\\/\\\\/g; s/"/\\"/'
> +}

This of course has the same "/g" bug as the earlier patch in the series.

I was tempted to pull the function out into script/lib-c.sh, so that
both can source it, but perhaps that is overkill.

-Peff
