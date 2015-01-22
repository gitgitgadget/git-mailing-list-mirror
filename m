From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv2 5/5] refs.c: enable large transactions
Date: Thu, 22 Jan 2015 20:59:06 +0000
Message-ID: <54C1649A.4030705@ramsay1.demon.co.uk>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>	<1421893929-7447-6-git-send-email-sbeller@google.com>	<54C0F41F.2080705@ramsay1.demon.co.uk>	<CAGZ79kZnECcGOWKr4JLpF5zh68+L8XX7yYntyZDJTbZ5cLD50w@mail.gmail.com>	<54C154C0.9020708@ramsay1.demon.co.uk>	<54C15A00.9000706@ramsay1.demon.co.uk> <CAGZ79kaq25tD5y3r6FY_5X6xUz9b7Hb8h1KBbVdhsX5zPN_7Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Loic Dachary <loic@dachary.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 21:59:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEOqU-0006fd-OO
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 21:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbbAVU7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 15:59:13 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:60999 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754992AbbAVU7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 15:59:12 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 78D30401D30;
	Thu, 22 Jan 2015 20:59:08 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 341DA401985;
	Thu, 22 Jan 2015 20:59:08 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Thu, 22 Jan 2015 20:59:07 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAGZ79kaq25tD5y3r6FY_5X6xUz9b7Hb8h1KBbVdhsX5zPN_7Dw@mail.gmail.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262870>

On 22/01/15 20:20, Stefan Beller wrote:
> On Thu, Jan 22, 2015 at 12:13 PM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>>
>> Notice the [-Wextra] warnings above. ;-)
>>
>> ATB,
>> Ramsay Jones
>>
> 
> Thanks, I put that into my config.mak
> Though recompiling the whole project yields
> 
>       4 [-Wempty-body]
>     477 [-Wmissing-field-initializers]
>     966 [-Wsign-compare]
>     899 [-Wunused-parameter]
> 
> so maybe I'll disable it again when I think it's too much output.
> 

Yes, you don't want to use -Wextra for everyday usage! :-D

[BTW, I don't know if sparse works on OS X, so ...]

ATB,
Ramsay Jones
