Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F6E1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966925AbeFSQD2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:03:28 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:32911 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966582AbeFSQD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:03:27 -0400
Received: by mail-it0-f68.google.com with SMTP id k17-v6so15122708ita.0
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=1GoZaeTuLlc+WnisG83FhtGvwUnJ20pA8vnHbgLymSM=;
        b=ebsTCb1XbBfd3O0qS/aHpoVzHVkG0V79wzT1wOWZaFxtIOlyZ+9Tqh/Re9mJOfcNfW
         gy0HttTLrSb1tPJYNTp/RKhvdeIQMEm/vVIRGggN8uECAU+nvppEaV3ywt8R7z9ImqAf
         n3+ovEiZrR6x1UA93GjPnkpSMttJxqXTQ9zupADp4YL5iDvbWhm8Wd4pTmyHvv/c5VjG
         VA5h4KH4IO4+iB/JFc7OalFp+od+viSkooVqNrwXz+CpDe7mJ/nXgVhega/pjatR4WSC
         6tD+lwZSGDsfpZRu7fxJnfGuCMkE2pvbfekXhhIhVBUuLWnv7I8rILIhXO2vWYudl9aw
         Ki1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=1GoZaeTuLlc+WnisG83FhtGvwUnJ20pA8vnHbgLymSM=;
        b=LNbvVQIxm94/88qfcs46olAIKEu52LEUUWFH8fjUXT9RLknX6d1GPfmhysQcAgVAUz
         74Jwpcry18XxNa7pjcoX7hSX7jxw/3UD/kxlIZYFrlEbekzPoUvGUDoOUwMJNRqrc744
         ZvS8MCn9n4Gb18BYBTshWlAIugrAxAhh/OE6v8ML6ORZb53UnBdIxjBBEyPGpNqRjsub
         bGbHPIlOK7uKAnuPEn2O0JcXDeEDm0r8CxLtFdtcZ+Efuz1b3OBAfv7mEObPZyLdyJLY
         y3KtEyHVBxT2IVblWxBACgl4A0hA4UnhWBbtymqyxosmnPwla5Reats5lg/zhhNAKiLL
         UZjg==
X-Gm-Message-State: APt69E3Pmw/nCFyLxl2CJ7JFQG/JU8zifacUp6HHwPI8Lan9T6AwzcW3
        ZdjiI7vrc3fxGKgDoX37AKtZ/BQzcrZDWQUEwmF71Q==
X-Google-Smtp-Source: ADUXVKJNIf4rlJGLFFOxJTe0EDlG7lTbAElhk1nOR1GHowLndgegE/30k+nm41hRe3BVcNSsmQ/fPo01bdTSAjzC+W8=
X-Received: by 2002:a02:3941:: with SMTP id w1-v6mr14357887jae.132.1529424206817;
 Tue, 19 Jun 2018 09:03:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad5:50cd:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 09:03:25
 -0700 (PDT)
From:   Sam Kuper <sam.kuper@uclmail.net>
Date:   Tue, 19 Jun 2018 17:03:25 +0100
X-Google-Sender-Auth: 67L-pfl7R16k6rj55C9lXFMGvYw
Message-ID: <CAD-JurKx76FjVhk6QvmZ-BH=3RfmuA998KF+GRe8Kb+oB6pm8A@mail.gmail.com>
Subject: Re: Branch switching with submodules where the submodule replaces a
 folder aborts unexpectedly
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12 Oct 2017 at 11:48 Thomas Braun wrote:
> On 9 Oct 2017 at 23:59, Stefan Beller wrote:
>> On 9 Oct 2017 at 14:29, Thomas Braun wrote:
>>> I'm currently in the progress of pulling some subprojects in a git repository of mine into their
>>> own repositories and adding these subprojects back as submodules.
>>>
>>> While doing this I enountered a potential bug as checkout complains on branch switching that a
>>> file already exists. [...]
>>>
>>> `error: The following untracked working tree files would be overwritten by checkout:`

I am currently attempting the same thing, and experiencing the same
bug, using Git 2.17.1.


>> (And I presume you know about --recurse-submodules as a flag for git-checkout)

The behaviour seems to be the same regardless of whether I use the
--recurse-submodules flag with git-checkout.


>> This is consistent with our tests, unfortunately. [...]
>>
>>> If I'm misusing git here I'm glad for any advice.
>>
>> You are not.
>
> Glad to know that.

I was also glad to see this reassurance :)

It might have been nice if the reassurance came at an earlier stage,
however: at the CLI, rather than only after searching the mailing
list. A user who does not think to do the latter might well labour
under the misapprehension that they have done something wrong, rather
than encountered a bug. Perhaps, if the bug is not going to be fixed
terribly soon, a sentence or two could be added to the error message
explaining the situation and advising the user of a workaround?

Speaking of which, what is a good workaround in this case?

`git checkout --force <branch>`?


>> Apart from this bug report, would you think that such filtering of
>> trees into submodules (and back again) might be an interesting feature
>> of Git or are these cases rare and special?
>
> For me not particularly. In my case it is a one time thing going from an embedded project folder to a submodule.

The option to convert an existing directory into a submodule is
something that I think developers like to have available. It seems
intuitive: "Oh, I see now that what this directory holds is
effectively a separate project. Let me check out a new branch, and
replace the directory with a submodule on that branch. Assuming it
goes well, then I will afterwards merge this new branch into master."

Regardless, the bug has clearly been giving people headaches for
several years (forgive me if you were already aware of these data
points):

- https://ryansechrest.com/2014/03/git-error-switching-branch-replacing-directory-submodule/

- http://blog.dcycle.com/blog/105/gitsubmodulizing-and-gitflow/

- https://stackoverflow.com/q/9299063

- https://stackoverflow.com/a/48402543

- https://stackoverflow.com/q/24091246

- https://stackoverflow.com/q/29372450

- https://github.com/supercollider/supercollider/issues/2001

- https://github.com/supercollider/supercollider/issues/2221

Thank you to Thomas for reporting this issue to the mailing list, and
to Stefan for the helpful reply. Thanks as always to the Git
maintainers, and good luck with fixing this bug :)
