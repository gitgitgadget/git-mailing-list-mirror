From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] Revert "git gui: show diffs with a minimum of 1
	context line"
Date: Sun, 24 May 2009 01:16:06 +0200
Message-ID: <20090523231605.GA4522@localhost>
References: <1243099727-5272-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sun May 24 01:16:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M80Rx-0000kt-99
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 01:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbZEWXQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 19:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbZEWXQL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 19:16:11 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:23908 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbZEWXQK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 19:16:10 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 24 May 2009 01:16:09 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1M80Ri-0001G0-17; Sun, 24 May 2009 01:16:06 +0200
Content-Disposition: inline
In-Reply-To: <1243099727-5272-1-git-send-email-markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 23 May 2009 23:16:09.0776 (UTC) FILETIME=[74FD2B00:01C9DBFC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119804>

On Sat, May 23, 2009 at 07:28:47PM +0200, Markus Heidelberg wrote:
> Diffs without context can actually be useful. Depending on the changes
> it can be less distracting to read them or to get an overview.

Maybe so. But as stated in the commit message of 55ba8a3 (git gui: show
diffs with a minimum of 1 context line) context-less diff was disabled
because it caused bugs with staging. However, I never got around to fix the
real cause of the problem. See the original thread at

http://article.gmane.org/gmane.comp.version-control.git/94387
