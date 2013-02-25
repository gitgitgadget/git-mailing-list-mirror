From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/5] Fix msvc build
Date: Mon, 25 Feb 2013 09:25:39 +0100
Message-ID: <512B2003.804@viscovery.net>
References: <510AB766.4030806@ramsay1.demon.co.uk> <7vehg4288w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:26:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9tO6-0003us-5J
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 09:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298Ab3BYIZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 03:25:46 -0500
Received: from so.liwest.at ([212.33.55.24]:36429 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754959Ab3BYIZp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 03:25:45 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1U9tNT-00065B-GY; Mon, 25 Feb 2013 09:25:39 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2ED4E1660F;
	Mon, 25 Feb 2013 09:25:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <7vehg4288w.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217046>

Am 2/25/2013 7:54, schrieb Junio C Hamano:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> As I mentioned recently, while discussing a cygwin specific patch
>> (see "Version 1.8.1 does not compile on Cygwin 1.7.14" thread), the
>> MSVC build is broken for me.
>>
>> The first 4 patches fix the MSVC build for me. The final patch is
>> not really related to fixing the build, but it removed some make
>> warnings which were quite irritating ...
>>
>> Note that I used the Makefile, with the Visual C++ 2008 command
>> line compiler on Windows XP (SP3), to build a vanilla git on MinGW.
>> I'm not subscribed to the msysgit mailing list, nor do I follow the
>> msysgit fork of git, so these patches may conflict with commits in
>> their repository.
> 
> Did anything further happen to this topic in the Windows land?

I successfully built with MSVC with these patches (but I am not using the
result anywhere nor did I attempt to run the test suite).

More importantly, I'm using git on Windows ("MinGW flavor") with these
patches in production, so there are no obvious regressions.

Feel free to add my

Tested-by: Johannes Sixt <j6t@kdbg.org>

but if you don't have the patches around, I can resend them.

-- Hannes
