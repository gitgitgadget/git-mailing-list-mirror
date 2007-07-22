From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: Git tree for old kernels from before the current tree
Date: Sun, 22 Jul 2007 23:00:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765364AbXGVVAh@vger.kernel.org Sun Jul 22 23:00:53 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765364AbXGVVAh@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICiXs-0000iy-AS
	for glk-linux-kernel-3@gmane.org; Sun, 22 Jul 2007 23:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765364AbXGVVAh (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 22 Jul 2007 17:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764666AbXGVVAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jul 2007 17:00:21 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:36303 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764560AbXGVVAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jul 2007 17:00:17 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id A229B18094B4A; Sun, 22 Jul 2007 23:00:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 9A9B91CD7ADBE;
	Sun, 22 Jul 2007 23:00:15 +0200 (CEST)
In-Reply-To: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53318>


On Jul 22 2007 16:49, Jon Smirl wrote:
>
> Continuing on with kernel archeology for embedded systems, any
> interest in making a git tree with all of the kernel versions from the
> beginning up to the start of the current git tree?

Well, it would be cool if history was somehow available (I recognize
this would be a lot of work). One currently has to go through the
bk repo if something is to be searched for in that timeframe.

> No history in the
> tree, just a simple way to quickly fetch and select a copy of all the
> various old releases. I know they are all available ftp, git tree
> would organize them all in one place and let you fetch them all at
> once.

In fact, we could bisect on it. Though not sure how useful that is
with really old versions :)

> If this is small enough you could add it to the current kernel tree.
> Git's super diffing performance might make this fairly small.
>

	Jan
-- 
