From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Tracking files across tree reorganizations
Date: Wed, 14 Dec 2005 17:02:13 -0800
Message-ID: <43A0C095.20708@zytor.com>
References: <43A08B8F.1000901@zytor.com> <20051214223656.GJ22159@pasky.or.cz>	<Pine.LNX.4.64.0512141538440.3292@g5.osdl.org>	<43A0AE6B.3040309@zytor.com> <7vd5jzurfi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 02:03:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmhVw-00021S-9x
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 02:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVLOBC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 20:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbVLOBC3
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 20:02:29 -0500
Received: from terminus.zytor.com ([192.83.249.54]:34968 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965134AbVLOBC3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 20:02:29 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBF12Iej021396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Dec 2005 17:02:18 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5jzurfi.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13667>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>HOWEVER, I maintain that this is unnecessary (and, as Linus has pointed 
>>out several time, losing) -- we already detect renames without relying 
>>on commit-time metadata.  If it's too expensive to generate the metadata 
>>on every merge, it can be cached.
> 
> 
> I agree; I was wondering why you brought it up again.
> 

Just because of Petr's comment about adding stuff to commit messages.

	-hpa
