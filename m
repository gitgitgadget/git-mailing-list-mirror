From: Kevin Smith <yarcs@qualitycode.com>
Subject: Dumb servers (was: [ANNOUNCE] Cogito-0.12)
Date: Thu, 07 Jul 2005 21:54:56 -0400
Message-ID: <42CDDCF0.9020906@qualitycode.com>
References: <20050703234629.GF13848@pasky.ji.cz>	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <m1vf3muwxw.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 03:56:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqi6H-0002JR-R9
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 03:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVGHB4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 21:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVGHB4L
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 21:56:11 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:37248 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S261386AbVGHB4K
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 21:56:10 -0400
Received: from [192.168.15.101] (653221hfc195.tampabay.res.rr.com [65.32.21.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id 754BD3C2B
	for <git@vger.kernel.org>; Fri,  8 Jul 2005 01:56:02 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <m1vf3muwxw.fsf@ebiederm.dsl.xmission.com>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Eric W. Biederman wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> 
>>That said, I really think the dumb protocols are useless anyway. No other 
>>system supports pure static object pulling anyway, and as far as I'm 
>>concerned, I want "rsync" to kind of work (but it won't be optimal, since 
>>re-packing will delete all the old objects and replace it with the new 
>>pack that is downloaded anew). But plain http? I'm not convinced.
> 
> 
> Have you not looked at tla/arch? tla does supports dumb servers.
> It's job is a little easier as it has one file per atomic commit
> I suspect once packs start working well that should not be an
> issue for git either.

In addition to GNU arch/tla, it it also supported by baz, ArX, darcs, 
and mercurial.

> For small projects this is a major benefit, as they can just push
> their files to a convenient http or ftp server.

Absolutely. For the kernel it might not make sense, but I view it as a 
really important feature for tiny projects around the world. Even a CGI 
requirement makes it impossible to serve a project from free or really 
cheap web hosts. Plain HTTP is the only protocol available to people who 
have no extra money to spend on hosting accounts.

This happens to be a hot button issue for me, in case you can't tell. 
Sorry if I'm ranting.

Kevin
