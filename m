From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] rev-list and friends: --min-parents, --max-parents
Date: Fri, 18 Mar 2011 15:41:13 -0400
Message-ID: <20110318194113.GA2215@sigill.intra.peff.net>
References: <20110318085616.GA16703@sigill.intra.peff.net>
 <cover.1300459016.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 20:41:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0fYC-0003Zx-0K
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 20:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564Ab1CRTl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 15:41:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46764
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469Ab1CRTlP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 15:41:15 -0400
Received: (qmail 5448 invoked by uid 107); 18 Mar 2011 19:41:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Mar 2011 15:41:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2011 15:41:13 -0400
Content-Disposition: inline
In-Reply-To: <cover.1300459016.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169350>

On Fri, Mar 18, 2011 at 03:50:22PM +0100, Michael J Gruber wrote:

> As opposed to the RFD it replaces, this is a real patch series with
> documentation and tests, and it even comes with boiler plate. It should
> make all of Jeff's and Junio's dreams come true (as far as revision
> limiting by parent number goes).
> 
> 1/3 introduces the new options (and has a proper commit message)
> 2/3 I noted along the way and could be applied earlier
> 3/3 depends on 1 and 2 and is the candy (doc, tests, completion)

I didn't see it mentioned anywhere, but I assume this applies on
mg/rev-list-one-side-only (b1b4755). It has conflicts when applied on
master.

(I know you probably know that, but it is for the benefit of other
reviewers).

-Peff
