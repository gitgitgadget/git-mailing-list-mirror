From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] tag, update-ref: improve description of option "create-reflog"
Date: Sat, 12 Sep 2015 23:07:10 +0800
Message-ID: <CANYiYbHcmHuvmDmu9aCKiQ20BiPHGj==75BR_x5yscnpFubkdA@mail.gmail.com>
References: <1441987453-22125-1-git-send-email-ralf.thielow@gmail.com>
	<xmqq613g2990.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 17:07:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZamP2-0001Xb-5e
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 17:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbbILPHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 11:07:13 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34898 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbILPHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 11:07:12 -0400
Received: by wicge5 with SMTP id ge5so93659975wic.0
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x1v9ujpj4C/79HLrXnMuXzj6PPKEXehU2F1nof/82qQ=;
        b=jkMK78l3ROqEQNODUpi4wc33PyY5NI4jN5SjMGx3RBye9nWe2Jv5w/zq9g6lbul1LE
         d/4CRNodT9R8kXovAW0XhBRLN/gRsUKU+A7w5jmzus/K6LB9JbH7WNRA/cd/6EA6psf4
         jknhar0CQLirW9CPMibKt5Svc+fSoiBhOoxUONix65IyQ1b4rXZmYOycMEVjbsr8ofvF
         ZxD0fI4SBloBiuWiVjsf10YN0RK74wJoCyEf4qox8oA6s2dcP264ZOcWfUCaSv9CIr3a
         3Xul2OnGCpzYvrx+BjLU+C1ppc9AJTpFts0SlTjvLpvVDoeziQXIw19gZ74wm1WDU3jF
         g9YA==
X-Received: by 10.180.206.8 with SMTP id lk8mr7576772wic.12.1442070430800;
 Sat, 12 Sep 2015 08:07:10 -0700 (PDT)
Received: by 10.194.76.230 with HTTP; Sat, 12 Sep 2015 08:07:10 -0700 (PDT)
In-Reply-To: <xmqq613g2990.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277729>

2015-09-12 0:47 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> The description of option "create-reflog" is "create_reflog", which
>> is neither a good description, nor a sensible string to translate.
>> Change it to a more meaningful message.
>>
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>
> This definitely is an improvement.  I will assume i18n team is OK
> with a change like this this late in the cycle (I see you CC'ed
> Jiang) and will merge before the next -rc.
>

Agree. Those who have already finished this round of l10n
(including sv (Swedish) and vi (Vietnamese)) should update
their translations for this update.


> Thanks.
>
>>  builtin/tag.c        | 2 +-
>>  builtin/update-ref.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index cccca99..cba0e22 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -606,7 +606,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>               OPT_STRING('u', "local-user", &keyid, N_("key-id"),
>>                                       N_("use another key to sign the tag")),
>>               OPT__FORCE(&force, N_("replace the tag if exists")),
>> -             OPT_BOOL(0, "create-reflog", &create_reflog, N_("create_reflog")),
>> +             OPT_BOOL(0, "create-reflog", &create_reflog, N_("create a reflog")),
>>
>>               OPT_GROUP(N_("Tag listing options")),
>>               OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 04dd00f..7f30d3a 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -365,7 +365,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>>                                       N_("update <refname> not the one it points to")),
>>               OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
>>               OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
>> -             OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create_reflog")),
>> +             OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
>>               OPT_END(),
>>       };



-- 
Jiang Xin
