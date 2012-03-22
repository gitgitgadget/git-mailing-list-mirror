From: Jeff King <peff@peff.net>
Subject: Re: Push from specific directory.
Date: Thu, 22 Mar 2012 18:57:47 -0400
Message-ID: <20120322225747.GB14874@sigill.intra.peff.net>
References: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anjib Mulepati <anjibcs@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 23:57:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAqxA-0008Hq-83
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 23:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758039Ab2CVW5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 18:57:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57018
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757750Ab2CVW5t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 18:57:49 -0400
Received: (qmail 6851 invoked by uid 107); 22 Mar 2012 22:58:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 18:58:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 18:57:47 -0400
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193727>

On Thu, Mar 22, 2012 at 06:04:20PM -0400, Anjib Mulepati wrote:

> 1. Is it always necessary to be in root directory to do the push?

No. You are pushing whole commits, not a particular subset of your
working tree. So doing it from anywhere in the repository should have
the same effect.

But...

> 2. Can I have a folder structure like
>         (a) /Hello-World
>         (b) /Hello-World/gitVersion/GitVersionFile.txt and
>         (c) /Hello-World/nonGitVersion/NonGitVersionFile.txt
> where I give git init for (a) and (c). If Itry to push only from (c)
> is that valid?

You have a repository inside a repository. So when you are in (c), you
will be pushing the commits from (c), not from (a). I'm not really sure
what you are trying to accomplish with that.

-Peff
