From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/4] Declare that HP NonStop systems require strings.h
Date: Sat, 15 Dec 2012 00:16:30 +0100
Message-ID: <50CBB34E.8090609@kdbg.org>
References: <00c601cdda4c$eb6be9a0$c243bce0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, fedora.dm0@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sat Dec 15 00:16:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjeUu-0001aW-O0
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 00:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945901Ab2LNXQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 18:16:35 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:37007 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945898Ab2LNXQd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 18:16:33 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2C0B3CDF84;
	Sat, 15 Dec 2012 00:16:31 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BB27419F43B;
	Sat, 15 Dec 2012 00:16:30 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <00c601cdda4c$eb6be9a0$c243bce0$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211511>

Am 14.12.2012 23:46, schrieb Joachim Schmitz:
> Johannes Sixt wrote:
>> Am 14.12.2012 20:57, schrieb David Michael:
>>> This platform previously included strings.h automatically.  However,
>>> the build system now requires an explicit option to do so.
>>>
>>> Signed-off-by: David Michael <fedora.dm0@gmail.com>
>>> ---
>>>  Makefile | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index fb78f7f..e84b0cb 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1357,6 +1357,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>>>      # Added manually, see above.
>>>      NEEDS_SSL_WITH_CURL = YesPlease
>>>      HAVE_LIBCHARSET_H = YesPlease
>>> +    HAVE_STRINGS_H = YesPlease
>>>      NEEDS_LIBICONV = YesPlease
>>>      NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
>>>      NO_SYS_SELECT_H = UnfortunatelyYes
>>
>> If NONSTOP_KERNEL is the platform that defines __TANDEM, then this
>> should be squashed into the previous patch, shouldn't it?
> 
> Patch 4/4 does not work without 3/4, Not for HP-NonStop.

That is clear from the order of the patches in the series.

To put it in a different way: Do all supported platforms still work
after 3/4, but without 4/4?

-- Hannes
