From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Fri, 26 Oct 2012 10:00:56 -0400
Message-ID: <20121026140056.GL1455@sigill.intra.peff.net>
References: <20121023204437.GE28592@odin.tremily.us>
 <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
 <20121025221431.GH13647@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>, Nahor <nahor.j+gmane@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Oct 26 16:01:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRkTU-00015j-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 16:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933135Ab2JZOBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 10:01:01 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37928 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933042Ab2JZOA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 10:00:59 -0400
Received: (qmail 23168 invoked by uid 107); 26 Oct 2012 14:01:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Oct 2012 10:01:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2012 10:00:56 -0400
Content-Disposition: inline
In-Reply-To: <20121025221431.GH13647@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208448>

On Thu, Oct 25, 2012 at 06:14:31PM -0400, W. Trevor King wrote:

> Should I rebase this so it lands cleanly atop 38ae92e4 in next?
> 
>   commit 38ae92e4d027063b9b87e51a9bf12809d10066f6
>   Author: W. Trevor King <wking@tremily.us>
>   Date:   Tue Oct 23 17:00:21 2012 -0400
> 
>     git-submodule: wrap branch option with "<>" in usage strings.

In general, it is not a good idea to base your patches on things in
next, because it means your topic is held hostage to the one in next,
which may or may not graduate to master. We can always do a merge later
(and in this case, it is really just a one-line conflict).

-Peff
