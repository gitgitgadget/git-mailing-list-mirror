From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] tests: added d2u to have unix style testfiles even in textmode
Date: Wed, 8 Aug 2007 07:00:09 +0200
Message-ID: <98CEB25C-A1ED-4F6C-B6F4-70310B819C1E@zib.de>
References: <A80CCC35-DE1E-4A0B-9144-A8165AF6C98A@zib.de> <11865269472595-git-send-email-prohaska@zib.de> <11865269472121-git-send-email-prohaska@zib.de> <alpine.LFD.0.999.0708071959470.23971@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 06:59:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIdeD-0000le-TU
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 06:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbXHHE7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 00:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbXHHE7r
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 00:59:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:65215 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417AbXHHE7q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 00:59:46 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l784xLha029741;
	Wed, 8 Aug 2007 06:59:21 +0200 (CEST)
Received: from [192.168.178.32] ([77.177.245.231])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l784xKB2009123
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 8 Aug 2007 06:59:21 +0200 (MEST)
In-Reply-To: <alpine.LFD.0.999.0708071959470.23971@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55300>


On Aug 8, 2007, at 5:03 AM, Linus Torvalds wrote:

> On Wed, 8 Aug 2007, Steffen Prohaska wrote:
>>
>> This is needed if the content of files is compared with
>> precomputed sha1s or stored expected results.
>>
>> ***WARNING***
>> This patch is useful for testing and illustrating the problem
>> but not thought to be applied to any official git branch.
>
> Quite frankly, *much* rather than having d2u everywhere, why not  
> make the
> default for DOS/Windows be to have
>
> 	[core]
> 		autocrlf=true
>
> and then none of this should hopefully be needed.

Thanks for that idea. I'll check how far I can get with it.

	Steffen
