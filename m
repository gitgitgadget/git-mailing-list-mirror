From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH v2] Documentation/init-db.txt: minor style and synopsys fixes
Date: Thu, 15 Jan 2015 23:08:28 +0600
Message-ID: <CANCZXo6j6zXX8yrBV=OZpxZPzsf701f79YyQgvWJ+kQ3Dj0qUA@mail.gmail.com>
References: <1421317918-11677-1-git-send-email-kuleshovmail@gmail.com>
	<CAPig+cTHDf6S-R6DEZ3mV+wNhn9KojsoMy_ogg7wG4aPWnvUpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:08:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBnuO-00006d-Nn
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 18:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbbAORIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 12:08:31 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:57693 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063AbbAORI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 12:08:29 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so14605036obc.7
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 09:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=70FP7Y0L4QUGAyrPmduCZHPYWT7xar4WwpywNF7FmEU=;
        b=Gapq6lEX8yM3L389WkoluOS/4tRihATi0Y9GNjb8Mh5LQmXG91rInXeTiDL9I0TiYD
         xoLnwh14F/s+8yHSpnK+4PRoWlslis9uki1EUrpBd2ExQy3M5EQyIAfeOWt5KPAk83Oa
         oTMZhnkZsK2eM2dVi+LiTcrkX8ncIAeUKRVnhe+pbtZ08qR4fZXtGQQDVqrrPuYfG/vY
         6HLTVRZXFIQq17/6YaHzg/E7HUZfP5+OCeNLSnhHq9wk6PCkZQJKaxZzDSQW3hBZfXbm
         suJjwmPnymCx+snM3dF5iZQLvvN6hFYEzpLn0B2oDAPUXThJHLw1tJk40pHUoi+CP0hz
         1lnA==
X-Received: by 10.202.187.10 with SMTP id l10mr6257145oif.86.1421341708197;
 Thu, 15 Jan 2015 09:08:28 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Thu, 15 Jan 2015 09:08:28 -0800 (PST)
In-Reply-To: <CAPig+cTHDf6S-R6DEZ3mV+wNhn9KojsoMy_ogg7wG4aPWnvUpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262487>

Yes, right,

how to do it better? Something like: Documentation,
init-db/init:.....? Or something else?

Thank you

2015-01-15 22:50 GMT+06:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Thu, Jan 15, 2015 at 5:31 AM, Alexander Kuleshov
> <kuleshovmail@gmail.com> wrote:
>> Subject: Documentation/init-db.txt: minor style and synopsys fixes
>
> Subject is incorrect now that you're modifying git-init-db.txt and git-init.txt.
>
>> This patch constists of two minor changes:
>>
>> * line-wrap 'git init-db' synopsis
>>
>> * last possible argument '[<directory>]' was missed
>>
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>> ---
>>  Documentation/git-init-db.txt | 5 +++--
>>  Documentation/git-init.txt    | 6 +++---
>>  2 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
>> index 648a6cd..2c77aaa 100644
>> --- a/Documentation/git-init-db.txt
>> +++ b/Documentation/git-init-db.txt
>> @@ -9,8 +9,9 @@ git-init-db - Creates an empty Git repository
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
>> -
>> +'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>]
>> +            [--separate-git-dir <git-dir>]
>> +            [--shared[=<permissions>]] [<directory>]
>>
>>  DESCRIPTION
>>  -----------
>> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
>> index 369f889..25412ac 100644
>> --- a/Documentation/git-init.txt
>> +++ b/Documentation/git-init.txt
>> @@ -10,8 +10,8 @@ SYNOPSIS
>>  --------
>>  [verse]
>>  'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
>> -         [--separate-git-dir <git dir>]
>> -         [--shared[=<permissions>]] [directory]
>> +         [--separate-git-dir <git-dir>]
>> +         [--shared[=<permissions>]] [<directory>]
>>
>>
>>  DESCRIPTION
>> @@ -108,7 +108,7 @@ By default, the configuration flag `receive.denyNonFastForwards` is enabled
>>  in shared repositories, so that you cannot force a non fast-forwarding push
>>  into it.
>>
>> -If you provide a 'directory', the command is run inside it. If this directory
>> +If you provide a <directory>, the command is run inside it. If this directory
>>  does not exist, it will be created.
>>
>>  --
>> --
>> 2.3.0.rc0.314.g170a664.dirty



-- 
_________________________
0xAX
