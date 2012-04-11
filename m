From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 1/5] t1507: add additional tests for @{upstream}
Date: Thu, 12 Apr 2012 00:05:48 +0200
Message-ID: <4F86003C.3080308@in.waw.pl>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl> <1334161035-26355-2-git-send-email-zbyszek@in.waw.pl> <7vfwcakvfw.fsf@alter.siamese.dyndns.org> <vpqk41m40as.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:06:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI5fv-00074w-LM
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 00:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933465Ab2DKWF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 18:05:58 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34705 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933422Ab2DKWF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 18:05:57 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SI5fm-0007wB-48; Thu, 12 Apr 2012 00:05:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <vpqk41m40as.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195273>

On 04/11/2012 07:59 PM, Matthieu Moy wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> We may want to update the error message for "@{u}" when the current one is
>> not tracked, instead of saying ''.  Perhaps
>>
>> 	error: No upstream branch found for the current branch.
>>
>> or something?
>>
>> Likewise for the detached HEAD case.
>
> This is indeed the point of the patch serie, and I like how it first
> shows how bad the error messages can be, and then illustrate the fix
> with patch hunks in the newly added testcases in further patches.
>
> But the commit message for this patch could probably be improved: we
> usually do not give a list of _what_ is done, since the code already
> says that, but we insist on _why_ it is done.
Yeah, I need to provide a better motivation/description in reroll.

Thanks for looking at this,
Zbyszek
