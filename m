From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] cat-file: Remove unused includes
Date: Fri, 9 Jan 2015 02:21:22 +0600
Message-ID: <CANCZXo7_yUT4x5fBvwNdc7d+ew5M7yaayGE_yXaeLxiPHzK9GA@mail.gmail.com>
References: <1420743366-14926-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq1tn5f441.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:21:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9JaB-0002gP-NN
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 21:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbbAHUVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 15:21:23 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:52820 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbbAHUVX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 15:21:23 -0500
Received: by mail-oi0-f53.google.com with SMTP id g201so9023788oib.12
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 12:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BqjFxPN/5rh7wVaYfp3asdTIi8uy9wxAhLdrKTLAzFc=;
        b=U6Iu6/COD+azmCtLP4awArpJcOvhyL5umVvKaQ/o4SYJ9J9FuOpBMilRQ8oqfOM9KC
         GrXMWdUxjRd2ssSdBjdFs7KSRWDHqV+GbWHUnG2Slk6SIFFEsOR9wCUubzXWo3rSzZ3s
         d1p9k2VW3Mpx/R2xcU67lTxTCooZFrTe08sEaA+U64q9b0Vjnk7j+8CYlgOqP/5AcLyI
         LLtpNuf+eurKv3kbFaabSPZ9wJJVIXI7zqCG9HBBcltwAUH8stpQQ1gm0bmqvjjn74+C
         W6l7ScsDRc6S/fgtD4MrjmkldG49c+yCa7w7nMmBgYV/w9uG1/mMJzB/8eNGAGs8QIM/
         J95Q==
X-Received: by 10.202.185.69 with SMTP id j66mr6581705oif.86.1420748482684;
 Thu, 08 Jan 2015 12:21:22 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Thu, 8 Jan 2015 12:21:22 -0800 (PST)
In-Reply-To: <xmqq1tn5f441.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262220>

Will research this question and resend the patch.

Thank you.

2015-01-09 1:45 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>> ---
>>  builtin/cat-file.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index f8d8129..750b5a2 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -4,12 +4,8 @@
>>   * Copyright (C) Linus Torvalds, 2005
>>   */
>>  #include "cache.h"
>> -#include "exec_cmd.h"
>> -#include "tag.h"
>> -#include "tree.h"
>>  #include "builtin.h"
>>  #include "parse-options.h"
>> -#include "diff.h"
>>  #include "userdiff.h"
>>  #include "streaming.h"
>
> Interesting.
>
>  - "exec_cmd.h" became unnecessary at b931aa5a (Call builtin ls-tree
>    in git-cat-file -p, 2006-05-26).
>
>  - "tag.h" and "tree.h" became unnecessary at 21666f1a (convert
>    object type handling from a string to a number, 2007-02-26).
>
>  - "diff.h" was added at e5fba602 (textconv: support for cat_file,
>    2010-06-15), together with "userdiff.h".  Was it unnecessary from
>    the beginning?
>
> I didn't dig further to find out the answer to the last question,
> but a patch to remove these include should explain these in its log
> message, I would think.
>
> Thanks.
>
>



-- 
_________________________
0xAX
