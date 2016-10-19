Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CFDA2098B
	for <e@80x24.org>; Wed, 19 Oct 2016 14:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941780AbcJSO2B (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 10:28:01 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36607 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941117AbcJSO17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 10:27:59 -0400
Received: by mail-it0-f51.google.com with SMTP id 139so105945268itm.1
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Id5f8+akYVLK++THT4agoJAOFibow4aWWvBU4O6+kg=;
        b=spZDazx2iN8u3MNmMhaHOd8vGpymv+XHxObSAJP1ARo/NG1EPXxvAwMlN3JKJef6C/
         zjgWTVK8NiE7gVavVNP5gaocQ28qMc4muQvJAufQJgc5JB3CJeg/tpOsnW0kJo510KtF
         nFwHBZRauofqidjMEDvb3sh+b7O3CzGLFXuCTUi71MRAF6ObkKxl9bXtIk9TCu9MSulP
         jIVAKZ+5npzmcntWG3ledCbo0PEA7aCCvPPjA3qVtub7rGhLlewHwzCe1pIxH3/Ofttm
         5fUt/zWqyXa2VgYMfWYVpGUEcxh8PUK05ZycFSvq6pShlnWlm9brcnCAaXVeGK/J8C0m
         b6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Id5f8+akYVLK++THT4agoJAOFibow4aWWvBU4O6+kg=;
        b=cEtPhWDikL0JO8UgbU8xCfeBvk5ZbhJ5YG1AetcBdpfQeHyuL6EF6VGNYv+APMk+No
         Q1GbbQ4rO5jdsSIy1Lscbz5D8cwNbmT6QOubLKY7FHTD6xLj2oHxEilxegCGr4YpapdM
         n90puDZ5aoLUyHLZtXUb1djPfJUa/3Ih/MInAKqYBHgWXy2tS1Cw+iQOGa5xU5PFQfb+
         Xpwi29K/G48xdfFYmBxDxRXnIfckE8wAf8cG/HeAe8lfIABG9Td+xiky9b3IKP4r2O7J
         9Ew2CG+dAzQzeAqYucVefsw4eeXmY9m92lhffoioEyO1wROFCS2imihYwNEU0rDg2hhN
         1PIw==
X-Gm-Message-State: AA6/9Rmh/GZ2nsCaeJGbF2OwFaOuf+1wHrV/93+z4fVyJYJoTqMBjMYqjHHGQ4vso3S1b0Pk91JQZb3EuVHL2A==
X-Received: by 10.36.76.15 with SMTP id a15mr6665016itb.74.1476883693822; Wed,
 19 Oct 2016 06:28:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 19 Oct 2016 06:27:43 -0700 (PDT)
In-Reply-To: <6B2BE996-F696-4EB4-91CA-849D40B8802D@gmail.com>
References: <6B2BE996-F696-4EB4-91CA-849D40B8802D@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 19 Oct 2016 20:27:43 +0700
Message-ID: <CACsJy8B50daiHWfu7zfVQnn_i_=HbUK3gBPmv1U=EUw7ZyuGPw@mail.gmail.com>
Subject: Re: git checkout crashes after server being updated to Debian X86_64
To:     Raffael Reichelt <raffael.reichelt@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 10:17 PM, Raffael Reichelt
<raffael.reichelt@gmail.com> wrote:
> Hello!
>
> I have a serious problem with git, After my provider had updated to a X86=
_64 architecture git crashes with various memory-related errors. This is ha=
ppening remote when pushing to the repository from my local machine as well=
 as trying it on a shell on the server itself.
>
> This are the error-messages:
>
> fatal: Out of memory, realloc failed
> fatal: recursion detected in die handler
> fatal: recursion detected in die handler

You other mail said memory is capped at 600MB, which should be a lot
for normal repositories. If you set the environment variable
GIT_ALLOC_LIMIT to maybe 500MB or lower (convert it to kilobytes
first) and git attempts to allocate more than that (just that one
time, not total mem) then it's caught and we get a glimpse of how much
memory git may need. Unfortunately we can't get a stack trace or
anything like that unless you rebuild Git from source.

> or
> fatal: unable to create threaded lstat
> fatal: recursion detected in die handler

Hmm.. with "max user processes (-u) 42" we should be fine because we
only create 20 threads max. What happens if you set core.preloadindex
to false? Can it run until the end or hit some other fatal errors?

There's room for improvement in preload_index(). If we hit resource
limit like this, it's not the end of the world and we should be able
to keep going. But threaded lstat has been available for a long time
and this is the first time I see a report like this, not sure if it's
worth fixing.
--=20
Duy
