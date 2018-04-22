Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92391F404
	for <e@80x24.org>; Sun, 22 Apr 2018 07:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeDVHls (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 03:41:48 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:39367 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeDVHlq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 03:41:46 -0400
Received: by mail-wr0-f178.google.com with SMTP id q3-v6so22887935wrj.6
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rpqHaBPKzy6fturYbRBaFU2QgcEO7vRKeqyJxozq5CU=;
        b=sm8UBai4TmSeiLeste7thmJKwAo8pfX0GiazF6Z6UbbkBDTe2bHj98wc0NdASgMOYh
         KZWPHRhS7Uwtd11Ic8nair83gR++iNVrrkLNTL4HT3kV9qhGkgeL6ipssRgPgpbrTbNR
         G85B04E//QlbvdN0dIfDOn3rHXNIkJMwQchhsPrzn7gg8pV/mJrlt4ppQ1grYYzLpdhq
         4pJu4q/SPoL/GX3aJK26TxuFcp3iNNLnd3yQouPUr6H/VNbGFIaQyqIQQhctMODUC78U
         f0jl7NhJy02IAGutJsOWqH2cAiF4Rm1XFX2lIMBns2aLyxxlkD/hlwLnvdFBlYKBqKXh
         BJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rpqHaBPKzy6fturYbRBaFU2QgcEO7vRKeqyJxozq5CU=;
        b=MoP/2lfW394qtwrF1bIyNVzF+1es8LImHVseM29+0Dojlfz26RbtIaAHL1P9kDDbTN
         Yl1U+awMVEoHKI5hbozI+h8QCm9PDgcTwKQCaDIL1Vy90xhaSNKc8yv0exb4IWaCHpxm
         UG0vwSYtCt4O61s9R4i97bNMIHhEoUx2z4HHewbrrvXEtfTx6g+pcV65g6NEklHKSue/
         qPpUj5xCYHHamCrzPzGAa8NjCAdx3aA226B069yB24nYq1SC1cmvxCSnz4aJ4L683AdE
         t01a47FhMrK1KjlNe+b7Sf1EbftWPWjh5X/ckXF1/enUlXiygB2V+zwZATJbnaAHxAxQ
         ZihQ==
X-Gm-Message-State: ALQs6tCUQUHh30RaX4IvVecM5jKDDjmV65zkHzlRl3GvDwU8ViLmC3Qq
        Tcix4RnvMnQqnY1/1sIeekAYwA==
X-Google-Smtp-Source: AIpwx4+GO/dll/ZjQQXYyHGswHUWpG6fsrC/mBKMSvk2dAI9cxva6xsxLWdIuxqLbaVmYpju7N2a2Q==
X-Received: by 2002:adf:a9aa:: with SMTP id b39-v6mr13604692wrd.36.1524382904572;
        Sun, 22 Apr 2018 00:41:44 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:11c:61ff:76ca:bd99? ([2001:a62:81d:ab01:11c:61ff:76ca:bd99])
        by smtp.googlemail.com with ESMTPSA id s22sm5961666wma.45.2018.04.22.00.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 00:41:43 -0700 (PDT)
Subject: Re: RFC: How should we handle un-deleted remote branches?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <87in8mdqhr.fsf@evledraar.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <3fcd1b50-2aeb-0ea4-fea7-b5705e76c027@gmail.com>
Date:   Sun, 22 Apr 2018 09:41:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87in8mdqhr.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.04.2018 um 14:14 schrieb Ævar Arnfjörð Bjarmason:
> But this is a possible work-around:
> 
>     git init /tmp/empty.git
>     git remote add avar file:///tmp/empty.git
>     git remote prune avar
>     git remote remove avar

This won't do it also?

	git remote prune origin


> I started to patch this, but I'm not sure what to do here. we could do
> some combination of:
> 
>  0. Just document the current behavior and leave it.
> 
>  1. Dig further down to see what other remotes reference these refs, and
>     just ignore any refspecs that don't explicitly reference
>     refs/remotes/<our_deleted_remote>/*.
> 
>     I.e. isn't the intention here to preserve a case where you have two
>     URLs for the same effective remote, not whene you have something
>     like a --mirror refspec? Unfortunately I can't ask the original
>     author :(
> 
>  2. Warn about each ref we didn't delete, or at least warn saying
>     there's undeleted refs under refs/remotes/<name>/*.
> 
>  3. Make 'git remote remove --force-deletion <name>' (or whatever the
>     flag is called) be a thing. But unless we do the next item this
>     won't be useful.
> 
>  4. Make 'git remote prune <name>' work in cases where we don't have a
>     remote called <name> anymore, just falling back to deleting
>     refs/remotes/<name>. In this case 'git remote remove
>     --force-deletion <name>' would also do the same thing.

Possible 5):

	Don't fix "git remote remove" but "git remote add" to complain that its
ref-namespace is already occupied by some other remote. Add "--force"
for the experts.

