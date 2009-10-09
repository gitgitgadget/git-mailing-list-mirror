From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 (amend)] gitweb: Do not show 'patch' link for merge
 commits
Date: Fri, 9 Oct 2009 15:19:30 -0400
Message-ID: <20091009191930.GA14534@coredump.intra.peff.net>
References: <20090930201953.22301.73887.stgit@localhost.localdomain>
 <200910091410.15904.jnareb@gmail.com>
 <200910091423.51286.jnareb@gmail.com>
 <200910091426.44976.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 21:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwL39-0004IG-2M
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 21:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316AbZJITUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 15:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757284AbZJITUK
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 15:20:10 -0400
Received: from peff.net ([208.65.91.99]:43843 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbZJITUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 15:20:09 -0400
Received: (qmail 17926 invoked by uid 107); 9 Oct 2009 19:23:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Oct 2009 15:23:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Oct 2009 15:19:30 -0400
Content-Disposition: inline
In-Reply-To: <200910091426.44976.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129833>

On Fri, Oct 09, 2009 at 02:26:44PM +0200, Jakub Narebski wrote:

> Changes since v1:
>  * Do not show 'patch' link for merge commits not only in 'commit'
>    view, but also in 'commitdiff' view (more complete)
>  * 'patch' link is shown also for root (parentless) commits; it
>    works correctly thanks to passing '--root' option to git-format-patch
>    (remove unnecessary restriction)
>  * better commit message thanks to discussion with Jeff King

Thanks. I am not a gitweb expert, but those changes look good to me.

-Peff
