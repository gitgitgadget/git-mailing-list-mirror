Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D8420986
	for <e@80x24.org>; Sun,  9 Oct 2016 11:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbcJILh7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 07:37:59 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38804 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbcJILh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 07:37:59 -0400
Received: by mail-it0-f54.google.com with SMTP id o19so55864228ito.1
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R4RQYTtlk00giBKauryoDTu2abQU22wCjZQPKMSr8Dg=;
        b=ZYQ9HoR6zMr36h/6diiDgFJGzOfhvGk9vOZQ+6Jd3AhyZg5sga5RdDyNlhlRzYMj7G
         e6ezI7HFNF7mTDpTr5TELoD4V+hCPzDXLRmhrmb9aCTCLEi+0qFF/xE5PNfc1GH/MVsa
         M8b9k9KfUtZrcqAEZMy1iI/OP8+n8U16fTWCiDxOn4soh5eEotIZtE9YXY6EcAspW024
         yRoc2QvcEmXrsUwWnlOn8N9iVREev+XchRg8hhKdiPM4qd7iybSFe701mbPqQwJ0Berv
         fZDe8n+J6q31NsfaArJjFjXI6fopYoNak0gOdeCVAUun+6VjifAiM24wOWtU0+3/4EHa
         oWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R4RQYTtlk00giBKauryoDTu2abQU22wCjZQPKMSr8Dg=;
        b=OwPgAoWzk2JKr2fK1OWAn9Wgwca/nJI8arhSNuevFleTyghkR8IUuf7df1ldyTtEy4
         nF5QZ+cmK+1pUW7mu/KwoPb1R+SI6GXgJj500vfXboTgEs8/kWHnuLHpl8Qa/2wze/1F
         fkUGJO62G/B8UEfJSk5Eq1IcBiQco64R7K0QS892LQx2uwUZjcBTnkSjSOmV77Oo98rH
         YxPxdHXmURfUNS8ii4eYg6Bn7suuK7B6NDODF/ZJMOCPT5JQtZwUQsX8q7cwl4QamfKu
         l12RUN2lmsPWPYy4laYYHbNTVfWo7gTfciHzF9n5tYQawgtGehw4CbhuAvCodT2otihw
         YhQA==
X-Gm-Message-State: AA6/9RldsU/xcDzpCBy2JsU8YieLdr9cVvsWBfltqv603ApuqJg2eg86lcQfvcizyC6shVTEehHKzcq1e0oobQ==
X-Received: by 10.36.112.135 with SMTP id f129mr5270702itc.3.1476013078228;
 Sun, 09 Oct 2016 04:37:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Sun, 9 Oct 2016 04:37:27 -0700 (PDT)
In-Reply-To: <CADKxhpd-gDczp05Ny6wP57RXafWWCimArfA9ki2phh+-gHez4A@mail.gmail.com>
References: <CADKxhpe3S4L9CPV9yxh2yhrtJMa9wyZAPC45u_S=RiuzY1Xrkg@mail.gmail.com>
 <CACsJy8C0kyKor4gCLSJrreRCazazbexvaSdbBg+Cka=-beZU_g@mail.gmail.com> <CADKxhpd-gDczp05Ny6wP57RXafWWCimArfA9ki2phh+-gHez4A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 9 Oct 2016 18:37:27 +0700
Message-ID: <CACsJy8DGvyWz2_VBsEfmDWOPGUGAUhKYhCa1qLEMcOdn83ocSQ@mail.gmail.com>
Subject: Re: Feature request: use relative path in worktree config files
To:     =?UTF-8?Q?St=C3=A9phane_Klein?= <contact@stephane-klein.info>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 9, 2016 at 6:22 PM, St=C3=A9phane Klein
<contact@stephane-klein.info> wrote:
> 2016-10-09 13:11 GMT+02:00 Duy Nguyen <pclouds@gmail.com>:
>
>>> * [worktree_foobar]/.git
>> This is made absolute on purpose. So that if you move worktree_foobar
>> away manually, it can still point back to
>> "[main_worktree]/.git/worktrees/[woktree_foobar]".
>
> Same problem if you move origin git repository.

We could fix up after moving the origin repository (because "gitdir"
file so far uses absolute paths, so we know where all the worktrees
are). But we have not done that.

>>> Why:
>>>
>>> 1. I configure worktree on my host
>>> 2. next I use this git working copy in Docker with volume share
>>> 3. next I've some git error in Docker because config files use absolute=
 path
>>
>> I think the common way of dealing with this in docker is put things in
>> the same path where it actually is outside docker. If you have stuff
>> at /path/to/foo, then you create the same /path/to/foo inside docker
>> and bind the data to that path. Does that work?
>
> It's not always possible. I can't in my project.
>
> I think there are some pros and some cons for relative path and absolute =
path.
> Maybe append a "--relative" option with `git worktree add` ?
>
> I've converted all path to relative and all work with success.
>
> What do you think to append this --relative option.

Patches are welcome.
--=20
Duy
