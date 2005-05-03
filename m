From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 21:18:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505022116080.3594@ppc970.osdl.org>
References: <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com>
 <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org> <20050502223002.GP21897@waste.org>
 <Pine.LNX.4.58.0505021540070.3594@ppc970.osdl.org> <20050503000011.GA22038@waste.org>
 <Pine.LNX.4.58.0505021932270.3594@ppc970.osdl.org> <20050503032916.GE22038@waste.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Davidsen <davidsen@tmr.com>,
	Morten Welinder <mwelinder@gmail.com>,
	Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 06:10:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSojz-0003oY-PM
	for gcvg-git@gmane.org; Tue, 03 May 2005 06:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVECEQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 00:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVECEQi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 00:16:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:61386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261374AbVECEQb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 00:16:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j434GNs4006645
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 21:16:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j434GLv3007030;
	Mon, 2 May 2005 21:16:22 -0700
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050503032916.GE22038@waste.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 2 May 2005, Matt Mackall wrote:
> 
> The delta is not the object I care about and its representation is
> arbitrary. In fact different branches will store different deltas
> depending on how their DAGs get topologically sorted. The object I
> care about is the original text, so that's the hash I store.

Ok. In that case, it sounds like you're really doing everything git is
doing, except your "blob" objects effectively can have pointers to a
previous object (and you have a different on-disk representation)?  Is
that correct?

			Linus
