From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Trying to use AUTHOR_DATE
Date: Mon, 02 May 2005 17:38:47 -0700
Message-ID: <4276C817.3090304@zytor.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>	<42730061.5010106@zytor.com>	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>	<20050430125333.2bd81b18.froese@gmx.de>	<1114859594.24014.60.camel@localhost.localdomain>	<20050430144936.6b05cc90.froese@gmx.de>	<1114865964.24014.77.camel@localhost.localdomain>	<m3wtqhe0t6.fsf@defiant.localdomain> <4276A906.2040403@zytor.com>	<m3mzrddx44.fsf@defiant.localdomain> <4276B8A1.7070500@zytor.com> <m38y2xdubr.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	Edgar Toernig <froese@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>,
	"Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 02:36:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSlOY-0005hp-AV
	for gcvg-git@gmane.org; Tue, 03 May 2005 02:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVECAlC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 20:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVECAlB
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 20:41:01 -0400
Received: from terminus.zytor.com ([209.128.68.124]:43454 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261261AbVECAjW
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 20:39:22 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j430cmfF017842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 May 2005 17:38:49 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <m38y2xdubr.fsf@defiant.localdomain>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.5 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Krzysztof Halasa wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>No.  You cannot get 61.
> 
> I was told it would be possible if two leap seconds were needed in some
> point of time. Have never occured yet, and maybe never will.
> 
> Well, it seems it would need two seconds a month (at least 13 leap seconds
> a year) -> not in this century if ever, and it wouldn't be UTC anymore.
> 

It's certainly not permitted by the current UTC definition, which only 
allows 4 leap seconds per year.  61 comes from a typo in an old version 
of the POSIX standard.

>>You can, however, get jumps from 58 to 00.
> 
> Correct, that would be a deletion. Not yet tried, either, but they say
> it's possible.

... and permitted by the current UTC standard.

	-hpa
