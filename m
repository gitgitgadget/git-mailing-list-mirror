From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Fri, 20 Feb 2009 23:04:47 +0100
Message-ID: <499F28FF.30905@trolltech.com>
References: <499EC48B.9070004@trolltech.com> <alpine.DEB.1.00.0902201734450.6302@intel-tinevez-2-302> <200902201746.15242.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	spearce@spearce.org, Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 20 23:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LadVf-0005YG-IB
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 23:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbZBTWEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 17:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbZBTWEr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 17:04:47 -0500
Received: from hoat.troll.no ([62.70.27.150]:35743 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbZBTWEq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 17:04:46 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 0418E20FAA;
	Fri, 20 Feb 2009 23:04:45 +0100 (CET)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id C034920EDF;
	Fri, 20 Feb 2009 23:04:44 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.5.666
In-Reply-To: <200902201746.15242.trast@student.ethz.ch>
X-Enigmail-Version: 0.95.7
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110896>

Thomas Rast said the following on 20.02.2009 17:46:
> Johannes Schindelin wrote:
>> On Fri, 20 Feb 2009, Marius Storm-Olsen wrote:
>>> +		local c
>>> +		+		if test "$(git config --bool core.bare)" ==
>>> "true"; then
>> Indeed, it seems that this got mangled, unfortunately.
> 
> Actually it seems the patch itself is fine, but the mail is still 
> flagged format=flowed, so f=f-aware readers will mangle it on
> display.

Hmm, it looks ok for me as well, though I do see the incorrect 
format=flowed for this unflowed mail. I think it's one of my other 
extensions causing this, but I'm not sure. I need to disable them to 
check.


> It conflicts with e5dd864 (completion: Better __git_ps1 support
> when not in working directory, 2009-02-11) however, which is on
> next.

Ok, I think I was based on master. I'll rebase and do fixups on Monday.

Thanks!

--
.marius
