From: Jeff King <peff@peff.net>
Subject: Re: [RFC] rebase: use @{upstream} if no upstream specified
Date: Fri, 19 Nov 2010 23:10:12 -0500
Message-ID: <20101120041011.GA20725@sigill.intra.peff.net>
References: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20101113095140.GH8911@home.lan>
 <AANLkTin+3FuuX_pavZQMrbi4qxjTRvM7nHk1PXcFbeiZ@mail.gmail.com>
 <20101119211533.GA18942@sigill.intra.peff.net>
 <AANLkTikWYVyCf9mueoAHjGcQuNOdPFyQrmtW79As4RG-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Dirson <ydirson@free.fr>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 20 05:10:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJemY-0007zg-5A
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 05:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757764Ab0KTEKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 23:10:19 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46996 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757568Ab0KTEKS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 23:10:18 -0500
Received: (qmail 31080 invoked by uid 111); 20 Nov 2010 04:10:16 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 20 Nov 2010 04:10:16 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Nov 2010 23:10:12 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikWYVyCf9mueoAHjGcQuNOdPFyQrmtW79As4RG-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161819>

On Fri, Nov 19, 2010 at 07:26:57PM -0500, Martin von Zweigbergk wrote:

> Yes, I did try that and I noticed that it worked, but it helps to know
> that it is not just by accident. I realize I was not very clear, but
> what I really was wondering if there is any advantage to using
> "git for-each-ref --format='%(upstream)' ${branch_name}" (as used by
> git pull) as compared to "git rev-parse @{upstream}" as suggested by
> Yann. ($branch_name in this case would be the current branch.)

No, I don't think there is a reason to prefer one over the other these
days. When the instance in git-parse-remote was written (e9460a6,
2009-06-12) @{upstream} did not yet exist (it came in 28fb843,
2009-09-10). So for-each-ref was the only way to get the informationa

I would use whichever one seems clearer in your context.

-Peff
