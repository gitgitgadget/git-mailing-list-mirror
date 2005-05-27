From: Danjel McGougan <danjel.mcgougan@comhem.se>
Subject: Re: [PATCH] Fix ptrdiff_t vs. int
Date: Fri, 27 May 2005 15:51:58 +0200
Message-ID: <d778gp$1er$1@sea.gmane.org>
References: <42971EB4.2050403@oberhumer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 27 16:18:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbfcy-0003Kr-MT
	for gcvg-git@gmane.org; Fri, 27 May 2005 16:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVE0ORe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 10:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVE0ORe
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 10:17:34 -0400
Received: from main.gmane.org ([80.91.229.2]:7112 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261745AbVE0ORX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 10:17:23 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DbfXP-0002Eq-1X
	for git@vger.kernel.org; Fri, 27 May 2005 16:10:11 +0200
Received: from c83-250-33-218.bredband.comhem.se ([83.250.33.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 May 2005 16:10:11 +0200
Received: from danjel.mcgougan by c83-250-33-218.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 May 2005 16:10:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-250-33-218.bredband.comhem.se
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <42971EB4.2050403@oberhumer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Markus F.X.J. Oberhumer wrote:
> This trivial patch fixes an obvious ptrdiff_t vs. int mismatch. Which
> makes we wonder why Linus isn't hitting this on his ppc64 - maybe it's
> time to start using -Werror...
> 

I think the PPC calling convention is to use registers for the first few 
parameters, so the bug probably will not surface on PPC64.

/Danjel

