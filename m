From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Thu, 27 Oct 2005 22:22:08 -0700
Message-ID: <4361B580.9090100@zytor.com>
References: <E1EVKmt-0003xn-00@gondolin.me.apana.org.au> <4361A5BB.5040100@zytor.com> <20051028043211.GA781@gondor.apana.org.au> <4361AA56.2090906@zytor.com> <20051028045837.GA1167@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, smurf@smurf.noris.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 07:24:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVMiJ-0006vg-1M
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 07:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVJ1FW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 01:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVJ1FW7
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 01:22:59 -0400
Received: from terminus.zytor.com ([192.83.249.54]:44222 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965100AbVJ1FW7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 01:22:59 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9S5M8Qi027995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Oct 2005 22:22:09 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20051028045837.GA1167@gondor.apana.org.au>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10760>

Herbert Xu wrote:
> On Thu, Oct 27, 2005 at 09:34:30PM -0700, H. Peter Anvin wrote:
> 
>>>Perhaps you could use dash for your project as well?
>>
>>Depends on how big it is.
> 
> 
> I just noticed that you were building it with -Os.  So I built
> dash with -Os and this is what I get:
> 
> $ size dash
>    text    data     bss     dec     hex filename
>   64397     884   10240   75521   12701 dash
> $ size klibc-1.1.1/ash/sh.shared
>    text    data     bss     dec     hex filename
>   66237     424   70908  137569   21961 klibc-1.1.1/ash/sh.shared
> 
> So it looks like as long as dash can link with klibc then:
> 
> 1) It should be smaller in size.
> 2) It should be more stable due to much wider testing coverage (Debian).
> 3) You get some extra bells & whistles thrown in for free like printf.
> 
> I'll let you know when I have a version that links with klibc.
> 
> Cheers,

Cool, thanks!

	-hpa
