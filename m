From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: cygwin: t3200-branch.sh fails with "List form of pipe open not
 implemented at -e line 22."
Date: Fri, 14 Oct 2005 10:57:29 -0700
Message-ID: <434FF189.3080806@zytor.com>
References: <81b0412b0510140546ya10bc8fg3dd5eaab429eba6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 19:59:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQToc-0002Re-SF
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 19:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVJNR5z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 13:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVJNR5z
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 13:57:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:7832 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750789AbVJNR5y
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 13:57:54 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9EHvYYp008482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Oct 2005 10:57:34 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0510140546ya10bc8fg3dd5eaab429eba6f@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10119>

Alex Riesen wrote:
> Now, how broken is that:
> 
> The message comes from one of the hooks, which are executed even
> though they never meant to, because cygwin apparently uses file
> content or name to detect executability (on FAT).
> 
> I just remove the hooks from repositories atm.

I think the bottom line is "don't use FAT".

	-hpa
