From: Peter Dave Hello <hsu@peterdavehello.org>
Subject: Re: [PATCH] Update diff-highlight
Date: Mon, 22 Feb 2016 13:59:40 +0800
Message-ID: <CA+boQ6Y4223NY_mXHPNR7hpxiepgoSmbM8c6bJxirxTMDVQ8Bg@mail.gmail.com>
References: <00000153072f5465-fd36f07c-e5e6-4a0f-8cf1-77be99424892-000000@eu-west-1.amazonses.com>
 <CAPig+cRRX4k8jR02YOGTGHUnbOmhHF0oMc-6aCOWuMOpi+BG0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Dave Hello <hsu@peterdavehello.org>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 07:00:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXjXl-0007KB-LZ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 07:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbcBVGAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 01:00:22 -0500
Received: from sender163-mail.zoho.com ([74.201.84.163]:25347 "EHLO
	sender163-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbcBVGAW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 01:00:22 -0500
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com [209.85.192.54]) by mx.zohomail.com
	with SMTPS id 1456120821060123.9320617623091; Sun, 21 Feb 2016 22:00:21 -0800 (PST)
Received: by mail-qg0-f54.google.com with SMTP id y89so104316933qge.2
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 22:00:20 -0800 (PST)
Received: by 10.140.37.69 with HTTP; Sun, 21 Feb 2016 21:59:40 -0800 (PST)
X-Gm-Message-State: AG10YOTNAAp+1ofSh/+PQCVegmTvgHPOmcDTdM0kR4ochJh1Suijg7kGxxapE7S78RdDQs6keEHT2O3bv5T7RA==
X-Received: by 10.140.94.46 with SMTP id f43mr31869094qge.95.1456120820113;
 Sun, 21 Feb 2016 22:00:20 -0800 (PST)
In-Reply-To: <CAPig+cRRX4k8jR02YOGTGHUnbOmhHF0oMc-6aCOWuMOpi+BG0A@mail.gmail.com>
X-Gmail-Original-Message-ID: <CA+boQ6Y4223NY_mXHPNR7hpxiepgoSmbM8c6bJxirxTMDVQ8Bg@mail.gmail.com>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286884>

Hello Eric,

Thanks for your review and prompt reply, this is my first PR to git,
I'll try to update it to follow the conventions.

Best,
Peter

--

Now you can follow me on twitter or GitHub :D


2016-02-22 12:49 GMT+08:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Sun, Feb 21, 2016 at 11:14 PM, Peter Dave Hello
> <hsu@peterdavehello.org> wrote:
>> From: Peter Dave Hello <peterdavehello@users.noreply.github.com>
>
> This "From:" line looks suspiciously incorrect. If anything, you'd
> probably want to drop the line altogether or use:
>
>     From: Peter Dave Hello <hsu@peterdavehello.org>
>
>> Update diff-highlight
>
> Patches do indeed "update" the project, but this summary line isn't
> telling us much about intention of this patch. Perhaps rephrase it as:
>
>     contrib/diff-highlight: stop hard-coding perl location
>
>> Use `#!/usr/bin/env perl` instead of `#!/usr/bin/perl`
>>
>> So that it can works on FreeBSD.
>
> s/works/work/
>
> Also, you probably want to combine those two lines into one proper
> sentence rather than having one sentence plus a sentence fragment.
>
> Your Signed-off-by: is missing.
>
> Thanks.
>
>> ---
>>  contrib/diff-highlight/diff-highlight | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
>> index ffefc31..b57b0fd 100755
>> --- a/contrib/diff-highlight/diff-highlight
>> +++ b/contrib/diff-highlight/diff-highlight
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/perl
>> +#!/usr/bin/env perl
>>
>>  use 5.008;
>>  use warnings FATAL => 'all';
>>
>> --
>> https://github.com/git/git/pull/200
