From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] push: add recurseSubmodules config option
Date: Tue, 1 Dec 2015 19:40:32 -0500
Message-ID: <20151202004031.GA28197@sigill.intra.peff.net>
References: <1448970583-14513-1-git-send-email-mac@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Crowe <mac@mcrowe.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 01:40:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3vTL-0007l9-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 01:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbbLBAkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 19:40:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:36028 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932273AbbLBAkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 19:40:35 -0500
Received: (qmail 26123 invoked by uid 102); 2 Dec 2015 00:40:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 18:40:34 -0600
Received: (qmail 24711 invoked by uid 107); 2 Dec 2015 00:40:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 19:40:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Dec 2015 19:40:32 -0500
Content-Disposition: inline
In-Reply-To: <1448970583-14513-1-git-send-email-mac@mcrowe.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281867>

On Tue, Dec 01, 2015 at 11:49:43AM +0000, Mike Crowe wrote:

> The --recurse-submodules command line parameter has existed for some
> time but it has no config file equivalent.
> 
> Following the style of the corresponding parameter for git fetch,
> invent push.recurseSubmodules to provide a default for this parameter.
> This also requires the addition of --recurse-submodules=no to allow
> the configuration to be overridden on the command line when required.
> 
> The most straightforward way to implement this appears to be to make
> push use code in submodule-config in a similar way to fetch.
> 
> Signed-off-by: Mike Crowe <mac@mcrowe.com>
> ---
> Changes in v3:

Hrm, I merged v2 of this to 'next' last week.

The options at this point are either to revert that and re-start the
topic, or just make the further changes a patch on top. Thoughts?

-Peff
