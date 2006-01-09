From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [ANNOUCNE] GIT 1.1.0
Date: Tue, 10 Jan 2006 01:55:14 +0200
Message-ID: <43C2F7E2.4090909@cc.jyu.fi>
References: <7v4q4eurgu.fsf@assigned-by-dhcp.cox.net>	<43C2CAED.8030304@cc.jyu.fi> <7vwth9f1nk.fsf@assigned-by-dhcp.cox.net>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 00:49:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew6lf-0004de-3Z
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 00:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWAIXtb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 18:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWAIXtb
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 18:49:31 -0500
Received: from posti5.jyu.fi ([130.234.4.34]:2177 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S1750754AbWAIXtb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 18:49:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti5.jyu.fi (8.13.4/8.13.4) with ESMTP id k09NnP2S007684;
	Tue, 10 Jan 2006 01:49:25 +0200
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi [130.234.182.44])
	by posti5.jyu.fi (8.13.4/8.13.4) with ESMTP id k09NnLKU007679;
	Tue, 10 Jan 2006 01:49:22 +0200
Received: from [127.0.0.1] (aragorn.kortex.jyu.fi [127.0.0.1])
	by aragorn.kortex.jyu.fi (Postfix) with ESMTP id 71A4E468169;
	Tue, 10 Jan 2006 01:55:14 +0200 (EET)
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwth9f1nk.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14391>


>Ah, sorry, and thanks for catching this.  RPM building procedure
>is somewhat tricky, and I failed to catch this bug.  Fixed in my
>tree --- this calls for an early 1.1.1 release I guess.
>
>On the other hand, if you are building from the source, what
>Andreas said applies, and in addition you need to fetch v1.1.0
>tag before building; otherwise the versioning mechanism would not
>notice you are building v1.1.0.
>  
>
I was not using git for fetching git sources,
I have build from the git 1.1.0.tar.bz2.

Did you mean that things should work after 1.1.1 is released?
I tried to fresh build and install of 1.1.0 on top of the previous
1.1.0 build but "git --version" is still displaying me "git version 1.0.GIT"

Mika
