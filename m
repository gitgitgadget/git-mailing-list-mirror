From: Jeff King <peff@peff.net>
Subject: Re: git-push error handling
Date: Thu, 21 Jun 2012 02:07:24 -0400
Message-ID: <20120621060724.GA19485@sigill.intra.peff.net>
References: <jrt949$o3g$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 08:07:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShaYH-0004u0-Ki
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758670Ab2FUGH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 02:07:29 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41013
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473Ab2FUGH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 02:07:29 -0400
Received: (qmail 2360 invoked by uid 107); 21 Jun 2012 06:07:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Jun 2012 02:07:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2012 02:07:24 -0400
Content-Disposition: inline
In-Reply-To: <jrt949$o3g$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200383>

On Wed, Jun 20, 2012 at 02:43:04PM -0500, Neal Kreitzinger wrote:

> Does git push always return an error to "if [ $? -ne 0 ]" when the
> push fails?  Is this sufficient to verify your git-push worked?

It should (and if it doesn't, it's a bug). But do note that even a
failed push may have been partially successful (e.g., pushed some refs
but failed on others).

-Peff
