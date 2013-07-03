From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-config: update doc for --get with multiple values
Date: Wed, 3 Jul 2013 14:32:12 -0400
Message-ID: <20130703183212.GA32043@sigill.intra.peff.net>
References: <41dc25ceac50731a7c5da753c04b7c13c41c1b51.1372876047.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jul 03 20:32:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuRqm-0004ND-TE
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 20:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288Ab3GCScR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 14:32:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:40637 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754184Ab3GCScQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 14:32:16 -0400
Received: (qmail 30169 invoked by uid 102); 3 Jul 2013 18:33:26 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Jul 2013 13:33:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2013 14:32:12 -0400
Content-Disposition: inline
In-Reply-To: <41dc25ceac50731a7c5da753c04b7c13c41c1b51.1372876047.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229507>

On Wed, Jul 03, 2013 at 07:27:39PM +0100, John Keeping wrote:

> Since commit 00b347d (git-config: do not complain about duplicate
> entries, 2012-10-23), "git config --get" does not exit with an error if
> there are multiple values for the specified key but instead returns the
> last value.  Update the documentation to reflect this.

Thanks for catching this. Patch looks good.

There is another section later in the documentation which details the
various exit codes and what they mean. But it seems to have never
actually documented this case, so we don't need to update it. :)

-Peff
