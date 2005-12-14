From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Tracking files across tree reorganizations
Date: Wed, 14 Dec 2005 15:44:43 -0800
Message-ID: <43A0AE6B.3040309@zytor.com>
References: <43A08B8F.1000901@zytor.com> <20051214223656.GJ22159@pasky.or.cz> <Pine.LNX.4.64.0512141538440.3292@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 00:45:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmgJ4-0004EJ-8C
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 00:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVLNXpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 18:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbVLNXpE
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 18:45:04 -0500
Received: from terminus.zytor.com ([192.83.249.54]:10920 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965108AbVLNXpA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 18:45:00 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBENim9N019655
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Dec 2005 15:44:49 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512141538440.3292@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13660>

Linus Torvalds wrote:
> 
> On Wed, 14 Dec 2005, Petr Baudis wrote:
> 
>>Linus is against it.
>>
>>Cogito will do it anyway ;-), when someone sends me a nice patch or when
>>I get to it (probably not very soon). I imagine it like this:
> 
> I warn people that if cogito starts polluting the commit messages too 
> much, I'll stop pulling from such trees.
> 

I agree, putting that into the commit messages sounds like a pretty bad 
thing.  If anything it should go in the commit header, possibly in the 
form of an object reference (with the object carrying the actual data.)

HOWEVER, I maintain that this is unnecessary (and, as Linus has pointed 
out several time, losing) -- we already detect renames without relying 
on commit-time metadata.  If it's too expensive to generate the metadata 
on every merge, it can be cached.

	-hpa
