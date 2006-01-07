From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 1.0.7
Date: Sat, 07 Jan 2006 13:30:28 -0800
Message-ID: <43C032F4.9030104@zytor.com>
References: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>	<20060107.021614.94523887.yoshfuji@linux-ipv6.org>	<7vsls0mns8.fsf@assigned-by-dhcp.cox.net>	<7vmzi8mkdi.fsf@assigned-by-dhcp.cox.net> <43C028CA.8090702@zytor.com> <7vlkxreo9e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 22:30:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvLe2-0005cL-IX
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 22:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbWAGVaf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 16:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbWAGVaf
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 16:30:35 -0500
Received: from terminus.zytor.com ([192.83.249.54]:40624 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1752587AbWAGVae
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 16:30:34 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k07LUSLR010020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 Jan 2006 13:30:29 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkxreo9e.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14278>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>Any reason to not just do:
>>
>> 	struct frotz {
>> 		int xyzzy;
>> 		char nitfol[1]; /* more */
>> 	};
>>
>>... which should work on all compilers?
> 
> Laziness, especially to avoid having to deal with comments like
> "your xmalloc(sizeof(struct frotz) + strlen(nitfol) + 1) should be
> xmalloc(sizeof(struct frotz) + strlen(nitfol)), because you
> have already one byte for nitfol element."
> 

In the case of strings, that's probably a blessing (already accounted 
for the null byte).

	-hpa
