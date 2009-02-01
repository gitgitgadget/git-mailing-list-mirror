From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 4/4] Change current mailmap usage to do matching on both
 name and email of author/committer.
Date: Sun, 01 Feb 2009 08:07:12 +0100
Message-ID: <49854A20.5090208@trolltech.com>
References: <cover.1233438174.git.marius@trolltech.com> <ce94ea88e3182e97997c23f71e184e0db64fa708.1233438174.git.marius@trolltech.com> <75a7d437c1b32600c509bdef5010e6ac30b6cb08.1233438174.git.marius@trolltech.com> <f303cf305c76917a3d49767b879b0cf61578cea2.1233438174.git.marius@trolltech.com> <34f625b57597810e4c084fcd3eaf2cfd9def803e.1233438174.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 08:08:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTWRQ-00007Y-Tl
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 08:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbZBAHHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 02:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbZBAHHA
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 02:07:00 -0500
Received: from hoat.troll.no ([62.70.27.150]:58773 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbZBAHG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 02:06:59 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 6A51E20ED5
	for <git@vger.kernel.org>; Sun,  1 Feb 2009 08:06:53 +0100 (CET)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 542F520316
	for <git@vger.kernel.org>; Sun,  1 Feb 2009 08:06:53 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <34f625b57597810e4c084fcd3eaf2cfd9def803e.1233438174.git.marius@trolltech.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107978>

Marius Storm-Olsen said the following on 31.01.2009 22:48:
>  Documentation/git-shortlog.txt   |   13 +----

Obviously the correcting parts to the git-shortlog documentation 
should be folded into PATCH 3. I'll do that later.

--
.marius
