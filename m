From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 19:06:06 -0500
Message-ID: <20070102000606.GA32148@fieldses.org>
References: <20070101213906.GA23857@fieldses.org> <535252.4420.qm@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 01:06:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1XAU-00066w-BJ
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 01:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbXABAGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 19:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792AbXABAGL
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 19:06:11 -0500
Received: from mail.fieldses.org ([66.93.2.214]:58527 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbXABAGK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 19:06:10 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1XAM-0000VZ-3x; Mon, 01 Jan 2007 19:06:06 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <535252.4420.qm@web31811.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35750>

On Mon, Jan 01, 2007 at 03:59:44PM -0800, Luben Tuikov wrote:
> --- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> > +git pull origin next::
> 
> No.
> 
> > +	Merge into the current branch the remote branch `next`;
> 
> So, "origin" now means "current branch".

No, "origin" refers to the remote repository that you originally cloned
from.

Pulls always merge into the current branch.  So it wouldn't make sense
to specify the current branch on the command line.

--b.
