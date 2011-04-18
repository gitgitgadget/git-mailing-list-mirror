From: Jeff King <peff@peff.net>
Subject: Re: spurious fail of git merge after rebasing
Date: Mon, 18 Apr 2011 02:10:27 -0400
Message-ID: <20110418061027.GA26221@sigill.intra.peff.net>
References: <201104160045.12633.davd@bart.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "D. A. van Delft" <davd@bart.nl>
X-From: git-owner@vger.kernel.org Mon Apr 18 08:10:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBhfa-0008WV-Ek
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 08:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab1DRGKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 02:10:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53909
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab1DRGKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 02:10:30 -0400
Received: (qmail 30624 invoked by uid 107); 18 Apr 2011 06:11:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Apr 2011 02:11:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Apr 2011 02:10:27 -0400
Content-Disposition: inline
In-Reply-To: <201104160045.12633.davd@bart.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171736>

On Sat, Apr 16, 2011 at 12:45:12AM +0200, D. A. van Delft wrote:

> Point is, I have found a scenario where sometimes git fails on 
> a specific merge.
> Each time I start with the same identical git repository 
> (archived once and restored each time before a run) and run 
> the same fixed series of rebases and merges on it. Once in a 
> while it fails with a merge conflict, sometimes at first try, 
> sometimes after 10+ times. I have a canned set of testcases 
> which reproduces this behaviour. I have also narrowed it down 
> somewhat on how to work around, or prevent it from occurring. 
> 
> However, given that it doesn't always fail or succeed, is 
> unexpected.

Yeah, git should generally be deterministic. Can you show us your test
case?

-Peff
