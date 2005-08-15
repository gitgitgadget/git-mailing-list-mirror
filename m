From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Tue, 16 Aug 2005 00:53:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508160051580.26204@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050815080931.64F0D352633@atlas.denx.de> 
 <Pine.LNX.4.58.0508150930020.3553@g5.osdl.org> <46a038f90508151309269ffc04@mail.gmail.com>
 <Pine.LNX.4.58.0508151535130.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Wolfgang Denk <wd@denx.de>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 16 00:53:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4nph-0007Ao-6B
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 00:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVHOWx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 18:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVHOWx0
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 18:53:26 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47839 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750800AbVHOWx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 18:53:26 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D91A4E27F0; Tue, 16 Aug 2005 00:53:24 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BF8F399A69; Tue, 16 Aug 2005 00:53:24 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AB8F499A49; Tue, 16 Aug 2005 00:53:24 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3718DE27F0; Tue, 16 Aug 2005 00:53:20 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508151535130.3553@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 15 Aug 2005, Linus Torvalds wrote:

> I was seriously considering just breaking the "remote cvs" support
> entirely (you can always just use cvsup or something to download it to
> make it local), and just taking the RCS parsing code from GNU rcs/cvs and
> making a C language CVS importer. That would speed things up by an order
> of magnitude or more, as far as I can tell.

That may be true for many "cvs import" tasks, but not _at all_ for "cvs 
update" tasks. I, for one, keep track of _lots_ of CVS projects via 
git-cvsimport. I would hate it if I could no longer do that.

Ciao,
Dscho
