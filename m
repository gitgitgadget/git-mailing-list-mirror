From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/5] t1404: document function test_update_rejected
Date: Fri, 10 Jun 2016 08:30:52 +0200
Message-ID: <575A5E9C.2050308@alum.mit.edu>
References: <cover.1465299118.git.mhagger@alum.mit.edu>
 <2561c38f85648144d665e870ca42c133a3a78909.1465299118.git.mhagger@alum.mit.edu>
 <5756FCF3.7050509@kdbg.org> <57598F2F.9050806@alum.mit.edu>
 <xmqqa8iujqkv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 08:31:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBFyO-0004WM-Bx
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 08:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbcFJGbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 02:31:12 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62760 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751251AbcFJGbL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 02:31:11 -0400
X-AuditID: 1207440c-c53ff70000000b85-2e-575a5ea0b36e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 10.78.02949.0AE5A575; Fri, 10 Jun 2016 02:30:56 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5A6Url9024599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 02:30:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqa8iujqkv.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqLsgLirc4MZldov5m04wWnRd6Way
	aOi9wmzxZO5dZovuKW8ZLX609DA7sHnsnHWX3ePhqy52j2e9exg9Ll5S9ljw/D67x+dNcgFs
	Udw2SYklZcGZ6Xn6dgncGVPOlhX0cVZMaTjO3sD4kq2LkZNDQsBE4vy2V+xdjFwcQgJbGSX2
	fDzMDOFcYJI4+OUgM0iVsICbxPIzN9hBbBEBNYmJbYdYIIq+M0rs3vyLFcRhFrjDKDGt+ThY
	B5uArsSinmYmEJtXQFvi+c9VjF2MHBwsAqoScx/zgIRFBUIkzq/bygpRIihxcuYTFhCbU8Ba
	oufIY7BlzAJ6Ejuu/2KFsOUltr+dwzyBkX8WkpZZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZ
	tzg5MS8vtUjXUC83s0QvNaV0EyMkwHl2MH5bJ3OIUYCDUYmHN2JXZLgQa2JZcWXuIUZJDiYl
	Ud6dgVHhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4xUByvCmJlVWpRfkwKWkOFiVxXtUl6n5C
	AumJJanZqakFqUUwWRkODiUJ3uhYoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4
	UEzGFwOjEiTFA7R3Ikg7b3FBYi5QFKL1FKMux5H999YyCbHk5eelSonzNscAFQmAFGWU5sGt
	gKWzV4ziQB8L814GGcUDTIVwk14BLWECWrL8SDjIkpJEhJRUA2Na086zmU80f6gYd1muDYg4
	s1SdN0fRM90+84cH0+lVBvLLnr3VTpru25vPnco1NWHf3fT7Kk4WU+uv7Fq/TLms 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296944>

On 06/09/2016 06:05 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 06/07/2016 06:57 PM, Johannes Sixt wrote:
>>> Am 07.06.2016 um 13:50 schrieb Michael Haggerty:
>>>>   test_update_rejected () {
>>>> +    local prefix before pack create error &&
>>>
>>> Do we want to add more of unportable 'local' declarations?
>>
>> Sorry, I forgot that `local` is not in the POSIX standard.
> 
> Regarding portability we say three things.
> 
>  * It is supported practically everywhere, and it is even in POSIX,
>    so let's use it.
> 
>  * Even this is not in POSIX, it is supported practically
>    everywhere, and it is too cumbersome to do things without using
>    it, so let's use it.
> 
>  * It is not available in some platforms we (collectively) still
>    care; it is not even in POSIX.  Don't use it.
> 
> I think "local" falls into the third one.
> 
> : bash; ksh
> $ v=1
> $ f () { local v; v=2; echo f; }
> $ f
> ksh: local: not found [No such file or directory]
> f
> $ echo $v
> 2
> $ exit
> : bash;

OK, I didn't realize that we still support ksh. I will make the change.

Michael
