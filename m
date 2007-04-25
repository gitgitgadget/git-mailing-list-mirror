From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: using stgit/guilt for public branches
Date: Wed, 25 Apr 2007 15:18:39 -0400
Message-ID: <20070425191838.GA6267@filer.fsl.cs.sunysb.edu>
References: <20070425122048.GD1624@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	"Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgn1J-0004pR-OI
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992986AbXDYTTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992985AbXDYTTM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:19:12 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50089 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992978AbXDYTTK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:19:10 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l3PJIdt7007990;
	Wed, 25 Apr 2007 15:18:39 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l3PJId7m007988;
	Wed, 25 Apr 2007 15:18:39 -0400
Content-Disposition: inline
In-Reply-To: <20070425122048.GD1624@mellanox.co.il>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45547>

On Wed, Apr 25, 2007 at 03:20:49PM +0300, Michael S. Tsirkin wrote:
> Hi!
> On git.openfabrics.org we use git to manage all code for our OFED distribution.
> For our kernel code we basically started with 2.6.20, and add some patches,
> which we currently keep separate from upstream kernel source - this makes
> it possible to update from upstream and extract the patches to post
> them for upstream inclusion easily.
> 
> On the surface, it looks like using stg or guilt would be a good idea for us,
> however multiple people need to collaborate on the patch series.
> 
> I am concerned that publishing a git branch managed by stg/guilt
> would present problems: it seems that every time patches are re-ordered,
> a patch is re-written or removed, or we update from upstream,
> everyone who pulls the tree branch will have a hard-to-resolve conflict.
> 
> Is that really a problem? If so, would it be possible to work around this
> somehow?

I thought about this problem a while back when I was trying to decide how to
manage the Unionfs git repository. I came to the conclusion, that there was
no clean way of doing this (at least not using guilt - I can't really speak
for stgit, as I don't know how it does things exactly).

You could try to use git to version the patches directory
(.git/patches/$branch/) and publish that in addition to the actual kernel
repository.

Josef "Jeff" Sipek.

-- 
Keyboard not found!
Press F1 to enter Setup
