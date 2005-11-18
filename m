From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Small script to patch .spec for Suse
Date: Thu, 17 Nov 2005 21:11:48 -0800
Message-ID: <437D6294.8020003@zytor.com>
References: <200511151230.30030.Josef.Weidendorfer@gmx.de> <20051115215943.GW30496@pasky.or.cz> <437A5FAF.2000609@zytor.com> <200511160232.15162.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 06:13:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcyXc-0004IA-Vl
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 06:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVKRFL5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 00:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVKRFL5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 00:11:57 -0500
Received: from terminus.zytor.com ([192.83.249.54]:63122 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932487AbVKRFL4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 00:11:56 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAI5BmVM023836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Nov 2005 21:11:49 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511160232.15162.Josef.Weidendorfer@gmx.de>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12200>

Josef Weidendorfer wrote:
> On Tuesday 15 November 2005 23:22, H. Peter Anvin wrote:
> 
>>Sure.  It's called %if.  There is also %ifdef and %define.
> 
> 
> So by replacing @@FOR_SUSE@@ to 0 or 1 in the Makefile, this: 
> 
>  %if @@FOR_SUSE@@
>  BuildRequires: openssh ...
>  %else
>  BuildRequires: openssh-clients ...
>  %endif
> 
> would work?
> 

SuSE might even have defined a distribution-specific macro that one can 
key off of.  Some SuSE expert would have to comment.

	-hpa
