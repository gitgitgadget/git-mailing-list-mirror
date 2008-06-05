From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Thu, 05 Jun 2008 22:36:18 +0200
Message-ID: <48484E42.8050209@trolltech.com>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com> <alpine.DEB.1.00.0806051946100.21190@racer> <d45085aa0806051308y16bcca95xad126022fd3ee053@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Cedric Vivier <cedricv@neonux.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 22:37:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MBy-00013m-6G
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbYFEUfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbYFEUfT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:35:19 -0400
Received: from hoat.troll.no ([62.70.27.150]:51133 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033AbYFEUfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:35:18 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 5B3ED203FC;
	Thu,  5 Jun 2008 22:35:12 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 7327E2038E;
	Thu,  5 Jun 2008 22:35:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <d45085aa0806051308y16bcca95xad126022fd3ee053@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83966>

Cedric Vivier said the following on 05.06.2008 22:08:
> On Thu, Jun 5, 2008 at 8:47 PM, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
>> What about people preferring the status quo?  I think a command
>> line option would be in order.
> 
> Is there really people preferring the status quo ? ;) Of course we
> probably need some debate about making it default or not but you're
> completely right there should be an option about that - and maybe a
> config variable as well? How about
> --sort=ascending|descending|natural (with branch.sort as the 
> corresponding config var) ?

IMO, we now need to step back, and start considering the ever 
expanding complexity of all the Git command line options. Is there 
_really_ a need for a command line option to control this? Will people 
_really_, for that _one_ invocation change the order of file listing? 
Or, will they simply prefer one particular order, set it, and forget it?

We really need to analyze the use-cases, and do everything we can to 
avoid confusing clutter.

IMO this feature falls into the "configuration-variable, but not 
command-line option" category. (People who _really_ want a different 
order, for that _one_ invocation, are most probable also in the group 
that can write their own little 3-line script to do this.)

Just my 10NOK..

--
.marius
