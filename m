From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-core-foo -> git-foo, except the core package
Date: Tue, 15 Nov 2005 19:05:41 +0100
Message-ID: <437A2375.7020609@op5.se>
References: <43797C41.2050809@zytor.com>	 <625fc13d0511150641k353d7128pf72f3542da601104@mail.gmail.com>	 <437A09F2.8080109@zytor.com> <625fc13d0511150919l48786dcam6fda56bc9d3a9fa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 15 19:13:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec5Bj-00049G-6B
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 19:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVKOSFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 13:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVKOSFo
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 13:05:44 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:61628 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S964965AbVKOSFn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 13:05:43 -0500
Received: from vrrx50sn1.teliamobile.net (192.71.148.196) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 4378EBDA000606B1 for git@vger.kernel.org; Tue, 15 Nov 2005 19:05:42 +0100
Received: from [212.181.228.90] (host-n13-90.homerun.telia.com [212.181.228.90])
	by vrrx50sn1.teliamobile.net (8.11.6/8.11.6) with ESMTP id jAFI5gf23106
	for <git@vger.kernel.org>; Tue, 15 Nov 2005 19:05:42 +0100
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <625fc13d0511150919l48786dcam6fda56bc9d3a9fa0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11928>

Josh Boyer wrote:
> On 11/15/05, H. Peter Anvin <hpa@zytor.com> wrote:
> 
>>Josh Boyer wrote:
>>
>>>What about "yum remove git" ?  I don't think that will work quite so
>>>well.  The "git" package will be removed just fine since nothing
>>>depends on it, but git-<foo> will still remain.  Maybe not that big of
>>>a deal, but it might not be obvious to some.
>>
>>True.  If you have a solution to that, I'd love to hear it.  Note that
>>having the core package depend on everything else is not acceptable.
> 
> 
> %preun section that does rpm -e of the packages it brings in.  But
> that is a hack that would cause some to become violently ill.  Perhaps
> it's an issue not worth worrying about.
> 

Less puky while bringing some obviousity:

%preun
echo "To get rid of git completely, yada yada (real instructions)."

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
