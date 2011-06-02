From: Jeff King <peff@peff.net>
Subject: Re: git status --ignored
Date: Thu, 2 Jun 2011 01:57:00 -0400
Message-ID: <20110602055700.GB28292@sigill.intra.peff.net>
References: <4DE712CE.20509@vpac.org>
 <7vr57cerxo.fsf@alter.siamese.dyndns.org>
 <20110602055449.GA28292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Spiers <aspiers@vpac.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 07:57:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS0u5-00080H-0K
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 07:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990Ab1FBF5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 01:57:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36693
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755509Ab1FBF5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 01:57:03 -0400
Received: (qmail 25291 invoked by uid 107); 2 Jun 2011 05:57:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Jun 2011 01:57:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2011 01:57:00 -0400
Content-Disposition: inline
In-Reply-To: <20110602055449.GA28292@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174930>

On Thu, Jun 02, 2011 at 01:54:49AM -0400, Jeff King wrote:

> That meant that if we had ignored items to show, but no
> untracked items, we would erroneously exit early and fail to
> show the ignored items.

BTW, we could probably use some tests for "status --ignore". I'll leave
that to you as penance for your bug, if you want them. :)

-Peff
