From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Trying to use AUTHOR_DATE
Date: Mon, 02 May 2005 16:32:49 -0700
Message-ID: <4276B8A1.7070500@zytor.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>	<42730061.5010106@zytor.com>	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>	<20050430125333.2bd81b18.froese@gmx.de>	<1114859594.24014.60.camel@localhost.localdomain>	<20050430144936.6b05cc90.froese@gmx.de>	<1114865964.24014.77.camel@localhost.localdomain>	<m3wtqhe0t6.fsf@defiant.localdomain> <4276A906.2040403@zytor.com> <m3mzrddx44.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	Edgar Toernig <froese@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>,
	"Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 01:27:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSkJs-0006rj-MX
	for gcvg-git@gmane.org; Tue, 03 May 2005 01:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVEBXdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 19:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVEBXdc
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 19:33:32 -0400
Received: from terminus.zytor.com ([209.128.68.124]:37820 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261228AbVEBXda
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 19:33:30 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j42NWnBb016533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 May 2005 16:32:51 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <m3mzrddx44.fsf@defiant.localdomain>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Krzysztof Halasa wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>It is, but you can't assume you don't have that.
> 
> 
> Yes, if you use NTP time (directly - not the system time) you can get
> second=60 (and, in theory, even 61 - not to be expected soon).
> 

No.  You cannot get 61.  You can, however, get jumps from 58 to 00.

> 
>> Either way, you just
>>treat it the same as the following second.
> 
> Sure, that's the safe way.
