From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] reflog documentation: -n is an alias for --dry-run
Date: Sun, 13 Sep 2009 05:40:32 -0400
Message-ID: <20090913094032.GC14438@coredump.intra.peff.net>
References: <1252813314-14408-1-git-send-email-nelhage@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Elhage <nelhage@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 13 11:40:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmlZa-0002rE-Bi
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 11:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbZIMJke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 05:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbZIMJkd
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 05:40:33 -0400
Received: from peff.net ([208.65.91.99]:36476 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbZIMJkd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 05:40:33 -0400
Received: (qmail 16809 invoked by uid 107); 13 Sep 2009 09:40:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 13 Sep 2009 05:40:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Sep 2009 05:40:32 -0400
Content-Disposition: inline
In-Reply-To: <1252813314-14408-1-git-send-email-nelhage@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128347>

On Sat, Sep 12, 2009 at 11:41:54PM -0400, Nelson Elhage wrote:

>  static const char reflog_expire_usage[] =
> -"git reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
> +"git reflog (show|expire) [--verbose] [-n | --dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";

Really? I think "git reflog show -n" is not about dry-run at all...

-Peff
