From: Paul Gardiner <osronline@glidos.net>
Subject: Re: Any tricks for speeding up cvsps?
Date: Sat, 09 Feb 2008 08:32:19 +0000
Message-ID: <47AD6513.2040609@glidos.net>
References: <47AC1FDC.9000502@glidos.net> <47AC2775.5090403@viscovery.net> <47AC2AC3.6020704@glidos.net> <47AC2FF6.1030103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 09:33:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNl8v-0008Sp-NS
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 09:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbYBIIc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 03:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbYBIIc1
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 03:32:27 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:43573
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040AbYBIIc0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 03:32:26 -0500
X-Trace: 37189055/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.163.7
X-SBRS: None
X-RemoteIP: 62.241.163.7
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAEf0rEc+8aMH/2dsb2JhbACodw
X-IP-Direction: IN
Received: from blaster.systems.pipex.net ([62.241.163.7])
  by smtp.pipex.tiscali.co.uk with ESMTP; 09 Feb 2008 08:32:23 +0000
Received: from [10.0.0.24] (80-42-19-184.dynamic.dsl.as9105.com [80.42.19.184])
	by blaster.systems.pipex.net (Postfix) with ESMTP id A91E0E000084
	for <git@vger.kernel.org>; Sat,  9 Feb 2008 08:32:21 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <47AC2FF6.1030103@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73201>

Johannes Sixt wrote:
> Paul Gardiner schrieb:
>> Johannes Sixt wrote:
>>> I've used fast-export (not git-fast-export) to convert a CVS repository:
>>>
>>> http://repo.or.cz/w/fast-export.git
>>>
>>> It worked better than git-cvsimport because the repository was a real
>>> mess.
>> That looks to require going either via svn or mercurial. Is that right?
>> And if so, which did you find best?
> 
> You are right. Because I'm utterly confused. I actually used fromcvs/togit:
> 
> http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs
> 
> Please bear with me; I did this about a year ago. Sorry for the noise.
> 
> Be warned that fromcvs/togit does not convert tags.

That's amazing. Less than an hour to for the initial conversion,
and just minutes to progressively sync up.

Thanks to everyone for all the usefull feedback I've received here.

Cheers,
	Paul.
