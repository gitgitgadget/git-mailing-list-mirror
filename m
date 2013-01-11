From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-completion.bash: Silence not a valid object errors
Date: Fri, 11 Jan 2013 10:27:02 -0500
Message-ID: <20130111152702.GA5219@sigill.intra.peff.net>
References: <alpine.DEB.2.02.1301110304220.26739@antec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dylan Smith <dylan.ah.smith@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 16:27:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtgVz-0002mf-Ch
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 16:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab3AKP1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 10:27:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57290 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab3AKP1F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 10:27:05 -0500
Received: (qmail 20329 invoked by uid 107); 11 Jan 2013 15:28:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jan 2013 10:28:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2013 10:27:02 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1301110304220.26739@antec>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213219>

On Fri, Jan 11, 2013 at 03:06:22AM -0500, Dylan Smith wrote:

> Trying to complete the command
> 
>   git show master:./file
> 
> would cause a "Not a valid object name" error to be output on standard
> error. Silence the error so it won't appear on the command line.
> 
> Signed-off-by: Dylan Smith <dylan.ah.smith@gmail.com>
> ---

Thanks, I've been annoyed by this, too. The fix looks obviously correct.

-Peff
