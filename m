From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 20:29:16 -0700
Message-ID: <20050503032916.GE22038@waste.org>
References: <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com> <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org> <20050502223002.GP21897@waste.org> <Pine.LNX.4.58.0505021540070.3594@ppc970.osdl.org> <20050503000011.GA22038@waste.org> <Pine.LNX.4.58.0505021932270.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Davidsen <davidsen@tmr.com>,
	Morten Welinder <mwelinder@gmail.com>,
	Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 05:23:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSo0M-0006aW-PN
	for gcvg-git@gmane.org; Tue, 03 May 2005 05:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVECD3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 23:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVECD3d
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 23:29:33 -0400
Received: from waste.org ([216.27.176.166]:60105 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261351AbVECD32 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 23:29:28 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j433THHJ018471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 2 May 2005 22:29:17 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j433TG9R018468;
	Mon, 2 May 2005 22:29:16 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505021932270.3594@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 07:48:29PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 2 May 2005, Matt Mackall wrote:
> > 
> > Umm.. I am _not_ calculating the SHA of the delta itself. That'd be
> > silly.
> 
> It's not silly.

The delta is not the object I care about and its representation is
arbitrary. In fact different branches will store different deltas
depending on how their DAGs get topologically sorted. The object I
care about is the original text, so that's the hash I store.

> In other words, you need to hash the metadata too. Otherwise how do you
> consistency-check the _collection_ of files?

Well naturally, I hash the metadata too. For every change, there's a
toplevel changeset hash that is the hash of the entire project state
at that time. And it's all signable and so on. Just like git and just
like Monotone.

-- 
Mathematics is the supreme nostalgia of our time.
