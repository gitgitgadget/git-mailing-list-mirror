Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A1E1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 19:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJQDEs (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 23:04:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40767 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQDEs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 23:04:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id r1-v6so22480182edd.7
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hdcOefKgxK6mqGxyU9KgRwc03AvTc5aGYXtSjxW7YbU=;
        b=ZFx5yB9/a15joeqhN08wcDyYeoqxBotcw35EbfN+7PDiHUludT0aSgIRvljit3kKzX
         mwW0CZX1ic9rp2nfYvr9OQhj8IOhQcjzEC37zMQKeMVXzUtg2y9k/cVlRGpQxWp45oT1
         sDJ1Jic4II6pN1L3FLxB2JHxPnnEVUEzghc41wk+fcWQjVIO6Ge28zuNtqbSjjxqOJef
         Wj1b2Wih7/xPqAQzNk3Z2v1wJn46aspF4qYDg7xAM4bXknLEdzVQHJr1pYhHuU743r4T
         XJEDLzZYrn8ItsNC8Guw4ntTQmBWII/PAPtBse+mMDKE5PgdVowm8t02nP11WRjTsT2p
         UCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hdcOefKgxK6mqGxyU9KgRwc03AvTc5aGYXtSjxW7YbU=;
        b=ZewFZ6jrxm5Y9HYJGccBLKMqL2TIHILj37BSooU4eUcjfvAbNX35duf/ByTtkAmkED
         4ROqADh0F3LViFb5iKGb0TIANubHJyAviE9BTuAdwg1IIxLDNnhBF1X0OKUkfCL9t6j+
         2B9N6aMSGkMUVPjGf/zSXWL2qRDxclDoMZ6zP2QXVyEwZVjWdAUn0Bi1nEHH7Yfa4mBi
         +L7AhSQkKYqDrAW5kA5FQDmB+zjYdwsMS8JMEZvK+vvfYyUJ40hy1ZawDjI4pXiixx0H
         W0oW+bBWB2c+OQxgr7VtIF2GnfidCnsesIkW4m2cgmawwt30XJ2XD1mp3D7UhNjGWvds
         nL3g==
X-Gm-Message-State: ABuFfoh5xK3d/A1keqIGFrLYsZHA/5e7C8WmLUwpAiZBHO8vnFa2uZxw
        HUCEjBrUla3FXEqoSG4X4kc=
X-Google-Smtp-Source: ACcGV60r7Iv5fikBOqb8TbuvJPAnsMKIYFxES+POR2itmu3Fv227mdInvThSiRhXea6Wd4+oZBbs0A==
X-Received: by 2002:a50:b5e6:: with SMTP id a93-v6mr32518782ede.279.1539717173849;
        Tue, 16 Oct 2018 12:12:53 -0700 (PDT)
Received: from szeder.dev (x4d0caaf1.dyn.telefonica.de. [77.12.170.241])
        by smtp.gmail.com with ESMTPSA id v11-v6sm3097617ejj.19.2018.10.16.12.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 12:12:52 -0700 (PDT)
Date:   Tue, 16 Oct 2018 21:12:50 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 06/13] Add a build definition for Azure DevOps
Message-ID: <20181016191250.GO19800@szeder.dev>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
 <1a22efe849d6da79f2c639c62a1483361a130238.1539598316.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a22efe849d6da79f2c639c62a1483361a130238.1539598316.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 03:12:06AM -0700, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/azure-pipelines.yml b/azure-pipelines.yml
> new file mode 100644
> index 0000000000..b5749121d2
> --- /dev/null
> +++ b/azure-pipelines.yml
> @@ -0,0 +1,319 @@
> +resources:
> +- repo: self
> +  fetchDepth: 1
> +
> +phases:
> +- phase: linux_clang
> +  displayName: linux-clang
> +  condition: succeeded()
> +  queue:
> +    name: Hosted Ubuntu 1604
> +  steps:
> +  - bash: |
> +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
> +
> +       sudo apt-get update &&
> +       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin &&
> +
> +       export CC=clang || exit 1
> +
> +       ci/install-dependencies.sh

