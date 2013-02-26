From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/5] Fix msvc build
Date: Tue, 26 Feb 2013 19:06:03 +0000
Message-ID: <512D079B.2070404@ramsay1.demon.co.uk>
References: <510AB766.4030806@ramsay1.demon.co.uk> <7vehg4288w.fsf@alter.siamese.dyndns.org> <512B2003.804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 20:08:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAPsu-0004CI-N0
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 20:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155Ab3BZTHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 14:07:49 -0500
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:46557 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758179Ab3BZTHr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 14:07:47 -0500
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 15595384088;
	Tue, 26 Feb 2013 19:07:46 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 51F1B384081;	Tue, 26 Feb 2013 19:07:45 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Tue, 26 Feb 2013 19:07:41 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <512B2003.804@viscovery.net>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217162>

Johannes Sixt wrote:
> Am 2/25/2013 7:54, schrieb Junio C Hamano:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>> As I mentioned recently, while discussing a cygwin specific patch
>>> (see "Version 1.8.1 does not compile on Cygwin 1.7.14" thread), the
>>> MSVC build is broken for me.
>>>
>>> The first 4 patches fix the MSVC build for me. The final patch is
>>> not really related to fixing the build, but it removed some make
>>> warnings which were quite irritating ...
>>>
>>> Note that I used the Makefile, with the Visual C++ 2008 command
>>> line compiler on Windows XP (SP3), to build a vanilla git on MinGW.
>>> I'm not subscribed to the msysgit mailing list, nor do I follow the
>>> msysgit fork of git, so these patches may conflict with commits in
>>> their repository.
>>
>> Did anything further happen to this topic in the Windows land?
> 
> I successfully built with MSVC with these patches (but I am not using the
> result anywhere nor did I attempt to run the test suite).
> 
> More importantly, I'm using git on Windows ("MinGW flavor") with these
> patches in production, so there are no obvious regressions.
> 
> Feel free to add my
> 
> Tested-by: Johannes Sixt <j6t@kdbg.org>

Johannes, thank you for taking the time to test these patches.

ATB,
Ramsay Jones
