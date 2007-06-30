From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question about git-prune
Date: Sat, 30 Jun 2007 19:02:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706301900290.4438@racer.site>
References: <Pine.LNX.4.64.0706300915440.16800@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 20:02:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4hHD-0003yj-BI
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 20:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbXF3SCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 14:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbXF3SCV
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 14:02:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:58093 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752780AbXF3SCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 14:02:21 -0400
Received: (qmail invoked by alias); 30 Jun 2007 18:02:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 30 Jun 2007 20:02:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ESyFbxhZEY/v5MkUVqUkIPLRUEIC0ICEHFOqO13
	5yFS/hIAivj2EM
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0706300915440.16800@x2.ybpnyarg>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51236>

Hi,

On Sat, 30 Jun 2007, walt wrote:

> $cd src/git
> $git-fsck
> dangling tree c642c018aa55d39fff061183f58062de9d8375ac
> dangling commit e1341abc3759950e891822088cb0163b71b316b3
> dangling commit 9f38e1ef7e7992ca490b9b419f52fb4d11efb0e4
> dangling commit b82871b3c32faa8a317007f343fdf2d0ddc9954e
> $git-prune
> $git-fsck
> dangling tree c642c018aa55d39fff061183f58062de9d8375ac
> dangling commit e1341abc3759950e891822088cb0163b71b316b3
> dangling commit 9f38e1ef7e7992ca490b9b419f52fb4d11efb0e4
> dangling commit b82871b3c32faa8a317007f343fdf2d0ddc9954e

Probably the objects were packed.

I do not understand why you use git-prune directly, to begin with. Why not 
use git-gc and be done with it?

Hth,
Dscho
