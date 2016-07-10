Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78071F744
	for <e@80x24.org>; Sun, 10 Jul 2016 08:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbcGJIiz (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 04:38:55 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36566 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbcGJIix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 04:38:53 -0400
Received: by mail-io0-f173.google.com with SMTP id s93so34446600ioi.3
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 01:38:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Nt0B/qDuYGhJaGuKslESa0DRa0v/ZnHrgovpJxciIs=;
        b=DmFlRmO2vj5YesYPpr1qiQHAfMimjmJumgWgv81tswb1rSiIVhbTn+RXaN/+ai6zf/
         r9AxkzN7RGInIN2/DRxSsOsgEaO9DqT00tuYIPMx5Ai895RmX3wPzQT73XFYg/CBdNeN
         2R6jlNHJ6ReW3rxnMuCFsdCxjfYskjMCy8RnQHImsl5Y0yg+xi0Wn2fiNOaHiIjJtvgZ
         Psso9uXd52/NebfKMaV36Gf9ypkjTAtpoZL9iJ0nhYoe6RB7D6nTKmuywEENzO+bvWIp
         EVN3UVXGLodjhhwZ+39Aj7jz7P34cD7z+rLPyqpalwXTHz73OsWcQHH3UkyBY9nZpG2j
         Iz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Nt0B/qDuYGhJaGuKslESa0DRa0v/ZnHrgovpJxciIs=;
        b=ks27uB6DUFdMHTLctPL78VCIXsdUHyn3lHH3cP6PHnq24HpExBERrDlno3DF1ovpyp
         mpOCCGlQh5mZMttGoARM58NyRJquHP8/5E9v+iR6IMfSolvhZ8O9tKwPUlMZCjff3UMb
         aXV8YWn8LF+DaCuSTnhOW4p3hm4AAvv5zt48C6ZCiGiTb9rsqwf/5T5hbgvh4IXqF9Qv
         PMw2VB2BvsI3B3YgyNFcWQrRrreBNDMcjq7Jjt9VILjTUVA1WLqmb+KgNmrJDfn7p8gD
         MgGb4ozWVZHFdC7VXJWcIO9KUgNIL11BGV3xsidKzOWuOfeLZrU3qzz13NJgVjo1hrY9
         nI2g==
X-Gm-Message-State: ALyK8tLYEm7EpjMyIYO1fyFEJaJHVf/1GG9XGNkPdUjuVtlT58n8tB71pnFiX4cBfDYx8yg6W3Tsc4L6PvN/6g==
X-Received: by 10.107.148.79 with SMTP id w76mr17078017iod.47.1468139932299;
 Sun, 10 Jul 2016 01:38:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.12.216 with HTTP; Sun, 10 Jul 2016 01:38:32 -0700 (PDT)
In-Reply-To: <20160707033538.GA7595@sigill.intra.peff.net>
References: <CAK8tuqiZjfrvHCoxkFUqoDx0+9=FUxfE93aMhUkYYZAAWm-u_w@mail.gmail.com>
 <CAK8tuqhMiHqPoK4gk7onT+VXsLJE5ogcpu7dc=_8am+ifL=5yQ@mail.gmail.com>
 <87a8hubtw4.fsf@linux-m68k.org> <20160707033538.GA7595@sigill.intra.peff.net>
From:	Peter <peter.mx@gmail.com>
Date:	Sun, 10 Jul 2016 10:38:32 +0200
Message-ID: <CAK8tuqiCMUjoS_xXKSJ4qiGK8ioAjfGsQ3_WO0OQj5-5-i7rOw@mail.gmail.com>
Subject: Re: Fwd: git rm
To:	Jeff King <peff@peff.net>
Cc:	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

So if I do:

touch abc
git add abc


And after that I do:

git rm abc


Can you agree that there is an asymmetry of two commands vs. one? Git
add only touches the files in .git/ and git rm ALSO affects the
working tree...

Is "git rm" or "git rm --cache" used more often in practice?


Peter

On 7 July 2016 at 05:35, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 06, 2016 at 06:42:19PM +0200, Andreas Schwab wrote:
>
>> Peter <peter.mx@gmail.com> writes:
>>
>> > I am a lightweigt git user so by all means not a reference, but I was
>> > wondering why exactly does "git rm" also delete the file (remove it
>> > from the working tree). I see it as an unintended behaviour as git is
>> > written in a way that it preserves the most data.
>>
>> The data is still preserved.  You can restore it with "git checkout HEAD
>> <file>".
>
> Assuming the file is present in HEAD, of course. But if it is not, then
> git should (and does) complain and ask for "-f".
>
> -Peff
