From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 15:25:34 -0400 (EDT)
Message-ID: <BAYC1-PASMTP0510EEC44C7F787F27215AAE970@CEZ.ICE>
References: <E1EIVsD-0001Hu-9m@jdl.com>
    <20050922191058.GM21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Jon Loeliger" <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 21:26:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIWhP-0005vG-PM
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 21:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVIVTZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 15:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVIVTZh
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 15:25:37 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:46973 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S964843AbVIVTZg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 15:25:36 -0400
X-Originating-IP: [67.71.125.52]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([67.71.125.52]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 22 Sep 2005 12:25:03 -0700
Received: by linux1.attic.local (Postfix, from userid 48)
	id 80D89644C0E; Thu, 22 Sep 2005 15:25:34 -0400 (EDT)
Received: from 10.10.10.28
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 22 Sep 2005 15:25:34 -0400 (EDT)
Message-ID: <34462.10.10.10.28.1127417134.squirrel@linux1>
In-Reply-To: <20050922191058.GM21019@pasky.or.cz>
To: "Petr Baudis" <pasky@suse.cz>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 22 Sep 2005 19:25:03.0864 (UTC) FILETIME=[5523A780:01C5BFAB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, September 22, 2005 3:10 pm, Petr Baudis said:

> FWIW, with Cogito, interrupted or failed fetch can be safely rerun, no
> extra recovery procedure is required. It *seems* that this holds for
> git-fetch as well.

Petr,

Why doesn't cogito just use the git fetch/pull commands?   Why does it
need anything special?   It seems like cogito is doing more than just
being an ease-of-use layer above git.

Sean
