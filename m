From: Jeff King <peff@peff.net>
Subject: Re: tracking branch for a rebase
Date: Fri, 4 Sep 2009 14:18:46 -0400
Message-ID: <20090904181846.GC19093@coredump.intra.peff.net>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:19:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjdNU-0001qq-OU
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 20:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbZIDSSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 14:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757166AbZIDSSs
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 14:18:48 -0400
Received: from peff.net ([208.65.91.99]:57775 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422AbZIDSSr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 14:18:47 -0400
Received: (qmail 22477 invoked by uid 107); 4 Sep 2009 18:19:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 04 Sep 2009 14:19:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Sep 2009 14:18:46 -0400
Content-Disposition: inline
In-Reply-To: <4AA124DD.1030208@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127756>

On Fri, Sep 04, 2009 at 04:31:57PM +0200, Michael J Gruber wrote:

> Making [rebase against upstream] the default for rebase without
> arguments may meet some objections (oh no, I didn't mean to rebase),
> but I guess it's worth trying.

FWIW, that has been a patch I have been meaning to do for a while. I
don't see it as any more error-prone than "git pull" without arguments.
In either case, you can always recover with a reset from the reflog.

The biggest question is whether it should respect branch.*.merge, or
just branch.*.rebase (I never use the latter simply because I never use
"git pull", but I think it is probably reasonable to restrict it to
cases where you said you are interested in rebasing in general).

-Peff
