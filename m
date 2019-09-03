Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940F51F461
	for <e@80x24.org>; Tue,  3 Sep 2019 13:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfICNeZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 09:34:25 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:42144 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICNeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 09:34:25 -0400
Received: by mail-qt1-f178.google.com with SMTP id t12so19877631qtp.9
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 06:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=o8x+unXu1cYWYpiFBbvC28mz2EVm8jbDsGdLhD5nyi8=;
        b=G8YiEkeGfgWSvA2aNZGm4KYboZN5uu4DOrUbbvWxbHpa32GJczRAn6oY2oD4xnWCJQ
         MssFvzHHm3K3CS/O4IQTGBoUG786dLlySeB5J8O0Q+qpovgfENv62/qzEPhg7+1bdC92
         I0Rk4jip8K6xMtFKUYRursOmgdzdVrq4jPp7F2ITyfjpTUMyUafue5I3Q+CF8IQbe7kX
         R02Z+xvQSgn/tEtCL/wDmyugbM5SVXSOUv9Xbn4TZlL11OlkCSiDKozBGrBTZJtSstQ5
         zoH9eTvC0sUUX0pIQMRCZv4Z+Kj+4HYMYPiEAfKX8AqqSRAVksbmVLJQRvYc8hLrhKnw
         upTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=o8x+unXu1cYWYpiFBbvC28mz2EVm8jbDsGdLhD5nyi8=;
        b=fqYLIbbLVjaocJL37nxGJX+pVu37of4QWaS5SiHiaGYwNocHPiEeZbqrAEC+dAeAu4
         iJwBBIw5LnZGm9IkqBJ/mdPhRNFA08aoXgaCfarLJ7YnLKgf4jVLlGsNMP8UV7pldJ8V
         MlOTJGEueSWqgrA2bNJA5SbMgPc+/uC29yI4SKArzJk/rGQmqCUfl4rDBbGLcN3B6Kgc
         AxAEoeUpmofqdcdL3bs1UqYUWspdVH7gDkUP9gTubum6OtHPRSdkwK2n+tqKmYNDBxVy
         4lt5KKlihFyvcswFl9F1kNfmbOvo/3mfTkEqTLt6O2BD18+wTtzaH100aRVtmVQBKVGx
         Gdtw==
X-Gm-Message-State: APjAAAVttconnLSuSWTWv08xR4X9CX3UQ7q2m4sMMM3vjsA6JlEUKKxq
        xpHwx5TUwBqE3YzQPVfTgcwgZOquoJk=
X-Google-Smtp-Source: APXvYqxeukIaib+6bZqTuz96JfyjPUx49Ns40b6txVsNZjU4NO4Xk3DV7M6r5lASdNNrmWryQA1BWw==
X-Received: by 2002:ac8:30f3:: with SMTP id w48mr31960795qta.216.1567517664280;
        Tue, 03 Sep 2019 06:34:24 -0700 (PDT)
Received: from localhost ([2605:9480:205:dfe1:fd52:2b30:74d5:e918])
        by smtp.gmail.com with ESMTPSA id w126sm8582973qkd.68.2019.09.03.06.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 06:34:23 -0700 (PDT)
Date:   Tue, 3 Sep 2019 09:34:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git does not recognise directory named '${sys:DATA_ROOT_DIR}'
Message-ID: <20190903133422.GA51158@syl.lan>
References: <CAHMHMxW4-6AZEDaJU8KOy2kRSLXjdC_RTH528=nnhVLXh=ADUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHMHMxW4-6AZEDaJU8KOy2kRSLXjdC_RTH528=nnhVLXh=ADUA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Sep 03, 2019 at 03:44:14PM +0300, Σταύρος Ντέντος wrote:
> Hello there,
>
> While the name is obviously a mistake, git refuses to even acknowledge
> the directory.
>
> ```
> u@h:~/$ mkdir init-test
> u@h:~/$ cd init-test
> u@h:~/init-test$ git init
> Initialized empty Git repository in /home/u/init-test/.git/
> u@h:~/init-test$ (master #) mkdir \$\{sys\:DATA_ROOT_DIR\}/
> u@h:~/init-test$ (master #) git status
> On branch master
>
> No commits yet
>
> nothing to commit (create/copy files and use "git add" to track)
> u@h:~/init-test$ (master #) git add
> .git/                    ${sys:DATA_ROOT_DIR}/
> u@h:~/init-test$ (master #) git add \$\{sys\:DATA_ROOT_DIR\}/
> u@h:~/init-test$ (master #) git commit --signoff -m'a'
> On branch master
>
> Initial commit
>
> nothing to commit
> u@h:~/init-test$ (master #)
> ```
>
> Is that expected?

Git does not track empty trees; that is to say 'git add' on an empty
directory does not change the status of the index.

Try for example:

  $ git init repo && cd repo
  $ mkdir -p dir
  $ git add dir
  $ git status

And note that 'git status' says there are no changes.

On the other hand, 'git add' performs fine even in a directory named
'${sys:DATA_ROOT_DIR}'; simply create a file (even an empty one) within
that directory and then run 'git add'. It will stage your "changes" as
expected.

If you wish to keep this directory "empty", but stored in Git, a common
convention is to create an empty '.gitkeep' file in the directory. This
file is not special in any way to Git, rather it serves as _a_ file to
keep the directory non-empty.

Hope this helps.

> Ντέντος Σταύρος

Thanks,
Taylor
