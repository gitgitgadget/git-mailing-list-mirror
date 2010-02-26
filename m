From: Jeff King <peff@peff.net>
Subject: Re: Different Fetch and Push URLs?
Date: Fri, 26 Feb 2010 10:20:43 -0500
Message-ID: <20100226152043.GA26963@coredump.intra.peff.net>
References: <c115fd3c1002260701u11cf506fq747d7217d31eba59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 16:21:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl20Q-0006ux-C4
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 16:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091Ab0BZPUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 10:20:49 -0500
Received: from peff.net ([208.65.91.99]:34896 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965068Ab0BZPUr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 10:20:47 -0500
Received: (qmail 1315 invoked by uid 107); 26 Feb 2010 15:21:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 26 Feb 2010 10:21:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2010 10:20:43 -0500
Content-Disposition: inline
In-Reply-To: <c115fd3c1002260701u11cf506fq747d7217d31eba59@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141132>

On Fri, Feb 26, 2010 at 10:01:40AM -0500, Tim Visher wrote:

> My work situation leaves me in a situation where I can clone from my
> central repo but I can't push there.  Is it possible and does it make
> any sense to have a single remote with one URL that I pull from and
> another than I push to?  I only ask because I was looking at the
> output of `git remote show` and noticed that there are 2 URLs.  If it
> is possible, how do I do it?  I looked in `.git/config` and there's
> only 1 URL there.

Try "remote.*.pushurl". It's in git-config(1) and in git-push(1) under
"Named remote in configuration file".

-Peff
