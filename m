From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] t3070: Disable some failing fnmatch tests
Date: Mon, 17 Dec 2012 22:05:35 +0000
Message-ID: <50CF972F.9080907@ramsay1.demon.co.uk>
References: <50CCCD36.9020001@ramsay1.demon.co.uk> <CACsJy8DOhZjm05KVQYaR+HbQAu=wDNR=+NZ7H_hG8P5ZsNzSKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:36:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkjIi-0003LA-Vx
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 23:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab2LQWgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 17:36:18 -0500
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:42712 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab2LQWgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 17:36:16 -0500
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 86F55A0C081;
	Mon, 17 Dec 2012 22:36:14 +0000 (GMT)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id E0F5BA0C080;	Mon, 17 Dec 2012 22:36:13 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Mon, 17 Dec 2012 22:36:12 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CACsJy8DOhZjm05KVQYaR+HbQAu=wDNR=+NZ7H_hG8P5ZsNzSKg@mail.gmail.com>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211711>

Nguyen Thai Ngoc Duy wrote:
> On Sun, Dec 16, 2012 at 2:19 AM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>>
>> The failing tests make use of a POSIX character class, '[:xdigit:]'
>> in this case, which some versions of the fnmatch() library function
>> do not support. In the spirit of commit f1cf7b79 ("t3070: disable
>> unreliable fnmatch tests", 15-10-2012), we disable the fnmatch() half
>> of these tests.
> 
> I have no problem with this. You're on cygwin, right?

My main platform is Linux, but I also like to keep cygwin working.
(... and I also build MinGW just for fun!)

Yes, it was cygwin that suffered these test failures. (MinGW is built
with NO_FNMATCH=YesPlease.)

ATB,
Ramsay Jones
