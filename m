From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: commit-id fails after cg-init
Date: Thu, 05 May 2005 23:06:03 -0400
Message-ID: <427ADF1B.5000101@dwheeler.com>
References: <1115150585.28520.11.camel@dv> <20050503211301.GA15995@pasky.ji.cz> <4278E6D4.6060807@dwheeler.com> <200505051122.03111.snake@penza-gsm.ru>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 04:56:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTt14-0001hi-DQ
	for gcvg-git@gmane.org; Fri, 06 May 2005 04:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVEFDDR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 23:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVEFDDR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 23:03:17 -0400
Received: from aibo.runbox.com ([193.71.199.94]:21639 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262207AbVEFDDN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 23:03:13 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DTt7R-0001xK-8w; Fri, 06 May 2005 05:03:13 +0200
Received: from [70.21.9.158] (helo=[192.168.2.73])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DTt7Q-0006qt-8O; Fri, 06 May 2005 05:03:13 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Alexey Nezhdanov <snake@penza-gsm.ru>
In-Reply-To: <200505051122.03111.snake@penza-gsm.ru>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I said:
>>There's an interesting side-effect of this; I _think_ it's
>>fine but it might be worth thinking through. If all
>>new projects start with an empty tree, that creates a
>>"common root" that all projects can appeal to.
>>That means that in theory a merge between any two project root
>>trees can eventually find a common ancestor: the empty tree.
>>I _think_ that's okay... is it?

Alexey Nezhdanov wrote:
> I think this problem can be easily solved with:
> 1) Restricting to auto-select empty commit as the merge base
> 2) Make an exception from rule (1) for first real commit

Okay, but that's only true if this is really a problem.
I'm not sure it _is_, in fact I think the semantics make perfect sense.
I just wanted to note that as the kind of change
that MIGHT have a surprising side-effect, so if anyone knew of one,
please speak up!

> By (1) we will restrict accidental bad merges that can happen due to crasy 
> operator - he will need to explicitly select empty commit as merge base.

Is that really a problem, though?  It seems to me that since a
bad merge can be undone, it's not really a problem.

--- David A. Wheeler
