From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2012, #02; Wed, 4)
Date: Thu, 5 Apr 2012 08:47:06 -0400
Message-ID: <20120405124706.GA3921@sigill.intra.peff.net>
References: <7v8vib6pu8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 14:47:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFm5q-000257-Pk
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 14:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab2DEMrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 08:47:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48832
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab2DEMrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 08:47:09 -0400
Received: (qmail 23208 invoked by uid 107); 5 Apr 2012 12:47:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Apr 2012 08:47:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2012 08:47:06 -0400
Content-Disposition: inline
In-Reply-To: <7v8vib6pu8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194770>

On Wed, Apr 04, 2012 at 04:26:39PM -0700, Junio C Hamano wrote:

> * jc/push-upstream-sanity (2012-04-03) 2 commits
>  - [fixup] remove misguided "try to see if URLs are the same"
>  - push: detect nonsense "upstream" check more carefully
> 
> "git push $there" without refspec, when the current branch is set to push
> to a remote different from $there, used to push to $there using the
> upstream information to a remote unreleated to $there.

The patch produced by squashing those together looks good to me.  Though
it might be worth getting input from people who use "upstream" (whether
it becomes the default or not) by re-posting the final patch under a
more obvious subject.

> This is necessary if we were to switch the push.default to 'current'.

I assume you meant "upstream" here.

-Peff
