Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EAAC202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbdCOVaT (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:30:19 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:35330 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdCOVaS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:30:18 -0400
Received: by mail-ua0-f179.google.com with SMTP id q7so15816313uaf.2
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wtw/bA/7rs7E/n1PFKShPIZlrZG3H/adFn23twdT/Lc=;
        b=sBJOVw8pkT9RHfyZQOAEoCIEjEpa6/70P/swUGSD/rEejIe0PDqdbgIxSOBe83G0wH
         zVoV8Yopoj1Ks7Lyx3ZfDzZjLOXCukZ+Qc7inyllPuxBrLxJ9kRPecio3CYwaYxDtMmB
         AMvoZJAoEjQEKHpGvMMK6pfvqXhEMV521Fm+ZvJ6ulEPjaxlBwuqCLnbkllyKZWH0buf
         ibi4V0OIMn4HYwC1io9opXMFxLOAGdbn6GJd+zZ/JfirbIlSbwRiX4DjE5VrBqQxlIV8
         8ap1AMMgAApMIOkXswa++qsJzNKV86Xy/+DrCHH8C0YYoD9+UIAqlD0OxpXxGUH03b0n
         FisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wtw/bA/7rs7E/n1PFKShPIZlrZG3H/adFn23twdT/Lc=;
        b=L1ZVyf0r1iwdcrO4G5WFDr3vu9IvrL41KAixf2quZEFQsN0eacrIZyBmwcitybrbmt
         9lIUt0dXP/+wYeiHZQMJ3QQD2kwonwDFcAbs1yQUMTSX3XToQH+AqyYzTklZCXfUkL0w
         dVVwBBaeFYrDYtayMtzljYQueC/uqFm/EFb4A0YldVHNSRUKTXCeYrypcfNj/SpapOae
         7j/52Xi0fWdsPssk3mJ/2T68GU2jA0YeSB3bX89LuxvHQAJAB5OsKX/9z/pvooM9yooq
         yaoeZivXjGw7WpEonfJm5pWeOeqOuYR8na5Tx+T8ZVk2inNAx/EgWMw7m+G1H/Ahc5Q6
         bzKw==
X-Gm-Message-State: AFeK/H1GOkmGpG76PwIcYrjJ/03UEDNszAHsIpD3jCajiDRrXg5VevLA76Za/78m/N8QDnExGQfNj0xOTiIh0A==
X-Received: by 10.176.74.27 with SMTP id q27mr499272uae.4.1489613332269; Wed,
 15 Mar 2017 14:28:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.87.218 with HTTP; Wed, 15 Mar 2017 14:28:51 -0700 (PDT)
In-Reply-To: <CAGZ79kbfNBbHgc4FrGoNNc54p65-xkQUQ6X3Ef9Ew9pioMzz7w@mail.gmail.com>
References: <CAME+mvW1x6fnGKt1_auGOp+wFYFR=Y_Qhxfd50E7KFe6t+X4kw@mail.gmail.com>
 <CAGZ79kbfNBbHgc4FrGoNNc54p65-xkQUQ6X3Ef9Ew9pioMzz7w@mail.gmail.com>
From:   Prathamesh <pc44800@gmail.com>
Date:   Thu, 16 Mar 2017 02:58:51 +0530
Message-ID: <CAME+mvX6EH+R6xRiCCYAg_gaguv4yeFD1T765+q7F8YMppeOhw@mail.gmail.com>
Subject: Re: GSoC Project | Submodules related work
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Valery Tolstov <me@vtolstov.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Also the conclusions which I was able to make from the mails[2] are:
>>
>> 1. We are catching commands typed by the user in an unpopulated or
>>    even an uninitialized submodule.
>
> What do you mean by catch here?

By catching commands, I meant that we identify that the user has entered
the command in an unpopulated or uninitialized submodule and respond
to the user accordingly.

>
> What happens is that Git is summoned in e.g. path/super/sub/ and when
> Git wakes up, it has to find out what is going on, e.g. where the repo
> is that it should work on.
>
> (0) it checks if it is inside the .git dir by looking for files like
> HEAD, config
>     objects/.)
> 1) It looks if there is a ".git" file or directory in the current directory.
> 2) if that is not the case go up one directory and check again.
>     repeat this step until either the repo is found or a filesystem boundary
>     is reached.
>
> And as uninitialized submodules do not have a .git, we'll find the
> superproject repository. Once the superproject is found, the
> subcommand itself is invoked. (e.g. cmd_add for "git add", in
> builtin/add.c; the function signature is just like main() except that
> it has an additional prefix parameter, which indicates the path
> from where we ended up at to the original invokation point,
> i.e. when invoked in  path/super/sub/, and the superproject
> was found at path/super/, the prefix is sub/.
>
>> 2. We first check if we are present in the superproject's root dir.
>
> After the repo discovery as described above we're in a root of
> *a* repository, and we have a prefix, which may or may not be
> an uninitialized submodule.
>
>>     we check for the presence of .gitmodules file,
>
> We have an API for that. :)
> See submodule-config.h#submodule_from_path that
> either returns a struct submodule or NULL if there is no
> submodule.
>
> However to detect if there is a submodule, we can to check two
> things: if there is a .gitmodules entry and if there is a gitlink entry
> recorded in the tree. Depending on the command we'd want to
> do one before the other. e.g. git-add most likely doesn't need to
> load .gitmodules, but may have the objects already loaded.
> So checking if a given path is a submodule is cheap compared
> to loading the .gitmodules file, so we'd probably want to do the
> cheap thing first.

