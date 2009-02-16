From: Jeff King <peff@peff.net>
Subject: Re: Improving CRLF error message; also, enabling autocrlf
	and?safecrlf by default
Date: Sun, 15 Feb 2009 22:43:11 -0500
Message-ID: <20090216034311.GA12616@coredump.intra.peff.net>
References: <loom.20090216T022524-78@post.gmane.org> <20090216030446.GC18780@sigill.intra.peff.net> <loom.20090216T032551-612@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Spiro <jasonspiro4@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 04:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYuS1-0001nv-IJ
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 04:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858AbZBPDnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 22:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbZBPDnO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 22:43:14 -0500
Received: from peff.net ([208.65.91.99]:33343 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862AbZBPDnN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 22:43:13 -0500
Received: (qmail 12851 invoked by uid 107); 16 Feb 2009 03:43:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 22:43:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 22:43:11 -0500
Content-Disposition: inline
In-Reply-To: <loom.20090216T032551-612@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110127>

On Mon, Feb 16, 2009 at 03:29:23AM +0000, Jason Spiro wrote:

> > > 2.  In addition, could you please enable the core.autocrlf and 
> core.safecrlf 
> > > options by default in the next version of Git?
> > 
> > I think that is up to your platform packaging, I think. I think msysgit
> > is shipping with core.autocrlf on by default these days. But again, I
> > don't know very much about that area.
> 
> Are you saying that only my platform's packager can decide what options are 
> enabled by default, and that you upstream folks have no influence at all?  :)

Not necessarily. But I don't think we want core.autocrlf on by default
for all platforms. So the decision needs to be made on a platform by
platform basis. The cleanest way to do that (in my opinion) is through a
system-level configuration file. But git built from src does not
distribute such a configuration file at all; that seems to be in the
scope of package distributors.

-Peff
