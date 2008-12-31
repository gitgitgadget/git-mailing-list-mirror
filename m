From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Add an import wizard for Eclipse projects as part
	of clone
Date: Wed, 31 Dec 2008 07:54:44 -0800
Message-ID: <20081231155444.GH29071@spearce.org>
References: <1230720969-1735-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 16:58:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI3SL-00045S-Rr
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 16:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760AbYLaPyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 10:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755581AbYLaPyp
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 10:54:45 -0500
Received: from george.spearce.org ([209.20.77.23]:47189 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554AbYLaPyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 10:54:45 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E343738200; Wed, 31 Dec 2008 15:54:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1230720969-1735-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104277>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> This adds an optional page for importing Eclipse style projects
> as part of the clone operation.
> 
> This patch I think, greatly simplifies getting an Eclipse based project
> into the workbench.

Yes, yes it does!
 
> I'm mostly interested in comments on pure bugs. E.g. know it's
> blocking when the user selects to import the projects as part of the
> clone process, I also know I'm reusing internal messages and not supplying
> NLS style constansts for all textx.

I noticed you mispelled "showImportWizard" as "showImportWizarad",
but otherwise it looks reasonable to me.  I'd like to see the NLS
stuff extracted out before we apply the patch though.

The blocking part is annoying, but there isn't really a better
way to do it.  What would be worse is going into the background,
then popping open a modal dialog when it completes, as it would
really disrupts the user.  So just don't clone massive projects
and expect to use your workbench at the same time.  :-)

-- 
Shawn.
