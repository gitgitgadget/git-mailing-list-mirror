From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-daemon: path validation, export all option
Date: Tue, 27 Sep 2005 09:14:49 -0700
Message-ID: <43396FF9.1000900@zytor.com>
References: <4338AACC.1050305@zytor.com> <7vslvr6t1u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 18:19:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKI73-00032o-MZ
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 18:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVI0QPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 12:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVI0QPF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 12:15:05 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:44499 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S964922AbVI0QPD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 12:15:03 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8RGEnJv025938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Sep 2005 09:14:50 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslvr6t1u.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9403>

Junio C Hamano wrote:
> 
> A microNit.  You could lose 'int ok' and return 1 directly where
> you assign 1 to it and break.
> 

I guess I personally prefer the coding style where the straigh-line flow 
of control is the normal one.  It prevents the "oops" of someone wanting 
to add code to it later.

> 
>>-	chdir(".git");
> 
> I am unsure about this removal of "minor convenience feature".
> Although I do not think git-daemon is widely used on the field,
> this change breaks existing setup if there is any.

I have restored this and make the requested RPM changes.  I have left a 
pullable tree at:

master.kernel.org:/home/hpa/git/daemon.git

... in order to preserve the commit structure.

	-hpa
