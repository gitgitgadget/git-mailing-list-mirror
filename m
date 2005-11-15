From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Small script to patch .spec for Suse
Date: Tue, 15 Nov 2005 14:22:39 -0800
Message-ID: <437A5FAF.2000609@zytor.com>
References: <200511151230.30030.Josef.Weidendorfer@gmx.de> <7vfypxlp8k.fsf@assigned-by-dhcp.cox.net> <437A46E4.5010909@zytor.com> <20051115215943.GW30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 23:29:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec9Cx-0005zF-Qs
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 23:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVKOWXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 17:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVKOWXQ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 17:23:16 -0500
Received: from terminus.zytor.com ([192.83.249.54]:38829 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965042AbVKOWXQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 17:23:16 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAFMMoh8006495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Nov 2005 14:22:54 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051115215943.GW30496@pasky.or.cz>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11954>

Petr Baudis wrote:
> 
> Actually, can you have some kind of %if in specfiles? Then you could
> keep everything in the specfile and just pass it whatever system you
> want to build for.
> 

Sure.  It's called %if.  There is also %ifdef and %define.

	-hpa
