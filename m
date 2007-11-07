From: James <jtp@nc.rr.com>
Subject: Re: git push refspec problem
Date: Wed, 7 Nov 2007 10:30:33 -0500
Message-ID: <607586B5-7BA0-4018-9FB1-691C5E78D550@nc.rr.com>
References: <7B37E361-9606-447C-B853-001182688AFA@nc.rr.com> <Pine.LNX.4.64.0711071510480.4362@racer.site> <4731D852.2080500@hackvalue.de>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:31:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipmrq-0003PN-2C
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbXKGPag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbXKGPag
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:30:36 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:44974 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbXKGPaf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:30:35 -0500
Received: from [192.168.1.252] (really [75.182.108.180])
          by cdptpa-omta02.mail.rr.com with ESMTP
          id <20071107153034.UZQY26419.cdptpa-omta02.mail.rr.com@[192.168.1.252]>;
          Wed, 7 Nov 2007 15:30:34 +0000
In-Reply-To: <4731D852.2080500@hackvalue.de>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63826>


On Nov 7, 2007, at 10:22 AM, Johannes Gilger wrote:

> Johannes Schindelin wrote:
>> Hi,
>>
>> On Wed, 7 Nov 2007, James wrote:
>>
>>>       fetch = +refs/heads/*:refs/remotes/origin/*
>>
>> This is a refspec.
>>
>>>       push = ssh://james@my.server.com/home/james/scm/git/project.git/
>>
>> This is a URL.  It does not specify any refs.  But "push =" expects  
>> a URL.
>
> I think Johannes meant to say "But 'push =' expects a refspec." (the
> manpage even says so).
>
> About your problem: If you want to pull from a git:// repository and
> push to another with ssh:// (or in general when having two different
> repositories for pushing and fetching) in my novice understanding
> you would need two remotes. In your case, can't you just use your
> ssh-url for fetching as well?
>
> Regards,
> Jojo


I guess I could use my ssh url for pulling, as well.  I simply figured  
it would be easier to add an ssh URL for push (like I was doing  
manually) and be done with it.  But it doesn't seem there's a super  
simple solution (i.e., my syntax was wrong in the config file) to  
using git for pull and ssh for push.

.james


> -- 
> Johannes Gilger <heipei@hackvalue.de>
> http://hackvalue.de/heipei/
> GPG-Key: 0x42F6DE81
> GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
