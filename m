From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git status -q (similar to subversion)
Date: Tue, 30 Jun 2009 01:33:25 -0400
Message-ID: <20090630053325.GC29643@sigio.peff.net>
References: <Pine.LNX.4.64.0906272248570.11453@cube> <20090628224447.GB1951@gmail.com> <Pine.LNX.4.64.0906292131330.27727@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Unknown <borg@uu3.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 07:32:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLVwv-0006LB-S9
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 07:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbZF3Fbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 01:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbZF3Fbc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 01:31:32 -0400
Received: from peff.net ([208.65.91.99]:57124 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686AbZF3Fbb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 01:31:31 -0400
Received: (qmail 29674 invoked by uid 1000); 30 Jun 2009 05:33:25 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0906292131330.27727@cube>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122488>

On Mon, Jun 29, 2009 at 09:39:18PM +0200, Unknown wrote:

> Other solution I see is add extra config variable like:
> status.showUntrackedDefault = (no|normal|all)
> So when you peform 'git status -u' it will be used.

It exists, but is called showUntrackedFiles. See "git help config" for
details.

-Peff
