From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add testcase for merging in a CRLF repo, showing that
 conflict file is in LF only
Date: Mon, 09 Jun 2008 21:44:27 +0200
Message-ID: <484D881B.1070400@trolltech.com>
References: <"Storm-Olsen*"@MHS> <26299.4828321554$1213013668@news.gmane.org> <484D3225.3020900@viscovery.net> <484D424C.3010002@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 21:45:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5nIz-0004ez-6X
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 21:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbYFIToc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 15:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbYFITob
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 15:44:31 -0400
Received: from hoat.troll.no ([62.70.27.150]:39013 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbYFITob (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 15:44:31 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id A511220ACE;
	Mon,  9 Jun 2008 21:44:25 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 6308F20ACA;
	Mon,  9 Jun 2008 21:44:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <484D424C.3010002@trolltech.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84413>

Marius Storm-Olsen said the following on 09.06.2008 16:46:
> ... Then you commit. The end result is that 
> you have a workingdir with a mix of LF and CRLF files, which after 
> some more operations may trigger a "whole file changed" diff, due to 
> the workingdir file now having LF EOLs.

..actually, it's more like applying patches and cherry-picking then 
breaks when the touch the same file, if I recall correctly.

Thanks for all the pointers, I'll send an updated patch tomorrow.

--
.marius
