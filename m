From: Jeff King <peff@peff.net>
Subject: Re: removing a commit from a branch
Date: Wed, 4 May 2011 04:45:02 -0400
Message-ID: <20110504084502.GC8512@sigill.intra.peff.net>
References: <BANLkTimtpvVRU=1iCbrteyHixaWGuVKDjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gergely Buday <gbuday@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:45:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHXho-0007pl-L6
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 10:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab1EDIpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 04:45:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34353
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab1EDIpF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 04:45:05 -0400
Received: (qmail 16220 invoked by uid 107); 4 May 2011 08:46:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 May 2011 04:46:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2011 04:45:02 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimtpvVRU=1iCbrteyHixaWGuVKDjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172725>

On Wed, May 04, 2011 at 10:35:08AM +0200, Gergely Buday wrote:

> I have a problematic commit in a series of commits on a branch. It
> contains adding a large binary file, which I would like to avoid to
> push to our main repository. How can I remove that from the series of
> commits? A command-line solution, please, if possible.

Removing it will involve rewriting history, which can create headaches
for people who have built on that history (they will need to rebase
their commits on the rewritten history). But if that's OK, then the
command you want is filter-branch. See "git help filter-branch"; in
particular, the EXAMPLES section contains commands to do exactly what
you want.

-Peff
