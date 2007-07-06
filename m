From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-diff: don't use colors when stdout is not a tty.
Date: Fri, 6 Jul 2007 18:37:59 +0200
Message-ID: <20070706163759.GA26670@moooo.ath.cx>
References: <468E612E.2070903@objectxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michel Marti <mma@objectxp.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 18:38:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6qot-0004bv-8I
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 18:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758434AbXGFQiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 12:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760623AbXGFQiF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 12:38:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:56252 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754124AbXGFQiC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 12:38:02 -0400
Received: (qmail invoked by alias); 06 Jul 2007 16:38:01 -0000
Received: from pD9EBB437.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.180.55]
  by mail.gmx.net (mp052) with SMTP; 06 Jul 2007 18:38:01 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+tMEx/nGOtSMvSbWABcgz7gWP2TLRMDAD5enpz16
	9oXaJyCC38ff/p
Content-Disposition: inline
In-Reply-To: <468E612E.2070903@objectxp.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51775>

Michel Marti <mma@objectxp.com> wrote:
> Currently, with diff-coloring enabled, git-diff outputs color escape
> sequences even if stdout is redirected (not a tty). This is rather annoying
> when trying to further process the output. This patch teaches the diff command
> to only do its coloring stuff when a pager is in use or stdout is a tty.

Set color.diff to auto instead of true.
