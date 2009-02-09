From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Add the signed-off in the commit text dialog
Date: Mon, 9 Feb 2009 07:58:18 -0800
Message-ID: <20090209155818.GK30949@spearce.org>
References: <499048FD.7050803@gmail.com> <20090209154627.GJ30949@spearce.org> <551f769b0902090750t2d6a43c4vb4944df340fc5148@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 17:00:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWYXw-0007lC-Vn
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 16:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbZBIP6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 10:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbZBIP6U
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 10:58:20 -0500
Received: from george.spearce.org ([209.20.77.23]:35249 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZBIP6T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 10:58:19 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id DB07438210; Mon,  9 Feb 2009 15:58:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <551f769b0902090750t2d6a43c4vb4944df340fc5148@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109089>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> 
> And what should we do, when we commit a change from somebody else?
> Sould we be able to modify the signed-off of the author?

Well, not by a fancy UI widget and automated tools.  But editing
the SBO line in the message buffer is fine, just like any other
part of the message.

IMHO, the SBO checkbox/button in the UI is only for *your* SBO,
as the committer.  That's how git-gui behaves and it seems to
work out nicely.

-- 
Shawn.
