From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] git config: clarify bool types
Date: Tue, 13 Oct 2009 13:02:15 +0300
Message-ID: <94a0d4530910130302j26c5308ew5266d03c775b6ab0@mail.gmail.com>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
	 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
	 <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>
	 <7v7hv1kxyg.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910120303y205e6cfeg80ba0dfd6ed5a045@mail.gmail.com>
	 <4AD3216B.7030507@drmicha.warpmail.net>
	 <94a0d4530910121014k666207b9ub38fcecd47641ace@mail.gmail.com>
	 <4AD427AD.3010701@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 12:12:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxeMB-0004Wi-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 12:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933747AbZJMKEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 06:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755563AbZJMKEE
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 06:04:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:3698 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbZJMKED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 06:04:03 -0400
Received: by fg-out-1718.google.com with SMTP id 16so723214fgg.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=i2QHopmXvPDD5A7hQ9G+M30l/PDTJxtiOb/5JmhVgfQ=;
        b=BMaAOtcxwx0ZqVTOo9jE3ygG9iNG7AV2hWkiyzt7j/1/L5Si6Vq9gbdLEy4GSFqCL5
         geSj2SX3fRSrp5YZ0ObxAscacAyoHpbLMyoNfw4pNL+pBPs2m/oVqCgwM0Fhx6AEfkfx
         gUFw6OHJz5HrM4N4cKUHVTNDPADMa1ubZ8bVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GnYqY/AtqDQAnH9B8nkBjdSYKv9rHt1j1lnCn9fmDZye8357cPEK/QUz1I18w/VIX2
         XdHLnW680WyeLvm5vqZqWE9/ZqidJjVmQj2nmvFHywxe7S5WogM9PzSAZHyPtamf0KgV
         7WvaQ5PQmCOhF+Y4Qt4fz+hECOy2SCEYBwSlk=
Received: by 10.86.221.25 with SMTP id t25mr6204053fgg.19.1255428135214; Tue, 
	13 Oct 2009 03:02:15 -0700 (PDT)
In-Reply-To: <4AD427AD.3010701@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130151>

On Tue, Oct 13, 2009 at 10:09 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 12.10.2009 19:14:
>> On Mon, Oct 12, 2009 at 3:30 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Felipe Contreras venit, vidit, dixit 12.10.2009 12:03:
>>>> On Mon, Oct 12, 2009 at 8:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>>
>>>>>> The value is what it is, the --bool and --bool-or-int options don't
>>>>>> specify the value type, just how it is interpreted. For example: a value
>>>>>> of '1' can be interpreted as 'true'.
>>>>>
>>>>> It is not really about "interpreting", but about showing, isn't it?
>>>>
>>>> Unless you are setting it, instead of reading it.
>>>>
>>>
>>> I'd still suggest fixing the typo ("interpreted") and spelling out
>>> "boolean".
>>
>> Oops! You mean s/intepreted/interpreted/?
>
> Yep :)
>
>>
>> If we spell 'boolean' we might as well spell 'integer'; I think bool
>> and int are fine.
>>
>
> "int" is at least a standard type name in C, whereas "bool" is not; but,
> yes, feel free to spell out "integer", or use "--int or --bool" as it
> is, which is a back reference to the corresponding entries for "--int"
> and "--bool", where things should be spelled out.

'bool' is also a standard type, in C99.

-- 
Felipe Contreras