I think you would want to 'exit 1' when this script fails.
This applies to other build jobs (erm, phases?) below as well.

> +       ci/run-build-and-tests.sh || {
> +           ci/print-test-failures.sh
> +           exit 1
> +       }
> +
> +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
> +    displayName: 'ci/run-build-and-tests.sh'
> +    env:
> +      GITFILESHAREPWD: $(gitfileshare.pwd)
> +  - task: PublishTestResults@2
> +    displayName: 'Publish Test Results **/TEST-*.xml'
> +    inputs:
> +      mergeTestResults: true
> +      testRunTitle: 'linux-clang'
> +      platform: Linux
> +      publishRunAttachments: false
> +    condition: succeededOrFailed()
> +
> +- phase: linux_gcc
> +  displayName: linux-gcc
> +  condition: succeeded()
> +  queue:
> +    name: Hosted Ubuntu 1604
> +  steps:
> +  - bash: |
> +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
> +
> +       sudo apt-get update &&
> +       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin || exit 1
> +

On Travis CI the Linux GCC build job uses gcc-8 instead of whatever
the default is in that old-ish Ubuntu LTS; see 37fa4b3c78 (travis-ci:
run gcc-8 on linux-gcc jobs, 2018-05-19).

> +       ci/install-dependencies.sh
> +       ci/run-build-and-tests.sh || {
> +           ci/print-test-failures.sh
> +           exit 1
> +       }
> +
> +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
> +    displayName: 'ci/run-build-and-tests.sh'
> +    env:
> +      GITFILESHAREPWD: $(gitfileshare.pwd)
> +  - task: PublishTestResults@2
> +    displayName: 'Publish Test Results **/TEST-*.xml'
> +    inputs:
> +      mergeTestResults: true
> +      testRunTitle: 'linux-gcc'
> +      platform: Linux
> +      publishRunAttachments: false
> +    condition: succeededOrFailed()
> +
> +- phase: osx_clang
> +  displayName: osx-clang
> +  condition: succeeded()
> +  queue:
> +    name: Hosted macOS
> +  steps:
> +  - bash: |
> +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
> +
> +       export CC=clang
> +
> +       ci/install-dependencies.sh
> +       ci/run-build-and-tests.sh || {
> +           ci/print-test-failures.sh
> +           exit 1
> +       }
> +
> +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || umount "$HOME/test-cache" || exit 1
> +    displayName: 'ci/run-build-and-tests.sh'
> +    env:
> +      GITFILESHAREPWD: $(gitfileshare.pwd)
> +  - task: PublishTestResults@2
> +    displayName: 'Publish Test Results **/TEST-*.xml'
> +    inputs:
> +      mergeTestResults: true
> +      testRunTitle: 'osx-clang'
> +      platform: macOS
> +      publishRunAttachments: false
> +    condition: succeededOrFailed()
> +
> +- phase: osx_gcc
> +  displayName: osx-gcc
> +  condition: succeeded()
> +  queue:
> +    name: Hosted macOS
> +  steps:
> +  - bash: |
> +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
> +

Here you should 'export CC=gcc', because on macOS 'cc' is 'clang' by
default.

Note, however, that setting 'CC' in the environment alone has no
effect on the build process, it will still use 'cc'.  Keep an eye on
where this thread will lead to:

  https://public-inbox.org/git/20181016184537.GN19800@szeder.dev/T/#u

> +       ci/install-dependencies.sh
> +       ci/run-build-and-tests.sh || {
> +           ci/print-test-failures.sh
> +           exit 1
> +       }
> +
> +       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || umount "$HOME/test-cache" || exit 1
> +    displayName: 'ci/run-build-and-tests.sh'
> +    env:
> +      GITFILESHAREPWD: $(gitfileshare.pwd)
> +  - task: PublishTestResults@2
> +    displayName: 'Publish Test Results **/TEST-*.xml'
> +    inputs:
> +      mergeTestResults: true
> +      testRunTitle: 'osx-gcc'
> +      platform: macOS
> +      publishRunAttachments: false
> +    condition: succeededOrFailed()
> +
