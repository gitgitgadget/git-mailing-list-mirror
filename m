From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Val Henson's critique of hash-based content storage systems
Date: Fri, 29 Apr 2005 13:14:09 -0700
Message-ID: <42729591.8020108@zytor.com>
References: <loom.20050429T015434-928@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:25:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRc2l-0006w4-UD
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbVD2UUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVD2US3
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:18:29 -0400
Received: from terminus.zytor.com ([209.128.68.124]:5819 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262942AbVD2UOV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:14:21 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3TKEFUm013947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Apr 2005 13:14:15 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Rob Jellinghaus <robj@unrealities.com>
In-Reply-To: <loom.20050429T015434-928@post.gmane.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Rob Jellinghaus wrote:
> I assume most people here have read this, but just in case:
> 
> http://www.usenix.org/events/hotos03/tech/full_papers/henson/henson.pdf
> 

I have to pull out the big flamethrower, especially against someone I 
consider a friend, but that paper is a classic example on how many 
people don't understand probability.

The *only* valid criticism in it is that we may not know enough about 
the future validity of cryptographic hash function, however, she also 
does not analyze the failure scenarios applicable to those kinds of 
failures barely at all.

In the end, the whole paper centers around "this makes me feel nervous", 
without really justifying it in any reasonable way.

It is just one of many papers on cryptoanalysis written by someone with 
no real background in the field.  It really saddens me to see someone 
like Val fall into that particular trap.

	-hpa
