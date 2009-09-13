From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] reflog documentation: -n is an alias for --dry-run
Date: Sun, 13 Sep 2009 09:26:14 -0400
Message-ID: <20090913132614.GA26275@coredump.intra.peff.net>
References: <1252813314-14408-1-git-send-email-nelhage@mit.edu>
 <20090913094032.GC14438@coredump.intra.peff.net>
 <20090913125313.GQ4275@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Elhage <nelhage@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 13 15:26:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmp6I-00083r-6s
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 15:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbZIMN0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 09:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbZIMN0P
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 09:26:15 -0400
Received: from peff.net ([208.65.91.99]:35578 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbZIMN0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 09:26:14 -0400
Received: (qmail 17860 invoked by uid 107); 13 Sep 2009 13:26:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 13 Sep 2009 09:26:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Sep 2009 09:26:14 -0400
Content-Disposition: inline
In-Reply-To: <20090913125313.GQ4275@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128360>

On Sun, Sep 13, 2009 at 08:53:13AM -0400, Nelson Elhage wrote:

> Patch withdrawn -- I'd send one documenting that -n works for delete
> and expire, but it'd probably just complicate the documentation more
> than clarify anything.

I think it would be fine to just split the (show|expire) line into two
separate lines:

> > > -"git reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
> > > +"git reflog (show|expire) [--verbose] [-n | --dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";

-Peff
