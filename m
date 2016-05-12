From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] Documentation: clarify signature verification v2
Date: Thu, 12 May 2016 23:02:59 +0530
Message-ID: <CAFZEwPOgQcyuVjrWsxgz+vTe+0qEbBPo3YSdKpGc0Zb6YB7tAw@mail.gmail.com>
References: <20160512065022.GA32387@hashbang.sh>
	<CAFZEwPOJg=njvhtK7ZQf_-3DUVjMpFBEV_0m1NHAE1UL7eM5ng@mail.gmail.com>
	<xmqq4ma3grj0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fox in the shell <KellerFuchs@hashbang.sh>,
	Git List <git@vger.kernel.org>,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 19:49:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0ukB-0008Vz-Ro
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 19:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbcELRts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 13:49:48 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36628 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbcELRtr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 13:49:47 -0400
Received: by mail-yw0-f193.google.com with SMTP id u62so8397293ywe.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=d0/EpVsZt0YkAm7Et7zl+0VYoOkCWtG+WOZmKP1FJCo=;
        b=So+H5IxouQWDCVzBTGILSjtBMbBE6vg9501JZL+sziN49B0RII8TvQf98pxkUWCiXb
         keWhWUunKeUjFJzkw9ISvV4p0GLSkYJy7DLOMBVmJ2fl3YSgFfyOJr4p9f5eJ8083oEs
         BcY9/QZT6MLxnxyfF15fWLcvXfRAYls7KnD19qX+od59NEz8yCZXbEz4srcaZVlOsBSa
         8l18VkMbyLJ3gmL5f78TDFJujuRolVSrLJueGHHzG0+l5Bgnw9Jj/C4nlLkMxdPKjiEJ
         BmhIsILNfOM7ul3DoRuE7IPmHfrErwxOmiUfAmNuNuqKon3U+oJ+gthhIiIuVJb+vVH4
         0tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=d0/EpVsZt0YkAm7Et7zl+0VYoOkCWtG+WOZmKP1FJCo=;
        b=K93IYzG8IPiH3Yj/3s3nSCqR5DIxUevcc6GtONPvcJ6lG1pAdWo4zqgxLasohodczY
         AUeyznfZwpppoxnQDJKPhTDmmmXMPXnfCL6NK9jbWAMiPqqE3RHUGjPUqNWHoVVQuigt
         VSwe5RbUkL26GkPwJVoAtJHh8Kxe3hcFCGJcI/9dRA2aOtLjlcU94WkNDIKmA++UQexr
         vJWlMQHaBGPMr9RYBV1skVwvmOMo0hPMW8fTi2/asnes+O/T9Po5kvld/Yz3zgkGNZpJ
         creJ1zTbgo3ZgYeV7piLlT6ckOXtDW/JdrkBDlBi16GSwi5eEjGf3bV2lqcpd0+tydjk
         sr1w==
X-Gm-Message-State: AOPr4FU+xTgumRzRFjUwJjUAmdq1IrBhfAtzVf3vFHtKazkDmkZTgYlwl6VF3moNUJib7p6VB4h1ND9t4UBDgw==
X-Received: by 10.13.244.134 with SMTP id d128mr5312270ywf.72.1463074379722;
 Thu, 12 May 2016 10:32:59 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Thu, 12 May 2016 10:32:59 -0700 (PDT)
In-Reply-To: <xmqq4ma3grj0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294421>

On Thu, May 12, 2016 at 10:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> Seems like Junio was waiting for someone to point this out[2].
>
> Thanks. I think you covered most of them correctly; I only have one
> thing to add.
>
>>  * Comments are put after ---. So your paragraph
>>       "Clarify which commits need to be signed.
>>
>>         Uniformise the vocabulary used wrt. key/signature validity with OpenPGP
>>          - a signature is valid if made by a key with a valid uid;
>>          - in the default trust-model, a uid is valid if signed by a
>> trusted key;
>>          - a key is trusted if the (local) user set a trust level for it.
>>
>>            Thanks to Junio C Hamano <gitster@pobox.com> for reviewing
>>            the first attempt at this patch."
>>
>>     is actually treated as a comment.
>
> This is half-true, I think. The message you are responding to had
> only two dashes, not three.

My bad. Didn't carefully notice it.

>
> The usual way to do what the original wanted to do is like this:
>
>         ... e-mail headers like From:, Subject:, ...
>
>         Hi,
>
>         Here is a second attempt.
>
>         -- >8 --
>         Subject: Documentation: clarify --verify signature
>
>         Clarify that only the signature of the commit at the tip of
>         the branch being merged is checked.  Also align the
>         vocabulary to describe key & signature validity with those
>         used by OpenPGP, namely:
>
>          - a signature is valid if ...
>          ...
>          - a key is trusted if ...
>
>         Signed-off-by: A U Thor <au@thor.xz>
>         ---
>          Documentation/merge-options.txt | ... diffstat comes here
>
> Notice the "-- >8 --" (cut here) line.  "am" will notice it, discard
> what it has read so far and restart from there.

Not having used this personally, I forgot to mention this. Thanks for
mentioning it!
Looks like you have written the commit message for him. :)
