Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F381FCA9
	for <e@80x24.org>; Mon, 12 Sep 2016 05:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755704AbcILF74 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 01:59:56 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36658 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753016AbcILF7z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 01:59:55 -0400
Received: by mail-oi0-f43.google.com with SMTP id q188so175766721oia.3
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 22:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qnz6eC2mLH5q2ucCwrnC9Cz5mIPQmLS7UBVjc46hRLI=;
        b=Q3ajYM2Aeq0aNWxzCQv5zMURgMjnuQUI7L8b2fvUjCKntqqArCiYXUgYp9TkOJadwl
         GmqZqHZaYGzXXkZoc6vVhXgAz+LNfAo7zfscMsl+1Gh+xTf/IPyQjLJswWl1Lj3xSCbp
         q9+3Doq2hSYsO0HWVV6Y7k3nVAH4kqEHJ1KaUQbA3ichzrCx0+sXIkbEzS6h+OA1zLwn
         jfYvavW5RGA6nypbxxAW33vO0V0iKjEZSUm1UaE3FXjWgwh4ip0xKVgsNyOgrO9TlQzh
         Tvmr1kgNlUdwgbV3TpMZhi/FDluUjUjrSf2Cw+HFuuVz4NOFXYm7HlkL1hw2cL8BtuPU
         YfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qnz6eC2mLH5q2ucCwrnC9Cz5mIPQmLS7UBVjc46hRLI=;
        b=bejg5jiK1szvcdPT/c+fowWO0Xn/kGx1vLqbz25gfOioGq/2HoJb+eXxcBt4u0Ql+1
         UjrqgfQ6OmDNWknqL9dPua66xhJtGQGgpxmO+OP6paCIFWIHJHy+AVl8vCnhWIubUAHh
         GjEKWHgrpLMtiNchJ78BRoqFI8JkFNGnI/Jx25Zv/T5BpLNTA1HFQLnMEXE3y/P+Aa6f
         e92YoP8EtyHBD5BCE3G1vCGp1dkL+PzwmC3egB8klMa44bSVOonEOYDY3oQs404+dVdC
         6I8hVXlgCIq4kh2CykfGvAxvMww4tnhsCtAF5y2g34lVCaJzCUpDT5VCRAsrYApxISbL
         Wp7w==
X-Gm-Message-State: AE9vXwMlEc8go8yL+iR3E/4VJMsXK7roRq87OzhfGEFEJ5nIAYj7TFYBwMRhqrI8SPovOpDye4iIuKoGG6DRoA==
X-Received: by 10.157.37.215 with SMTP id q81mr21002805ota.202.1473659994935;
 Sun, 11 Sep 2016 22:59:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.33.202 with HTTP; Sun, 11 Sep 2016 22:59:54 -0700 (PDT)
In-Reply-To: <20160911193906.GC8254@hank>
References: <CAFZEwPPSiy1dxZgxWg1saPcw2QWgHtZKx26oSN3g1mCv25=0AA@mail.gmail.com>
 <20160911193906.GC8254@hank>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 12 Sep 2016 11:29:54 +0530
Message-ID: <CAFZEwPN=gBdBPmyxRDz8yLfTKAcGjAwW_mVUDGe+83JUNc4L3g@mail.gmail.com>
Subject: Re: Bug: git-add .* errors out
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Thomas,

On Mon, Sep 12, 2016 at 1:09 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Hi,
>
> On 09/12, Pranit Bauva wrote:
>> Hey everyone,
>>
>> One of my friend was trying to add files using the command `git add
>> .*` and got an error that "fatal: ..: '..' is outside repository"
>> which did seem a little obvious to me. But then I tried to reproduce
>> it in my machine with `git add ".*"` and it didn't error out. I am
>> currently using git 2.9.3 on Ubuntu 15.04 while he is using git 1.9.1
>> on Ubuntu 16.04. What might have gone wrong?
>
> The difference seems to be that you quoted the .*, which leaves the .*
> in place for gits internal pathspec machinery, which then only
> considers paths inside of the repository.
>
> The non quoted version your friend used meanwhile is expanded by the
> shell itself, which seems to be expanding it to ., the current
> directory, and .., the parent directory.  This behaviour also depends
> on the shell used, for me .* in bash includes the current as well as
> the parent directory, while .* in zsh doesn't include either of these.

This seems to be a reasonable reason. I had guessed the behaviour of
the shell but didn't really know what was happening with the quoted
version. And I guess it cannot really be fixed because it depends on
the shell. I tried it out on bash though forgot to mention it. Thanks
for the help!

Regards,
Pranit Bauva
