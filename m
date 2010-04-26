From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] pretty: add conditional %C?colorname
 placeholders
Date: Mon, 26 Apr 2010 10:28:32 -0400
Message-ID: <20100426142831.GA25209@coredump.intra.peff.net>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <20100426021347.GA29669@progeny.tock>
 <20100426032642.GA14421@coredump.intra.peff.net>
 <20100426041411.GB30566@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 16:28:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6PIg-0006sg-Ut
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 16:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab0DZO2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 10:28:34 -0400
Received: from peff.net ([208.65.91.99]:49202 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab0DZO2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 10:28:33 -0400
Received: (qmail 10643 invoked by uid 107); 26 Apr 2010 14:28:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Apr 2010 10:28:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Apr 2010 10:28:32 -0400
Content-Disposition: inline
In-Reply-To: <20100426041411.GB30566@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145821>

On Sun, Apr 25, 2010 at 11:14:12PM -0500, Jonathan Nieder wrote:

> > %C(diff.commit), we are not breaking anything (because it is a new
> > syntax), but a script like the one above may want to convert, and there
> > is no way to say "respect the color _config_, but don't respect
> > isatty(1)". Saying "--color" doesn't work, because it overrides the
> > color config. We can cheat a little with GIT_PAGER_IN_USE, but that will
> > have funny interactions with pager.color.
> 
> Very interesting.  I think the natural solution (for new colors) would
> be a --color=config option, which would require parsing options before
> checking configuration.
> 
> Does this sound sane?

Yeah, that makes sense to me.

-Peff
