From: Jeff King <peff@peff.net>
Subject: Re: git versions
Date: Fri, 22 Jan 2016 17:37:54 -0500
Message-ID: <20160122223753.GB15635@sigill.intra.peff.net>
References: <loom.20160122T180812-568@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ashish Yadav <ashish.yadav@firemon.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:38:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkLA-0004fv-TZ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbcAVWh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 17:37:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:58981 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755261AbcAVWh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:37:56 -0500
Received: (qmail 18155 invoked by uid 102); 22 Jan 2016 22:37:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:37:56 -0500
Received: (qmail 6769 invoked by uid 107); 22 Jan 2016 22:38:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:38:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jan 2016 17:37:54 -0500
Content-Disposition: inline
In-Reply-To: <loom.20160122T180812-568@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284602>

On Fri, Jan 22, 2016 at 05:15:23PM +0000, Ashish Yadav wrote:

> I am using git v1.7.12.4 w CentOS 6.5. Can I upgrade 1.7.1-3 to 2.7?

Probably. :)

I don't know much about what has been packaged for CentOS 6.5, but you
can certainly build the latest version of git from source. You can get
tarballs at:

  https://www.kernel.org/pub/software/scm/git/

Or you can just clone the git repository at:

  git://git.kernel.org/pub/scm/git/git.git

If you are asking "can I upgrade to v2.7 and still use my existing
repositories?", then the answer is yes, everything should continue to
work, and you can fetch and push between servers running arbitrary git
versions.

You may want to look at the release notes in Documentation/RelNotes, as
some of the defaults have changed (especially around the v2.0 release).

-Peff
