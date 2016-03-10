From: Marcus Kida <marcus.kida@gmail.com>
Subject: Re: Bug: git branch -D can be used to delete branch which is currently checked out
Date: Fri, 11 Mar 2016 05:38:46 +1100
Message-ID: <1592384A-0415-447A-B684-203871594E28@gmail.com>
References: <CE5AE06C-0909-414E-B901-7CCF3A259465@gmail.com> <xmqqvb4udyf9.fsf@gitster.mtv.corp.google.com> <xmqqfuvydwf5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 19:38:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae5U8-0000Qd-1X
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 19:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbcCJSiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 13:38:52 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35456 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcCJSiv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 13:38:51 -0500
Received: by mail-pa0-f42.google.com with SMTP id td3so46475836pab.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 10:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fn4M3q23WwWV10N8xQVon9lOsUwZBXThEfONd4PxVF0=;
        b=e1AytJY0Hs8lcqKV8Eh03lC4Tbi/1ebMnRvcgI7KGuY+f4z/CDZrobtvWAKrkOV0KR
         afhVHP1FZoq1SHE13tfuzrcAse0vGTWaLuG7dWo7H97fC4kLi3WbvoZjfaWDDz3GpYK1
         yBCay5HprVzJlbjHllyFJGVH8utpiDqmj2dOC7sK5b4axd1xGuQUuTm+91QwtCb5K5uI
         9NXP3Q/J/G638xZEKFN/xELvT9lq/PGhZ084R8zPPUq2xN8qQbRdWC0hNzUsDjcnuU5W
         lrcTY0ubRNTIsrKpUmDOI6dsvl5iJTaSCniotgXS1aBcH+EBMOEHMPzv3MYUuaTw+U1L
         9Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fn4M3q23WwWV10N8xQVon9lOsUwZBXThEfONd4PxVF0=;
        b=BADaSULehkP/MDoNP9+1GMkPuK8w14qkfT17chbpLOslrDgjfTgBXXwPg+HuoQyIWF
         SIfVIxAYLUu2DZlVnKjvMXONCT5yB2uZUMYv+3+TsaI0/g0K9X2VSZzjABI/AjuopOAU
         Z7ERBLmTCurJLicjdrDvAyJ75RADRxWGklvNbLpsrcx+3tNsb7EuffGvwKGDKSW94vQF
         gmAkkTiFsIp9YwqRIePHJJEp5roxIGJou1OMqRHSNrBoi0s6Q7eBWFvchhPoO9Okanw8
         PWzen53jejsdgnORidXakdb/JbNvuM520tqxxOT8q0EPg7CV+3GT+i8WwypHkUPXoS93
         dcYg==
X-Gm-Message-State: AD7BkJLTTfvZHkw0CQmOvEqvzWEjgGMCdSRzZ1/RhnqoTATOE3ml7Q7s1rP+oBnDLisRjQ==
X-Received: by 10.67.6.10 with SMTP id cq10mr7110059pad.120.1457635130281;
        Thu, 10 Mar 2016 10:38:50 -0800 (PST)
Received: from [192.168.0.7] ([49.191.133.138])
        by smtp.gmail.com with ESMTPSA id t87sm7186063pfa.54.2016.03.10.10.38.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2016 10:38:49 -0800 (PST)
X-Mailer: iPhone Mail (13D15)
In-Reply-To: <xmqqfuvydwf5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288633>

Thank you,
I get your point.

Well this proposed solution will exceed my current knowledge of the git code at this point. (Which is basically null because I've never built it before)

> On 11 Mar 2016, at 5:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> It is a possibility to teach the files backend of refs API that some
>> filesystems are case insensitive and do something special about them,
>> but I think in the longer term a more productive solution would be
>> to use the upcoming "pluggable ref backend" subsystem and either
>> 
>> - use a backend that is not the "files" backend (e.g. lmdb backend,
>>   or the tree-object based backend);
>> 
>> - add a variant of "files" backend but encodes the refnames in a
>>   way that is safe on case insensitive filesystems.
> 
> A typofix s/but encodes/that encodes/ is needed to make this
> sentence make any sense.  Sorry for a typo.
> 
> Just to elaborate a bit more, here is what I mean:
> 
> - Thanks to recent work by David, Ronnie and Michael, we eradicated
>   most if not all code that assume that the result of checking
>   "test -f .git/refs/heads/foo" tells us if a branch 'foo' exists
>   [*1*].  They all go through the API designed to allow different
>   backends to access refs.
> 
> - The traditional code that implemented 'foo' branch as writing a
>   file '.git/refs/heads/foo' has been moved to a "files" backend.
>   When used on a platform with case insensitive filesystem, it can
>   answer "it exists" when asked about a branch 'Foo' (notice the
>   case difference).
> 
> - We could add a new backend that is still based largely on the
>   existing "files" backend code, but stores 'foo' branch as a file
>   ".git/refs/6865616473/666f6f" while storing another branch 'Foo'
>   as ".git/refs/6865616473/466f6f" (I just used byte values in hex
>   in this example, but of course you can use a more efficient and
>   mostly human readable representations).
> 
> That way, even on a platform with case insensitive filesystem, you
> do not have to worry about getting confused by the filesystem when
> you have 'foo' and 'Foo' branches.
> 
> 
> [Footnote]
> 
> *1* This is not strictly true even in the pre-pluggable ref backend
>    world, as your refs may appear in the packed-refs file, but this
>    detail does not matter in the larger picture.
> 
> 
