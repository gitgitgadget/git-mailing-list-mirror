From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] config doc: improve exit code listing
Date: Tue, 26 Apr 2016 12:18:29 -0700
Message-ID: <CAGZ79ka_spZCCwpKtUhJTA+osetbzZDpmmv6GWYV+QeBkU5Tmg@mail.gmail.com>
References: <20160426181058.7901-1-sbeller@google.com>
	<571FBD52.4040206@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 21:18:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av8VH-0000wx-Dj
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 21:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbcDZTSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 15:18:31 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34748 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbcDZTSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 15:18:30 -0400
Received: by mail-io0-f180.google.com with SMTP id 190so20037512iow.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=20GXNVeaQeLo0E6pB+jI6oCtFTiHktH7VreJSLgktYU=;
        b=gzlfAfGuBUWXNBKqItho8RTecXVbT2iu5amZZPaGqfGYO50ZD7U0Jngsr6J4RGl6/z
         0PNGTlLClEHaZKxIXR5QIFR8PlUhf3yNSku7UY+u+U89YCYkdRejtJTjsHo1VsDI0LHt
         6CyNjqwZsKXX9NPPcwcP9yorpemuIPUoV3kJJXdYG275Y1WM7cXwQ2w+TEd5AMiYhdnB
         1JDi9QLK+NK6QLvb9Ir8lHKvuBi8+k+FfsUHu/TupyIUfQPNXBpitYOLOhFxGz7VH4Y5
         crBhWs5SsJf9Nmpb3YBzjEUgzI8hGcDkyUnL7izCJ2/l3ueQU4IbA3jO+nFb3v9LQSRp
         V2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=20GXNVeaQeLo0E6pB+jI6oCtFTiHktH7VreJSLgktYU=;
        b=X63CFDMQjeeXDVJel0t0/Mom18zaAvcxkozIVZBg44jrIQNBSlHKscxsV35Kt+Wr36
         WcJZ5zuR2uq/HPCBxyV+Vg3Le1mx2K3EKIQlP6sq81Q2GmiMZb4M7L+zfC7D8r9oA1SY
         /wWtVNXImjktayquob84Rmrmjf5mQ62ceuBY0/ei0UJNS+BsCuUc8++wV/nOIHulMfrG
         pPhpsaF6wenGQws3kakWtul8r36UTHNTI5v5VkI3J1RDe8EKx9mKoEGPgFfTGs1QDJVk
         uPyHUSjKXnMIv8z1D//d/fONyci/eKSJ8j9fKRBqD2CKjnADCmrf457kO55WOU/p7LGh
         gLiQ==
X-Gm-Message-State: AOPr4FVdeCRwQS1to4W9JChcNj+uFL1RHQLDj/zqUt8YALUgBi0TkcSRRdpYPq2tf/AIAKK7tvlEXieUxTLZ3rG28W2UwjXWYUzFGAYrbJDvW0EamJ+PawKXbwiKWJi0FXGvA77anESdxA==
X-Received: by 10.107.174.205 with SMTP id n74mr5474702ioo.96.1461698309283;
 Tue, 26 Apr 2016 12:18:29 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 26 Apr 2016 12:18:29 -0700 (PDT)
In-Reply-To: <571FBD52.4040206@ramsayjones.plus.com>
X-ccpol: medium
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292651>

On Tue, Apr 26, 2016 at 12:11 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 26/04/16 19:10, Stefan Beller wrote:
>> The possible reasons for exiting are now ordered by the exit code value.
>> While at it, rewrite the `can not write to the config file` to
>> `the config file cannot be written` to be grammatically correct and a
>> proper sentence.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  Documentation/git-config.txt | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
>> index 6fc08e3..6843114 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>> @@ -58,10 +58,10 @@ that location (you can say '--local' but that is the default).
>>  This command will fail with non-zero status upon error.  Some exit
>>  codes are:
>>
>> -- The config file is invalid (ret=3),
>      ^
> I don't see why this is capitalised, so ...

Because the whole listing is a bunch of sentences,
stringed together with commas at the end of each line.
Note that there is a ',' at the end of each line, except for
the last, where you see a '.'. I thought about breaking that
up into a list and make all of the bullet points either a sentence
(all capitalised and ending in dot) or part sentences (lower
case for each bullet point, not clear about the ending)

I kept it as is in a long sentence as I expected to see
lowest resistance there. ;)

>
>> -- can not write to the config file (ret=4),
>> +- The section or key is invalid (ret=1),
>      ^
> I don't think you should transfer the capital here. ;-)

It's the first bullet point starting the long sentence.

>
>>  - no section or name was provided (ret=2),
>> -- the section or key is invalid (ret=1),
>> +- the config file is invalid (ret=3),
>> +- the config file cannot be written (ret=4),
>>  - you try to unset an option which does not exist (ret=5),
>>  - you try to unset/set an option for which multiple lines match (ret=5), or
>>  - you try to use an invalid regexp (ret=6).
>>
>
> Only a minor point.

If the current state bothers you too much,
please send a patch with correct lists. :)
(Feel free to squash this patch into that or
just on top of this)

Thanks,
Stefan

>
> ATB,
> Ramsay Jones
>
>
