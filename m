From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Why does git-core 0.99.7 require python 2.4?
Date: Mon, 19 Sep 2005 14:00:25 -0700
Message-ID: <432F26E9.9090707@zytor.com>
References: <432F0C66.7060402@zytor.com>	<20050919200222.GA11322@c165.ib.student.liu.se> <7vslw0lqvd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 23:00:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHSko-0002RB-Vf
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 23:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVISVAo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVISVAo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 17:00:44 -0400
Received: from terminus.zytor.com ([209.128.68.124]:53140 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932465AbVISVAn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 17:00:43 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8JL0UYT008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2005 14:00:31 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslw0lqvd.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8907>

Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
>>Not supporting one of the major Linux distributions isn't ideal
>>though, so maybe we should do something about this. I will have a look
>>at rewriting the code to not use subprocess.
> 
> Thanks -- I personally feel that it would be best to just let FC
> catch up, solving this problem for us, while you spend your time
> on other things first.
> 

The problem isn't FC, the problem is RHEL, generally used on machines 
for which an OS update it's huge deal.

> Peter, if you feel strongly about it I'd do 0.99.7.1 removing
> the 'requires python >=2.4', but as Fredrik says the only thing
> that uses Python 2.4 is his recursive merge, and it is not
> something we use without the user explicitly asking for it.  We
> can consider it as the same status as send-email or archimport
> which cannot work without Perl modules necessary for their
> operation, so if you can install bypassing requires- check that
> would work equally well.

My suggestion would be to fork off the recursive merge into a separate 
binary package which can have the python >= 2.4 requirement (unless 
Fredrik just fixes it.)

	-hpa
