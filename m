From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git.git object database at kernel.org?
Date: Mon, 25 Apr 2005 12:05:44 -0700
Message-ID: <426D3F88.9050709@zytor.com>
References: <7vhdhvstb2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504241553580.18901@ppc970.osdl.org> <426D3B01.8060408@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 21:02:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ8pk-0005II-Ai
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 21:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVDYTGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 15:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVDYTGS
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 15:06:18 -0400
Received: from terminus.zytor.com ([209.128.68.124]:64460 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262749AbVDYTGF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 15:06:05 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3PJ5nth012714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Apr 2005 12:05:50 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426D3B01.8060408@zytor.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

H. Peter Anvin wrote:
> Linus Torvalds wrote:
> 
>>    NOTE! The fact that "mktime()" seems to depend on the timezone in 
>> which    it is made seems to make this questionable. I had always 
>> assumed that    mktime would take the timezone from the "struct tm", 
>> and thus be    reliable, but somebody seems to have shown that that is 
>> not the case at    all!
> 
> No, mktime() always uses the local time zone.  It's the inverse of 
> localtime().  If you know the timezone offset (e.g. if you have a RFC 
> 2822-style date) then you're probably better off rolling your own; 
> otherwise setenv("TZ"); tzset(); mktime(); is of course also doable.
> 

BTW, curl_getdate() from libcurl is a good multiformat date parser.

	-hpa
