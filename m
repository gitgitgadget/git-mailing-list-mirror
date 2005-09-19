From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Why does git-core 0.99.7 require python 2.4?
Date: Mon, 19 Sep 2005 14:33:10 -0700
Message-ID: <432F2E96.1040307@zytor.com>
References: <432F0C66.7060402@zytor.com>	<20050919200222.GA11322@c165.ib.student.liu.se>	<7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com> <7v7jdclpme.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 23:35:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHTGR-0003rW-GV
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 23:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbVISVdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 17:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbVISVdY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 17:33:24 -0400
Received: from terminus.zytor.com ([209.128.68.124]:64990 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932708AbVISVdX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 17:33:23 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8JLXFNm010022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2005 14:33:15 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jdclpme.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8911>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>My suggestion would be to fork off the recursive merge into a separate 
>>binary package which can have the python >= 2.4 requirement (unless 
>>Fredrik just fixes it.)
> 
> 
> It sounds like the right thing to do, not that I know much about
> how RPM world deals with situations like this (aside from what I
> learnt from the list).  If we go this route probably we should
> the same for gitk and git-send-email as well?

Yes, that probably would make sense, at least for gitk.

I'll try to work on the spec file.  It's a bit messier than I'd like, 
because a whole bunch of wildcard patterns don't work anymore.

	-hpa
