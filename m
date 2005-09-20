From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Ship our own copy of subprocess.py
Date: Tue, 20 Sep 2005 10:56:50 -0700
Message-ID: <43304D62.4010403@zytor.com>
References: <432F0C66.7060402@zytor.com>	<20050919200222.GA11322@c165.ib.student.liu.se>	<7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com>	<7v7jdclpme.fsf@assigned-by-dhcp.cox.net> <432F3253.3070201@zytor.com>	<20050919231704.GA19276@unpythonic.net> <432F48C7.8070405@zytor.com>	<7v8xxsebsc.fsf@assigned-by-dhcp.cox.net>	<7vfys0cpyj.fsf_-_@assigned-by-dhcp.cox.net>	<20050920061413.GP8041@shell0.pdx.osdl.net> <7vll1s6yao.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chris Wright <chrisw@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 19:59:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHmMv-00046D-So
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 19:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVITR5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 13:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVITR5X
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 13:57:23 -0400
Received: from terminus.zytor.com ([209.128.68.124]:12719 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964781AbVITR5X
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 13:57:23 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8KHus9s004253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Sep 2005 10:56:55 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll1s6yao.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9012>

Junio C Hamano wrote:
> Chris Wright <chrisw@osdl.org> writes:
> 
> 
>>Sorry I don't think this one will work.  It's not going to install
>>compat/subprocess.py, and if it did, I don't think it'd be able to import
>>(how will it find subprocess.py?).
> 
> 
> My intent can be found out if you do this:
> 
>     $ make
>     $ diff -u git-merge-recursive.py git-merge-recursive
>     $ grep -C3 GIT_PYTHON_ Makefile
> 

Seems to work as far as I can tell.

	-hpa
