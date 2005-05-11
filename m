From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 16:40:11 -0700
Message-ID: <428297DB.8030905@zytor.com>
References: <1115847510.22180.108.camel@tglx>  <428291CD.7010701@zytor.com> <1115854733.22180.202.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:33:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW0hE-0001ls-L6
	for gcvg-git@gmane.org; Thu, 12 May 2005 01:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVEKXk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 19:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVEKXk0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 19:40:26 -0400
Received: from terminus.zytor.com ([209.128.68.124]:60600 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261321AbVEKXkW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 19:40:22 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4BNeGbP022177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 May 2005 16:40:17 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: tglx@linutronix.de
In-Reply-To: <1115854733.22180.202.camel@tglx>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thomas Gleixner wrote:
> 
> Which is complety error prone due to rsync. Some of the repositories on
> kernel.org keep identical copies of .git/description already. Why should
> they preserve an unique .git/repoid ?
> 
> There is one clean way to solve this. Managed repository id's and a lot
> of discipline.
> 
> I expect neither of those two things to happen, but a complete working
> directory path is better than nothing to make educated guesses.
> Committer names (maintainers) can be the same over repositories, but its
> unlikely that somebody who manages more than one subsystems uses the
> same working directory for them.
> 

I can tell you what would happen in at least my case: you'll see each 
"repository" with about 23 different IDs.

	-hpa
