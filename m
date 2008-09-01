From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git gui: show diffs with a minimum of 1 context line
Date: Mon, 1 Sep 2008 21:41:41 +0200
Message-ID: <20080901194141.GA10853@localhost>
References: <20080830164527.GA25370@localhost> <20080901193359.GG7482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 21:42:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaFI5-00028v-9a
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 21:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbYIATlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 15:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYIATlQ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 15:41:16 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:2244 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbYIATlP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 15:41:15 -0400
Received: from darc.dyndns.org ([84.154.124.185]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Sep 2008 21:41:12 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KaFHR-00035s-9X; Mon, 01 Sep 2008 21:41:41 +0200
Content-Disposition: inline
In-Reply-To: <20080901193359.GG7482@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 01 Sep 2008 19:41:12.0817 (UTC) FILETIME=[B0BF6610:01C90C6A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94606>

On Mon, Sep 01, 2008 at 12:33:59PM -0700, Shawn O. Pearce wrote:
> Clemens Buchacher <drizzd@aon.at> wrote:
> > git apply does not handle diffs without context correctly. Configuring git
> > gui to show zero context lines therefore breaks staging.
> > 
> > Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> 
> Thanks, this is queued for 'maint'.

Actually, if you don't mind, I changed the commit message because 'git
apply' is not really to blame here:

Staging hunks without context does not work, because line number
information would have to be recomputed for individual hunks.  Since it is
already possible to stage individual lines using 'Stage Line for Commit',
zero context diffs are not really necessary for git gui, however.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
