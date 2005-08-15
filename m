From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git reveals a bug in (some versions) BSD diff
Date: Tue, 16 Aug 2005 01:02:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508160100100.26231@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.44.0508130335300.2136-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 01:03:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4nyF-0000Mf-2n
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 01:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVHOXCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 19:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVHOXCQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 19:02:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:2784 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932312AbVHOXCP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 19:02:15 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3FEB7E2828; Tue, 16 Aug 2005 01:02:14 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 224A4B08A1; Tue, 16 Aug 2005 01:02:14 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 07A4EAD0CB; Tue, 16 Aug 2005 01:02:14 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ABB92E2828; Tue, 16 Aug 2005 01:02:13 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Brad Roberts <braddr@puremagic.com>
In-Reply-To: <Pine.LNX.4.44.0508130335300.2136-100000@bellevue.puremagic.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 13 Aug 2005, Brad Roberts wrote:

> I'm seeing this on a standard os/x 10.3.9 install which seems to have an
> old, but still GNU based, diff.
> 
> $ which diff
> /usr/bin/diff
> 
> $ diff --version
> diff - GNU diffutils version 2.7

That is exactly the same as with 10.2.8.

> [...] 
> * FAIL 9: apply diff between 2 and 3
>         git-apply <diff.2-3 && diff frotz.3 frotz
> * FAIL 12: apply diff between 3 and 2
>         git-apply <diff.3-2 && diff frotz.2 frotz

Yes, that is what I saw, too. Actually, I found the bug in diff-v2.7 
annoying enough that I updated (just diff) to version 2.8.1. That works 
fine.

Ciao,
Dscho