Adding to this, we may use here this functions is_submodule_populated()
and is_submodule_initialized() from submodule.c

>
>>    from which we can check the path give is inside some submodule.
>>    *When .git file containing just a .gitlink is present then, I am not
>>    sure but even in this case the root folder contains .gitmodules
>>    file in the case of submodules(Please correct me here, if I'm going
>>    wrong), then we may still carry the same procedure as above.
>
> I think even when the .gitmodules file is missing, we want to have
> some sort of warning here, as it is a confusing state to run git
> from an uninitialized gitlink'd repository. The user may assume they
> run the command in the gitlink'd repo, so it may be better to bail out.

Can you please give an example of such situation ? I would like to
reproduce it and think further.
(As even in the case where the superproject is initialized using gitlink,
.gitmodules is in the same folder as that of the .git file containing
GIT_DIR path)

>
>>
>> 3. Once we can detect whether the $cwd is in a submodule, we can output
>>    "The submodule 'sub' is not initialized. To init ..." for all the
>>    commands which doesn't initialize and populate the submodule.
>
> It depends on the command what we want to do; for most commands
> this seems to be the right choice. For git-log we need to do a different
> thing, as you mention in 4)
>
>> 4. As similar detection could be used in the third project listed above,
>>    hence I even wished to include it.
>>
>> What are your suggestions about these projects? Also, will it be
>> rational to consider it as one complete project for GSoC?
>
> I think it is sensible to consider enhancing multiple commands, as
> one command is a very small bite for a GSoC project.
> And once you have the first command done, you'd generally know
> the vibe and the next commands ought to be easier. (though we'd
> still need to figure out different outcomes, e.g. step 3 or 4 as above).
>

Thank you for your suggestions. I will also look into more such cases
where I may enhance multiple commands so as to expand my project.

>> I think this might interfere with Valery's proposal[3] of shell to C
>> conversion of submodule related codes. What do you all think?
>
> I do not think there is interference with Valery's proposal, as this
> proposal would mostly work in builtin/{add,log,commit}.c
> (cmd_status is in builtin/commit.c for whatever reason)
> whereas Valery's proposal would mostly revolve around working
> in git-submodule.sh (deleting lines there) and
> builtin/submodule--helper.c (adding the deleted lines back here;
> in another language)
>
>> If it does interfere, then can we both work out on something common?
>
> I really do not see a lot of interference of these 2 proposals.

Thank you for confirming that. Now I may carry-on working on my
proposal for the project :) Also if it possible, I would like to
work on a smaller task related to my project first, as it will help me
understand about the project more, and which also will help me write
my proposal for the project.

Thanks,
Prathamesh
