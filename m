From: slavomir vlcek <svlc@inventati.org>
Subject: Re: [PATCH] SubmittingPatches: fix an inconsistency
Date: Thu, 13 Nov 2014 22:41:43 +0100
Message-ID: <54652597.1070609@inventati.org>
References: <5463DA20.3080703@inventati.org> <5463FB4C.2060203@inventati.org>	<xmqqy4rf0xod.fsf@gitster.dls.corp.google.com>	<xmqqtx230xax.fsf@gitster.dls.corp.google.com> <xmqqppcr0x83.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:38:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp26J-0006ah-MP
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934857AbaKMVik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:38:40 -0500
Received: from latitanza.investici.org ([82.94.249.234]:60183 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934854AbaKMVii (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:38:38 -0500
Received: from [82.94.249.234] (latitanza [82.94.249.234]) (Authenticated sender: svlc@inventati.org) by localhost (Postfix) with ESMTPSA id 38EBA120A5E;
	Thu, 13 Nov 2014 21:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inventati.org;
	s=stigmate; t=1415914717;
	bh=Fe2h4cQlkIwllGcfMAb30yaVL4zaBTYK2fHNTp/Y/Ts=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jiLX3wNfa6uqO3+cAUxylrYY6dm81iaHPU9gRnSmxyhqawGa6ZOwmkRtB+FQcJIkF
	 x7uUucnYT/wJ1sZ+43rAUDq6luNTp1jFTqDKwU3Qqjpen36QBgtfsO4aTOsNrnltC6
	 JpkV6ar6I92ayL21yElydDNpUsJi2C9pUgPi2gNI=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqppcr0x83.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13/2014 07:30 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>> Signed-off-by: slavomir vlcek <svlc@inventati.org>
>>
>>> The same comment applies to the log message part.
>>
>> I said:
>>
>>> Will queue; no need to resend.
>>>
>>> Thanks.
>>
>> But one thing to make sure.  Do you really mean to have your
>> sign-off with all lowercase?  I can amend the patch to read
>>
>>     Signed-off-by: Slavomir Vlcek <svlc@inventati.org>
>>
>> while applying, so that your name does not stand out like a sore
>> thumb in "git shortlog -20 -s" output, if you want.
> 
> ... by the above, I mean something like what appears after the
> scissors "-- >8 --" line below.
> 

Yes, agreed. Thanks for the corrections.

> -- >8 --
> From: Slavomir Vlcek <svlc@inventati.org>
> Date: Thu, 13 Nov 2014 00:18:39 +0100
> Subject: [PATCH] SubmittingPatches: final submission is To: maintainer and CC: list
> 
> In an earlier part there is:
> 
>   "re-send it with "To:" set to the maintainer [*1*] and "cc:" the list [*2*]"
> 
> for the final submission, but later we see
> 
>   "Send it to the list and cc the maintainer."
> 
> Fix the later one to match the previous.
> 
> Signed-off-by: Slavomir Vlcek <svlc@inventati.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/SubmittingPatches | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index e6d46ed..fa71b5f 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -337,7 +337,7 @@ suggests to the contributors:
>       spend their time to improve your patch.  Go back to step (2).
>  
>   (4) The list forms consensus that the last round of your patch is
> -     good.  Send it to the list and cc the maintainer.
> +     good.  Send it to the maintainer and cc the list.
>  
>   (5) A topic branch is created with the patch and is merged to 'next',
>       and cooked further and eventually graduates to 'master'.
> 
