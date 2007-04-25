From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: using stgit/guilt for public branches
Date: Wed, 25 Apr 2007 16:40:07 -0400
Message-ID: <20070425204007.GA9375@filer.fsl.cs.sunysb.edu>
References: <20070425122048.GD1624@mellanox.co.il> <20070425191838.GA6267@filer.fsl.cs.sunysb.edu> <20070425195248.GA5217@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	"Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Apr 25 22:40:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgoI0-0008Vx-U7
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 22:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993155AbXDYUk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993156AbXDYUk1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:40:27 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:52698 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993153AbXDYUkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 16:40:25 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l3PKe7aM011653;
	Wed, 25 Apr 2007 16:40:08 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l3PKe7MM011651;
	Wed, 25 Apr 2007 16:40:07 -0400
Content-Disposition: inline
In-Reply-To: <20070425195248.GA5217@mellanox.co.il>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45569>

On Wed, Apr 25, 2007 at 10:52:48PM +0300, Michael S. Tsirkin wrote:
> > Quoting Josef Sipek <jsipek@fsl.cs.sunysb.edu>:
> > Subject: Re: using stgit/guilt for public branches
> > 
> > You could try to use git to version the patches directory
> > (.git/patches/$branch/) and publish that in addition to the actual kernel
> > repository.
> 
> How does one do this, exactly?

cd .git/patches/$branch/
git-init-db
git-commit -a -m "initial import"


Then set up this repository to push/pull.


No guarantees about it actually being helpful to your situation :)

Josef "Jeff" Sipek.

-- 
UNIX is user-friendly ... it's just selective about who it's friends are
