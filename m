From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: make "Git GUI Here" Explorer extension more
	robust
Date: Mon, 30 Mar 2009 07:15:10 -0700
Message-ID: <20090330141510.GW23521@spearce.org>
References: <200903300030.03733.markus.heidelberg@web.de> <alpine.DEB.1.00.0903300243050.6454@intel-tinevez-2-302> <200903300851.43164.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 16:17:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoII9-0002Nm-F1
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 16:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbZC3OPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 10:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbZC3OPN
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 10:15:13 -0400
Received: from george.spearce.org ([209.20.77.23]:48378 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbZC3OPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 10:15:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D82AD38211; Mon, 30 Mar 2009 14:15:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903300851.43164.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115155>

Markus Heidelberg <markus.heidelberg@web.de> wrote:
> 
> But I just noticed, that it will obviously "cd .." forever, if no .git/
> was found. Somehow the root directory has to be catched.

Yup.  I'm dropping this patch for now because of this issue, but
I'll look at it again if its addressed in another version.  :-)

-- 
Shawn.
