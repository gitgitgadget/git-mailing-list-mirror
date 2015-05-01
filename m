From: Stefan Beller <sbeller@google.com>
Subject: Re: Patch that modifies git usage message
Date: Fri, 1 May 2015 09:55:21 -0700
Message-ID: <CAGZ79kY4zJ2EhrtinaWChX=hLKywFu38wpF-mo=xrturxVh0=g@mail.gmail.com>
References: <CAKB+oNtYbJXNb2wGzJCdQ5Ru5fq3HzcapSqiTVC_34=xDnTb7Q@mail.gmail.com>
	<CAGZ79kY1ZoYrVwVVqfyB+uMGsJo59qDxbDLgyo5qygSm=CUVhA@mail.gmail.com>
	<xmqqfv7gxnup.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alangi Derick <alangiderick@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 18:55:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoEDn-00027e-HU
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 18:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbbEAQzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 12:55:23 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38317 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbbEAQzV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 12:55:21 -0400
Received: by igbhj9 with SMTP id hj9so42699168igb.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SzSQ/E3mkwJy/t8QrJiUZnhq9WMsXWLFZnynGjOYQrY=;
        b=bvWvK+WPnFyKWdLtkVovdTvR37fUEyV6IRqhYSoAAkcJg0TW5DGb/LPklJitziSEa7
         AlYuSeQ/F0ZFdVthep1fBlGy9Y9JXvMKFd+CAxztoxMjlOrSpX0uNvEUmIaU7STeJc5p
         /n4iKpjWoghtN0vcp2P0DoJrskyfc0BYOBD3g4GDEZUniq1wtJlNBG0UQgp15OWgQXa2
         q0DLMI+3131nSJNVcm4y9KlhAwVIAfZuLrSl08GUzGS/1iRGpwRdahygtY5dDb3922Kg
         +L+kQGybgH57R7bmm0wcoQ1mSt3+CWQjLDpBjNcks32SJ1/G1I1iOYaS2kYOESWRbiox
         dM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SzSQ/E3mkwJy/t8QrJiUZnhq9WMsXWLFZnynGjOYQrY=;
        b=eISE6DqF+qnkT/0rCire2G3VQbTKlyUs0i7/ILmmGo+VSUWaOt+1s5gr1uTRNXKn2j
         yjQBu6M+E7yDokW9aeGDKk0klKlU/gqKqOvx8OkE37/ZtZvPi1IV0EPQoJA9DYr3LZT1
         2LZ4ZpmsUhIc32kGhpoy4ApCN2CwftTaCiOH4OTQfzVxQArNwZ3s3KUv+17gMyIh+mH2
         atJKpknhFNe2FRUNWVeaa4RU4UGvdlR0GCsOQ0gpd4JfFuCcq3tn8GfNXwSdEOVxuEbs
         TbyyItCxtF4/pFsZBxSYmV4SPMRWHvbQUf47LxS208MCtsS4NB6kq7zRwdffzUc1KuFK
         XrlA==
X-Gm-Message-State: ALoCoQkifzphxs6ANkrYf6fEjepfMZ8UNr6Wh0S68wHPaS6CoBgELehd9mZoxPbboxvu0M2bmHkr
X-Received: by 10.42.213.136 with SMTP id gw8mr15777087icb.95.1430499321057;
 Fri, 01 May 2015 09:55:21 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 1 May 2015 09:55:21 -0700 (PDT)
In-Reply-To: <xmqqfv7gxnup.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268157>

On Fri, May 1, 2015 at 9:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> For the patch itself:
>>
>> $ grep -r usage *.c builtin/*.c |wc -l
>> 551
>> $ grep -r Usage *.c builtin/*.c |wc -l
>> 3
>>
>> The community agreed (maybe subconciously) to prefer lower case
>> for the 'usage' string, so I don't think this is an improvement.
>
> I tend to agree with the conclusion, but you need to be a bit
> careful here.  These catch all the variable names that contain
> "[uU]sage" as substring, but we do not spell in-code variables
> with camelCase, so the former probably is over-counting.  Things
> like "static const char usage[] = ..." are counted; so are calls
> to usage_with_options().

I knew my search was off as I did not think it through, but I
just wanted to have at least some data to not be hand waving only
here.

Maybe we can also rely on the colon in this case:
$ grep -r "usage:" *.{c,sh,perl}
finds 22 results, 21 thereof look like human readable usage instructions
$ grep -r "Usage:" *.{c,sh,perl}
finds 2 results which look like human readable text

>
> If you look for the beginning of a string constant, you would get
> this:
>
>     $ git grep '"usage' -- \*.c builtin/\*.c
>     12
>     $ git grep '"Usage' -- \*.c builtin/\*.c
>     0
>
> The former undercounts the messages because many usage messages are
> produced by calling usage_with_options() these days.
>
> The latter being zero made me scratch my head and do this:
>
>     $ git grep Usage -- \*.c builtin/\*.c
>     commit.c: * Usage example:
>     test-hashmap.c: * Usage: time echo "perfhas...
>
> I cannot find the third one you found for "Usage" in your example,
> though.

test-submodule-config.c: fprintf(stderr, "Usage: %s [<commit>
<submodulepath>] ...\n", argv[0]);
(I just realize HEAD wa pointing somewhere in pu)
