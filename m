From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/3] remote-testsvn.c: Avoid the getline() GNU extension function
Date: Thu, 30 Aug 2012 18:19:48 +0100
Message-ID: <503FA0B4.6010401@ramsay1.demon.co.uk>
References: <503907B3.9040101@ramsay1.demon.co.uk> <CABPQNSZfUO-vjVmBU2+CMbxTXMj_HT=cTFfVbnehUjqOL-vkxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: florian.achleitner.2.6.31@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 30 19:30:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T78ZX-0007JP-O4
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 19:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab2H3RaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 13:30:23 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:41609 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751225Ab2H3RaU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 13:30:20 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 45A164002BD;
	Thu, 30 Aug 2012 18:30:18 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 9B2F64002B2;	Thu, 30 Aug 2012 18:30:17 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Thu, 30 Aug 2012 18:30:14 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <CABPQNSZfUO-vjVmBU2+CMbxTXMj_HT=cTFfVbnehUjqOL-vkxw@mail.gmail.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204556>

Erik Faye-Lund wrote:
> On Sat, Aug 25, 2012 at 7:13 PM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>>
>> The getline() function is a GNU extension (you need to define
>> _GNU_SOURCE before including stdio.h) and is, therefore, not
>> portable. In particular, getline() is not available on MinGW.
> 
> Actually, getline is a POSIX-2008 feature, so it's not (simply) a GNU extension:
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/getline.html

Thanks for the reference. I hadn't noticed this being included into
POSIX. Well, it's only been four years ... :-D

Thanks again.

ATB,
Ramsay Jones
