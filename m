From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Sat, 14 May 2005 04:34:57 +0200
Message-ID: <1116038097.9317.11.camel@dhcp-188.off.vrfy.org>
References: <20050511012626.GL26384@pasky.ji.cz>
	 <20050513120618.GA26263@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 04:35:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWmUq-0004bU-B1
	for gcvg-git@gmane.org; Sat, 14 May 2005 04:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVENCfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 22:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVENCe7
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 22:34:59 -0400
Received: from soundwarez.org ([217.160.171.123]:22668 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262681AbVENCe6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 22:34:58 -0400
Received: from dhcp-188.off.vrfy.org (c211149.adsl.hansenet.de [213.39.211.149])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 7539D288A7;
	Sat, 14 May 2005 04:34:56 +0200 (CEST)
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20050513120618.GA26263@diku.dk>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-13 at 14:06 +0200, Jonas Fonseca wrote:
> I don't know if this is intentional, but it looks like gitweb discards
> everything after the first line starting with 'Signed-off-by:' on the
> log page. This will in some cases remove valuable log information when
> a second author or the committer adds additional comments to a commit:
> 
>         <log message by author>
> 
>         Signed-off-by: <author>
> 
>         <log message by committer>
> 
>         Signed-off-by: <committer>
> 
> The commit page gets it right, which is why I suspect it might just be a
> way to trim the amount of text on the log page.
> 
> I also noticed that there is a 'faulty' signed-off-by line in commit
> 14ebb908e10f068dc1901d35f4b716bc69143d19 in case the above is
> intentional. Dunno if that should be matched by relaxing the regexp a
> little.

All that should work now.

Thanks,
Kay

