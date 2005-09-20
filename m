From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix git-init-db creating crap directories (zeroth try)
Date: Mon, 19 Sep 2005 20:27:32 -0700
Message-ID: <432F81A4.10107@zytor.com>
References: <200509172141.31591.dtor_core@ameritech.net> <432F0D1B.60303@zytor.com> <20050919194445.GD18320@pasky.or.cz> <432F46BE.5000406@zytor.com> <20050919234030.GI18320@pasky.or.cz> <432F50BC.5000304@zytor.com> <20050920000731.GJ18320@pasky.or.cz> <432F5345.3020303@zytor.com> <20050920001949.GL18320@pasky.or.cz> <432F5B07.2060803@zytor.com> <20050920015154.GA25115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 05:29:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHYne-0000U5-So
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 05:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVITD2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 23:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVITD2A
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 23:28:00 -0400
Received: from terminus.zytor.com ([209.128.68.124]:42214 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964853AbVITD17
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 23:27:59 -0400
Received: from [172.27.3.248] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8K3RWCs020122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2005 20:27:34 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050920015154.GA25115@pasky.or.cz>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8962>

Petr Baudis wrote:
>>
>>But if len is the index of the '/', then you're not.
> 
> But fortunately len is not the index of the '/', len-1 is. len is the length
> of the leading path fragment including the trailing slash.
> 

Then you'd need len-1 both inside the memcpy() and the assignment, of 
course.

	-hpa
