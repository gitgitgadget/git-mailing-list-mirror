From: Yakup Akbay <yakbay@ubicom.com>
Subject: Re: Compact view of history in gitk
Date: Tue, 29 Sep 2009 15:44:19 +0300
Message-ID: <4AC20123.20809@ubicom.com>
References: <4AC1F435.4030802@ubicom.com> <4AC1F88E.7080802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 29 14:48:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msc7q-0006Zd-C6
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 14:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbZI2MsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 08:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbZI2MsD
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 08:48:03 -0400
Received: from server70b.appriver.com ([74.205.4.150]:3066 "EHLO
	server70.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754046AbZI2MsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 08:48:03 -0400
X-Greylist: delayed 15385 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2009 08:48:02 EDT
X-Policy: GLOBAL - ubicom.com
X-Policy: GLOBAL - ubicom.com
X-Primary: yakbay@ubicom.com
X-Note: This Email was scanned by AppRiver SecureTide
X-Virus-Scan: V-
X-Note: TCH-CT/SI:0-186/SG:2 9/29/2009 8:47:46 AM
X-GBUdb-Analysis: 0, 216.112.109.98, Ugly c=0.73166 p=-0.891089 Source Normal
X-Signature-Violations: 0-0-0-2292-c
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 216.112.109.98
X-Note-Reverse-DNS: 216.112.109.98.ptr.us.xo.net
X-Note-WHTLIST: yakbay@ubicom.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 115 116 117 118 122 123 220 
X-Note: Mail Class: VALID
X-Note: Headers Injected
Received: from [216.112.109.98] (HELO stork.scenix.com)
  by server70.appriver.com (CommuniGate Pro SMTP 5.2.16)
  with ESMTP id 103838186; Tue, 29 Sep 2009 08:47:57 -0400
Received: from [172.18.200.172] ([172.18.200.172]) by stork.scenix.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 29 Sep 2009 05:41:33 -0700
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4AC1F88E.7080802@viscovery.net>
X-OriginalArrivalTime: 29 Sep 2009 12:41:33.0640 (UTC) FILETIME=[2D21A480:01CA4102]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129297>

Johannes Sixt wrote:
> Yakup Akbay schrieb:
>   
>> Think of the gitk version of the history below:
>>
>>                  E-*-*-*-F
>>                 /
>> A-*-*-*-*-*-*-B-C-*-*-*-D
>>               \
>>                G-*-*-H-*-*-*-I
>>                       \
>>                        J-*-*-*-*-*-K
>>
>>
>> I want an output like this:
>>
>>        E-~-F
>>       /
>> A-~-B-C-~-D
>>     \
>>      G-~-H-~-I
>>           \
>>            J-~-K
>>
>> Is there an option in gitk (or in any other tool) to get such a view?
>>     
>
> I think, --simplify-by-decoration comes close, even though it may not be
> 100% what you describe.
>
> -- Hannes
>   

Thanks Hannes, this is exactly what I need!

Yakup
