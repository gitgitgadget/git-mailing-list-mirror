From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 02/19] Delete incorrect Javadoc from Config's
	getRawString method
Date: Sat, 25 Jul 2009 13:33:40 -0700
Message-ID: <20090725203340.GE11191@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org> <1248547982-4003-2-git-send-email-spearce@spearce.org> <1248547982-4003-3-git-send-email-spearce@spearce.org> <200907252232.30712.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 22:34:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUnwJ-0002G5-Un
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 22:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbZGYUdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 16:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbZGYUdk
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 16:33:40 -0400
Received: from george.spearce.org ([209.20.77.23]:40093 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbZGYUdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 16:33:39 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1E056381FD; Sat, 25 Jul 2009 20:33:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200907252232.30712.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124067>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> l?rdag 25 juli 2009 20:52:45 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > I don't know how this Javadoc got here, but it predates the code
> > refactor done by Constantine Plotnikov in 2564768e63.
> 
> Why do you think so? The getRawString before his patch did not have any
> javadoc. It was added there in that patch.

Oh.  I failed to look at the history, I just assumed he carried it
over in the refactoring.  Well, it still should die.

-- 
Shawn.
