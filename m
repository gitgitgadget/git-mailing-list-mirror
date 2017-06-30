Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25AC5202AB
	for <e@80x24.org>; Fri, 30 Jun 2017 18:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbdF3Sdv (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 14:33:51 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36719 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdF3Sdu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 14:33:50 -0400
Received: by mail-vk0-f44.google.com with SMTP id y70so70550307vky.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6lplp9M4WfwV/n3EygL/GoVooC6pI/jWwhKgz2vnmbM=;
        b=vWrTvqOT4hlwNPDEDGJlI0WcJtutwULTzxECuJwR3fy8dNlEQYI/ABhTlIzz+1uM9N
         wU9Qa8qjI01ObNZumu2NvKpegJBFI0xv78AFFil0cOg5lgRiLpnkSk2yJ/1iUpiiAwu9
         lCcTkwc5zvpG0UEhE7PZPQ2QgDrhqyf3vwr2dJPuqqMAmv/LPOikbtT3lpIzgplA0Fub
         Zrzi0Zwc6V1RTyS8OI9OxP1qqWsQzI1mxMZ6Y8I4e0SCX7Gjc9iSXUYf4xOuFWz8tI3r
         +MoTfvCRGjUvnR5HMmNIR8BrDsS2um8feuncavxlb6n0OcogBPbCk7m1pAkd/kPqOxiB
         08ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6lplp9M4WfwV/n3EygL/GoVooC6pI/jWwhKgz2vnmbM=;
        b=dN5J6HpGdKRBCohmPIjeUx5hDZ+mOquUBsmPBGVpAQVF93U6pfrQYdcQ5Ax6EQ9aNM
         zS5HWS+KuZI9GqPpaAuQEig0fdOg7bDxYJdG/jxM7QJ9s3uwBx8RlQcGyRUvjzEz+iQ9
         vpOBFDufpNWi/l540sI2h8BhmeF3DdoamhgHo3dR8MzaICBojzYdymQ1ezE3y0e7d5kz
         3N1+BlsCKh3bbRVacqhkYnwFjAU/MCq9KMlBMk8HQRpDrQxMXfrFgtGripLY+x0Fj4lK
         Vn3SBDy2Ki/Z2Z/Lbi+YNkBIH/ETWR1TcmoqKJO3omswIszWDavsFCWNbuFV6kCFB+7+
         cH+g==
X-Gm-Message-State: AKS2vOyHsVcNdBOwYoin6aXBz7IZS9JaHj96h2oxs8kmFq/KcAypQSB+
        v6214+5c5RZVYU3FpxWZ7WE1IvP7Sg==
X-Received: by 10.31.200.196 with SMTP id y187mr12652991vkf.95.1498847629809;
 Fri, 30 Jun 2017 11:33:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.18.223 with HTTP; Fri, 30 Jun 2017 11:33:49 -0700 (PDT)
In-Reply-To: <CAGZ79kYd+3OoUBcsTS9=S9qEUwKj9ypyHyjXLBW=KjWOVoae4A@mail.gmail.com>
References: <CAFirYm_LLCUNdppZ7kKGwijJNNvhCaQtoJzRBVRsvhF+=bqgrw@mail.gmail.com>
 <xmqqefu2tyzc.fsf@gitster.mtv.corp.google.com> <CAGZ79kYd+3OoUBcsTS9=S9qEUwKj9ypyHyjXLBW=KjWOVoae4A@mail.gmail.com>
From:   Laurent Humblet <laurent.humblet@gmail.com>
Date:   Fri, 30 Jun 2017 20:33:49 +0200
Message-ID: <CAFirYm_UzUe=zSefAVpt45OuEwKyn7bAZbumLXYWbPFVRahPew@mail.gmail.com>
Subject: Re: Warning suggestion for git stash drop
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your feedback.

I suppose that turning a hypothetical confirmation option 'on' would
impact a stash pop for instance as it automatically drops the stash if
it was applied without conflicts.

What about a --confirm flag?  You could then simply alias 'git stash
drop --confirm' locally and it wouldn't impact anything else?

Have a great week-end!

On 29 June 2017 at 20:56, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jun 29, 2017 at 11:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Laurent Humblet <laurent.humblet@gmail.com> writes:
>>
>>> Would it be possible to add an optional Yes/No when doing a 'git stash
>>> drop'?  Something similar as what happens when pushing on a remotely
>>> checked out branch (with a config setting to turn the warning on/off).
>>>
>>> I know that you can always get your dropped stash back using git
>>> reflog but a small warning might be a useful feature to avoid unwanted
>>> stash drops on a regular basis.
>>
>> I sympathize with this, but the same principle also would apply many
>> destructive commands like "git reset --hard", "git rm <path>", etc.
>> and also "/bin/rm -f" ;-)
>>
>> I however do not think a good general way to do this without
>> breaking people's scripts.  When they do 'stash drop' in their
>> scripts, they know they want to get rid of the dropped stash
>> entries, and they expect that the user may not necessarily be
>> sitting in front of the shell to give the command a Yes (they
>> probably wouldn't even give the user a message "the next step
>> may ask you to say Yes; please do so").
>>
>> On the other hand, just like "git reset --hard" and "git clean -f"
>> does not have such safety (i.e. the user is aware that the command
>> is destructive by giving "--hard" and "-f"), "drop" may be a sign
>> that the user knowingly doing something destructive.
>>
>> So I dunno.
>>
>
> I was about to propose to have an easy undo operation, such as the
> reflog. But then I checked the man page for git-stash and it already says:
>
>        older stashes are found in the reflog of this reference and can be named
>        using the usual reflog syntax (e.g. stash@{0} is the most recently
>        created stash, stash@{1} is the one before it, stash@{2.hours.ago} is
>        also possible). Stashes may also be referenced by specifying
> just the stash
>        index (e.g. the integer n is equivalent to stash@{n})
>
> Maybe that needs to be polished a bit more?
>
> I myself used the stash back then (I don't use it any more), and I assumed
> the stash was a stack of changes, but the data structure seems to imply it
> is only one thing that can be stashed and the reflog enables the stacking
> part, such that a dropped stash is gone and is not recorded in the reflog.
> Dropping a stash seems to just erase the topmost line from the stash reflog,
> so it really is as destructive an "/bin/rm -f"
>
> So getting back a dropped stash via the reflog is not via asking for a stash
> reflog but rather for HEADs or a branchs reflog, which may be complicated.
