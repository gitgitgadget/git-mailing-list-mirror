From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Ship our own copy of subprocess.py
Date: Mon, 19 Sep 2005 21:41:16 -0700
Message-ID: <432F92EC.40007@zytor.com>
References: <432F0C66.7060402@zytor.com>	<20050919200222.GA11322@c165.ib.student.liu.se>	<7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com>	<7v7jdclpme.fsf@assigned-by-dhcp.cox.net> <432F3253.3070201@zytor.com>	<20050919231704.GA19276@unpythonic.net> <432F48C7.8070405@zytor.com>	<7v8xxsebsc.fsf@assigned-by-dhcp.cox.net> <7vfys0cpyj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 06:43:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHZwh-0004YX-QV
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 06:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVITEl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 00:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVITEl3
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 00:41:29 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:41113 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S964884AbVITEl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 00:41:28 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8K4fGJv022169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2005 21:41:18 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfys0cpyj.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8974>

Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> 
>> - merge-recursive not requiring 2.4 but checking the result
>>   from 'import subprocess', and optionally install its own
>>   subprocess.py (I could do this myself but Fredrik could help
>>   me);
> 
> 
> I'll be cutting 0.99.7a with this, to help RHEL instalation.
> Proofreading appreciated.
> 

Let me know when you've checked it into the repository, and I'll try 
running "make rpm" on the affected systems.

	-hpa
