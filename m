From: Kevin Smith <yarcs@qualitycode.com>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Tue, 19 Apr 2005 19:03:20 -0400
Message-ID: <42658E38.1020406@qualitycode.com>
References: <20050418210436.23935.qmail@science.horizon.com>	 <1113869248.23938.94.camel@orca.madrabbit.org>	 <42645969.2090609@qualitycode.com>	 <1113874931.23938.111.camel@orca.madrabbit.org>	 <4264677A.9090003@qualitycode.com> <1113950442.29444.31.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Wed Apr 20 00:59:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1gs-0000fV-QC
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVDSXDi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDSXDi
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:03:38 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:15978 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S261731AbVDSXD3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 19:03:29 -0400
Received: from [10.10.10.20] (147-49.35-65.tampabay.res.rr.com [65.35.49.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id 640513C0A;
	Tue, 19 Apr 2005 23:03:21 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
To: Ray Lee <ray-lk@madrabbit.org>
In-Reply-To: <1113950442.29444.31.camel@orca.madrabbit.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ray Lee wrote:
> On Mon, 2005-04-18 at 22:05 -0400, Kevin Smith wrote:
> 
>>Notice that just by looking at my diffs, you can't tell that I used a
>>replace operation.
> 
> 
> Here's where we disagree. If you checkpoint your tree before the
> replace, and immediately after, the only differences in the
> source-controlled files would be due to the replace. 

But I might have manually changed those tokens, or I might have done it
with a replace operation. Just looking at the diffs, those two cases
would look identical and be indistinguishable. The only way to know
whether or not a darcs replace was done was to look at the patch metadata.

Pop quiz:

Here is revision 1 of my file:

    abcde

Here is revision 2:

    wow

Now, did I do that with a darcs replace, or just by typing?

Kevin
