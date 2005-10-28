From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Thu, 27 Oct 2005 21:34:30 -0700
Message-ID: <4361AA56.2090906@zytor.com>
References: <E1EVKmt-0003xn-00@gondolin.me.apana.org.au> <4361A5BB.5040100@zytor.com> <20051028043211.GA781@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, smurf@smurf.noris.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 06:39:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVLyY-00064u-Ad
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 06:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbVJ1EgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 00:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbVJ1EgK
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 00:36:10 -0400
Received: from terminus.zytor.com ([192.83.249.54]:61624 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965088AbVJ1EgJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 00:36:09 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9S4YVI4026881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Oct 2005 21:34:31 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20051028043211.GA781@gondor.apana.org.au>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10758>

Herbert Xu wrote:
> On Thu, Oct 27, 2005 at 09:14:51PM -0700, H. Peter Anvin wrote:
> 
>>Current ash also has these features, and is about that size compiled 
>>static with klibc :)
> 
> 
> Interesting.  I just tried it on my POSIX testsuite and unfortunately
> it failed a number of simple tests including the case statement and
> segfaulted on quite a few occasions too.  I've included one of the
> segfault scripts here.
> 
> Dash is already used in busybox where it has been linked with ulibc.
> So it can't be that hard to make it work with klibc.
> 
> Perhaps you could use dash for your project as well?
> 

Depends on how big it is.

	-hpa
