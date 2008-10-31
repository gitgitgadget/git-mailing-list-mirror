From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 14:39:33 -0400
Message-ID: <20081031183933.GA3577@sigill.intra.peff.net>
References: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com> <1225429753-70109-1-git-send-email-benji@silverinsanity.com> <20081031182456.GC3230@sigill.intra.peff.net> <20081031183601.GB8464@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>,
	Shawn O Pearce <spearce@spearce.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 19:40:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvyvU-0004Fg-Qk
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 19:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbYJaSjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 14:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbYJaSjj
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 14:39:39 -0400
Received: from peff.net ([208.65.91.99]:2523 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbYJaSjj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 14:39:39 -0400
Received: (qmail 8510 invoked by uid 111); 31 Oct 2008 18:39:38 -0000
Received: from 65-122-15-169.dia.static.qwest.net (HELO sigill.intra.peff.net) (65.122.15.169)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 31 Oct 2008 14:39:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Oct 2008 14:39:33 -0400
Content-Disposition: inline
In-Reply-To: <20081031183601.GB8464@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99618>

On Fri, Oct 31, 2008 at 07:36:01PM +0100, Pierre Habouzit wrote:

> Set up a Debian autobuilder with dash as a /bin/sh (apt-get install
> dash, dpkg-reconfigure -plow dash and say 'yes'). You'll see those kind
> of problems arise immediately.

I don't need to; my development box is Debian with dash as /bin/sh. :)

> Dash is a POSIX compatible shell, with almost no extension added (in
> particular its echo has no -n option) which helps to find those kind of
> issues.
> 
> It would help detecting git shell scripts that use bashism as well.

Agreed, and actually I found such a bashism (test ==) last week (though
of course it also broke on FreeBSD).

-Peff
