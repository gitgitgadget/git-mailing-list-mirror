From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 16:14:59 -0700
Message-ID: <42741173.9040507@zytor.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>	 <42730061.5010106@zytor.com>	 <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>	 <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>	 <20050430125333.2bd81b18.froese@gmx.de> <1114859594.24014.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Edgar Toernig <froese@gmx.de>, Linus Torvalds <torvalds@osdl.org>,
	"Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 03:59:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS3jA-0001qL-Th
	for gcvg-git@gmane.org; Sun, 01 May 2005 03:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVD3XPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 19:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVD3XPf
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 19:15:35 -0400
Received: from terminus.zytor.com ([209.128.68.124]:41680 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261455AbVD3XPa
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 19:15:30 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3UNF0EU000954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 30 Apr 2005 16:15:00 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114859594.24014.60.camel@localhost.localdomain>
X-Spam-Status: No, score=-5.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse wrote:
> On Sat, 2005-04-30 at 12:53 +0200, Edgar Toernig wrote:
> 
>>+       tm = localtime(&now); /* get timezone and tm_isdst */
>>+       offset = -timezone / 60;
>>+       if (tm->tm_isdst > 0)
>>+               offset += 60;
> 
> 
> Some locales have DST offsets which aren't 60 minutes, don't they?
> 

Correct.  I believe South Australia is among them.

	-hpa
