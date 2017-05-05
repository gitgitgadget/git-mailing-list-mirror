Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA3B207FF
	for <e@80x24.org>; Fri,  5 May 2017 11:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbdEELtv (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 07:49:51 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33315 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdEELtt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 07:49:49 -0400
Received: by mail-wr0-f179.google.com with SMTP id w50so2417253wrc.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=flYFZX4xtunESveWweX9oaYarEf6r3sR5/6diYLfUqI=;
        b=WWkW9CFwwYDR80DiWJ2xD9je3cwpxEoCR30tmjnYBB++SqwwSKgbAw9fXAe6u/xJit
         gl7r3HLTlA2TaSec4XRxywrfzGljsv/the6i9QY56DWfrlGookNxn0mXmt52oWkZanaX
         0Yu+L39gm5j2mA2AunsCJ8V464zuK6555+p5/ZgamHbTJ5TyJ9KfFmSlzEtkfVncHffv
         am1JQS4CuuD76TIuTZUI+4d8/PTCEf9X4kPvVn5s2DIYI6z9AJyf9XodyicNUJ2bECgN
         vfBPVtnjMBwmH/eRqKdoq9zfK/X+YBmeiYsELG2ae82kRPC+odSV200RFw7eGXRgDhRc
         Z7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=flYFZX4xtunESveWweX9oaYarEf6r3sR5/6diYLfUqI=;
        b=QOY2tTaZ0UPbQ2qdlwhvuBM0PRwEOnBxzcTDA1MuysLJVqqJ4jPVqBxBBn5peCTI+Q
         8ONaV+FW2MtCo7+WgldywKYGW4qrlAQq0ojpdbB48RI8RcWy8hOtqex8ApHBQe1/dkcP
         jXsdlmolIN3fo8/UvddxOAtlQrh4GNrW3ga4+7HL8+IennA0iiUIfHcpyfOz+uQbe8J8
         FoybH81D88tvNlhg6W1sF+y4yl28Zn4jjHkHRgZvqg5Bl1ssqDmqDczLpCnRhdv2A8sZ
         pc0NMMLzmddc7333I1I67z0lWzzXm7HpSJoJX9i2caqQCmZrAIl4Du0wGJG8nQ02lsH3
         4Qew==
X-Gm-Message-State: AN3rC/5Yx5ATs2ziFMepYEI3jk0499YlRPfwu60yEi2YWiJd+qCzg8kG
        VvHqziB8JIOBdt33
X-Received: by 10.223.166.66 with SMTP id k60mr30292123wrc.139.1493984987520;
        Fri, 05 May 2017 04:49:47 -0700 (PDT)
Received: from [192.168.2.104] (p2E56826D.dip0.t-ipconnect.de. [46.86.130.109])
        by smtp.googlemail.com with ESMTPSA id p107sm4786904wrb.64.2017.05.05.04.49.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 May 2017 04:49:46 -0700 (PDT)
Subject: git client debug with customer ssh client
To:     git@vger.kernel.org
References: <0629aefd-d6f9-ee6c-27f6-1244552e3550@yahoo.com>
From:   "Pierre J. Ludwick" <pierrelud@gmail.com>
Message-ID: <75e9acf2-006e-9844-2e91-ac48cde625c0@gmail.com>
Date:   Fri, 5 May 2017 13:49:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <0629aefd-d6f9-ee6c-27f6-1244552e3550@yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Hi,
>
> Git client has been ported to HPE NonStop. This OS is Posix called OSS.
>
> Currently this git client works with openSSH ssh client also ported to 
> OSS.
>
>  When we try to use our "native" ssh client, a custom written ssh 
> client, using GIT_SSH= to point to it we are running into some 
> problems. We are this custom ssh developers.
>
> The problem is there is establish connection to Gitlab, the server, 
> and some work is done between git client and git server, but then it 
> seems git client just sits waiting. We can't figure out what it 
> waiting for not knowing this client/server protocol and would need 
> some way of knowing to more productively debug our custom ssh client 
> code.
>
> We are not an actor in the communication between git client and git 
> server, we just transport data packets transparently with ssh. So 
> either one of the communication partners do not go on with the 
> protocol or some data is stuck in ssh (or the pipe server on the OS). 
> We can only know the details if we know what the git server 
> sent/received and what we sent/received. From our side the only thing 
> we can do is to dump the data from the git server when we receive it. 
> Beyond that we need the data dump from the git server and the git 
> client. Additional state info from the git client and server would 
> help to understand what went wrong, which data is missing, which state 
> it is in.
>
> How can we get more info from git client? Any helps suggestions welcomed?
>
>
> Here is the output of a clone cmd, with tracing turned on in git client:
> ------------------------------------------------------------------------------------- 
>
>
> root-pl@BWNS02-ZTC0:~$ cat ~/bin/plsh_sshgit
>
> #!/bin/sh
> run -name=/G/plsh3 /home/pl/bin/ssh -oIdentity=rsa2k -S \$plssh -S 
> \$plssh -Q -Z "$@"
>
>
>
> cmd & output:
> ------------------
>
> GIT_SSH=/home/pl/bin/plsh_sshgit GIT_TRACE=true GIT_TRACE_PACKET=true 
> GIT_TRACE_PACK_ACCESS=true GIT_TRACE_SETUP=true git clone 
> git@dev-ssh-debian.comforte.local:pl/test.git
>
> Cloning into 'test'...
> warning: templates not found /usr/local/share/git-core/templates
> 06:04:25.030966 trace: run_command: '/home/pl/bin/plsh_sshgit' 
> 'git@dev-ssh-debian.comforte.local' 'git-upload-pack '\''pl/test.git'
> \'''
> 06:05:10.517100 packet:        clone< 
> d789ced47cd9cca76409656507ea5bdc646c4051 HEAD\0multi_ack thin-pack 
> side-band side-band-64k ofs
> -delta shallow no-progress include-tag multi_ack_detailed 
> symref=HEAD:refs/heads/master agent=git/2.10.2
> 06:05:10.524625 packet:        clone< 
> 7bdce38446aae35c92dbab790257313c4d9d950f refs/heads/18-management-fix
> 06:05:10.524782 packet:        clone< 
> bafcadca5e47b0949ce3135312f587fbc80db237 refs/heads/2452-pw-reset-email
> 06:05:10.524937 packet:        clone< 
> a927a7c30759c4ad7461525ee55e1a7aed1d490c refs/heads/add-build-signals
> 06:05:10.525094 packet:        clone< 
> 717faa92a7ef00c5cfca7f56dbb0658751e421e5 refs/heads/add-call-to-theme-js
> 06:05:10.525271 packet:        clone< 
> 299ea53cf39c670399d3d09ff30be5efab2749c0 refs/heads/add-docsearch-url
> 06:05:10.525433 packet:        clone< 
> beed6029b7035ed9c47ed604bb0d19372a7c720b refs/heads/add-gold-projects
> 06:05:10.525627 packet:        clone< 
> ef5c7090095c4004f052d816b759ef441d3f68d0 
> refs/heads/add-page-suffix-support
> 06:05:10.525801 packet:        clone< 
> 0384faf59f796a8c6617239f0abe1604416c9acb refs/heads/add-payment-form
> 06:05:10.525997 packet:        clone< 
> 277e9c0701d14375e2a83ba4821545add35789f9 
> refs/heads/add-project-container-image
> 06:05:10.526150 packet:        clone< 
> 28d240bbef04b55fe4a6b856f146e5003f1d540e refs/heads/add-wipe-button-to-ui
> 06:05:10.526356 packet:        clone< 
> bf0363cd0a566f8077ceb159094e87019a9c8d7b refs/heads/admin-icon
> 06:05:10.526516 packet:        clone< 
> 5aa5151470bc8029b027d207fd71e81808361f40 refs/heads/api-v2-docs
> 06:05:10.526736 packet:        clone< 
> 399f924f8067595ad5d2296898ad0761e7a60a02 refs/heads/auth-cas-dev
> 06:05:10.526888 packet:        clone< 
> 249421d0b13c335a37b5ed695274070da8dd5e32 refs/heads/auto-import
> 06:05:10.527531 packet:        clone< 
> c922688c4d88dc831541d40e7251c74a11a783d1 refs/heads/backport-style
> 06:05:10.527680 packet:        clone< 
> fa501c59dd1a96009ad2f7ee1a577662699348d9 refs/heads/badge-v2
> 06:05:10.527897 packet:        clone< 
> 4b1453954179d21ded05479f3fe469851fd1b815 refs/heads/bitbucket-oauth2
> 06:05:10.528054 packet:        clone< 
> a1f4b96f2a521c3214cef9f4f54a8f15750fadc2 
> refs/heads/break-out-core-urls-views
> 06:05:10.528267 packet:        clone< 
> 9dfa0de18ec8c2a0f5a3e2dad0bb3aebf39b73b0 refs/heads/build-command-shebang
> 06:05:10.528421 packet:        clone< 
> e7a86d67695d0224629abdccf9cf4c732b7915c0 refs/heads/build-complete-signal
> 06:05:10.528638 packet:        clone< 
> a5be71f425379ac722c8f507355b070f46fc4d29 refs/heads/build-failure-email
> 06:05:10.528882 packet:        clone< 
> dd7db9e1f5524e14215ede8e58ecd21ebe3cd223 refs/heads/build-filtering
> 06:05:10.529066 packet:        clone< 
> 5ee3f2ba081531c98f3a37220f8c4bc8f24e2b7b refs/heads/build-indexes
> 06:05:10.529219 packet:        clone< 
> e4824a0f35a893f7ed1040a9684297752a657f97 refs/heads/build-pdf-ret-val
> 06:05:10.529399 packet:        clone< 
> 057d6faf5d3c4a2dd91b0fb8495e755ac824d32e refs/heads/build_stats
> 06:05:10.529552 packet:        clone< 
> 51b540e0a51732eb94fc8df7a9f89d9ca7ba15f1 refs/heads/builder-standards
> 06:05:10.529754 packet:        clone< 
> d907aef4ab007833d6ad76098b4671873ea0eec8 refs/heads/bump-sphinx-ext
> 06:05:10.529906 packet:        clone< 
> d78528903d5da7216b834790bcfbbbaadb3ae65d refs/heads/cdn-abstraction
> 06:05:10.530114 packet:        clone< 
> 9595beac70fe94d1137cc41d6a7270da33817b11 refs/heads/cleanup-oauth-app
> 06:05:10.530266 packet:        clone< 
> 77255c6655fa86321e95d8e19a59ca4a2a0f0f9b refs/heads/commenting
> 06:05:10.530527 packet:        clone< 
> 0100b127b63dd0d4f2a06e91a59e7ec57e26528e refs/heads/conda-env-create
> 06:05:10.530679 packet:        clone< 
> 5ab86d075bc89121f75cf02a369e891f4e99f637 refs/heads/conda-support
> 06:05:10.530893 packet:        clone< 
> d325a501664cc6e673b6570a4e581f7905dc66d8 
> refs/heads/delete-broken-search-code
> 06:05:10.531052 packet:        clone< 
> ea37e3e3745b8ebc343569ec1d77e7fdc7b7ef91 refs/heads/display-yml
> 06:05:10.531348 packet:        clone< 
> 869e1c79af58c5e662143f561947f08f055504c8 refs/heads/doc-cleanup
> 06:05:10.531506 packet:        clone< 
> 722a269033b14eb838aad801210033add39b0ccb refs/heads/doc-docsearch
> 06:05:10.531710 packet:        clone< 
> a67a4a8de3d706e04a62220ee7099af3891bc8a9 refs/heads/docker-api-change
> 06:05:10.531870 packet:        clone< 
> 98b776a53460da099d94d127ada2bed1f1f848d2 refs/heads/docker-mkdocs-mount
> 06:05:10.532061 packet:        clone< 
> bf73f4008bdd2b3bf7312b2144961b7e12f56410 
> refs/heads/dont-move-index-to-readme
> 06:05:10.532220 packet:        clone< 
> f2b48646455da792912b5c7340730acd35472315 refs/heads/dont-session-footer
> 06:05:10.533500 packet:        clone< 
> 6f9ba09587e22a752cc5204642f27c3ff1a3cdd8 
> refs/heads/dont-set-build-state-on-exit
> 06:05:10.533652 packet:        clone< 
> 9e528f2e8b5599376df53ab082b2b61f74a9cbd7 refs/heads/drop-bzr-requirement
> 06:05:10.533932 packet:        clone< 
> 32494143cc7d077e7f960fcfbe524bf2bb4baa60 
> refs/heads/fix-18-template-context
> 06:05:10.534086 packet:        clone< 
> 529acff30cce0ec9d29988d2d378ae45834a1a3c 
> refs/heads/fix-apirestrictedpermission
> 06:05:10.534309 packet:        clone< 
> 7e45481d6b19ae23dc28c9d52b823ac3b34f4fa4 refs/heads/fix-build-output
> 06:05:10.534471 packet:        clone< 
> af81a01578781a6d81096b5e8d2b225dca79cf98 refs/heads/fix-conda-env
> 06:05:10.534694 packet:        clone< 
> 50afa534de4122bdd31d601a4dc9ddac94a734fd 
> refs/heads/fix-config-class-setting
> 06:05:10.534847 packet:        clone< 
> a8c2d8e9a8520243eb9b52cd315e58730e235b4b 
> refs/heads/fix-gulpfile-manage-py
> 06:05:10.535060 packet:        clone< 
> 7ee93a63da64f1adcc4a0e3263399536984ce611 
> refs/heads/fix-language-links-on-cname-projects
> 06:05:10.535222 packet:        clone< 
> 7c723b0a1e125891542f40dc22851e145157ead3 refs/heads/fix-linting
> 06:05:10.535417 packet:        clone< 
> b81ad9e5db1707fe9cb15fa21396883267b370be refs/heads/fix-projectimport-js
> 06:05:10.535570 packet:        clone< 
> 1d422dcf8446a4773d3a28a99409a9e71597c12b 
> refs/heads/fix-reindex-elasticsearch
> 06:05:10.535782 packet:        clone< 
> cf23d9af0618410d2d9d67f0c13150d368737e31 refs/heads/fix-yaml-order
> 06:05:10.535939 packet:        clone< 
> 2eb8d893347fa195904511f8da38e8719e6ffb39 
> refs/heads/front-end-standardization
> 06:05:10.536142 packet:        clone< 
> 1329d221f10700eb144c19ec1f3df4dc457b3c03 refs/heads/github_import
> 06:05:10.536302 packet:        clone< 
> b4771ca285ab2d6201905a65e7acdfa798852d1c refs/heads/gold
> 06:05:10.536522 packet:        clone< 
> 552d036d826ac84e689c47803dee75356338d2ab refs/heads/hack-pdf-success
> 06:05:10.536678 packet:        clone< 
> 3c931c4faf5c59b37de67d52b3280e3a7ef2b619 
> refs/heads/hide-edit-github-link-for-invalid-pages
> 06:05:10.536898 packet:        clone< 
> a28ff54d02b235d3d6298a0f191fcd7e049e263f 
> refs/heads/highlight-searchterm-in-mkdocs
> 06:05:10.537050 packet:        clone< 
> a42303bbe8eb81395038f5f16af4eeff5c3504f2 refs/heads/host-badges
> 06:05:10.537412 packet:        clone< 
> a2b3a824c4ac5000f0f68d9627c9394da9cc1a2e refs/heads/hotfix-confpy-path
> 06:05:10.537633 packet:        clone< 
> 1ac50586de88ace7f38e7ac0378a9e8114617628 
> refs/heads/hotfix-docker-build-bug
> 06:05:10.537811 packet:        clone< 
> 2c57e9414bcec5c513a706604e1be7a59a332909 refs/heads/hotfix-frontpage-list
> 06:05:10.538048 packet:        clone< 
> fab3799afd6a476a3a93fd788c95b3ed81736857 refs/heads/hotfix-import
> 06:05:10.538202 packet:        clone< 
> c49f20a002d24bdb2537c75d7c58446f9e65ba94 refs/heads/hotfix-remote-sync
> 06:05:10.538418 packet:        clone< 
> a4e6d4795516e6a70e118e0b2556ebf99c12730e 
> refs/heads/hotfix-virtualenv-no-downlaod
> 06:05:10.538574 packet:        clone< 
> a4e6d4795516e6a70e118e0b2556ebf99c12730e 
> refs/heads/hotfix-virtualenv-no-download
> 06:05:10.538779 packet:        clone< 
> 20ce8a01eba16d9cb00112857e8327677cb70471 refs/heads/hotifx-frontpage-list
> 06:05:10.538933 packet:        clone< 
> 9f59c2e7fd9fbfefd4ecf48f488e0853e62ac5e0 refs/heads/hotifx-search-linking
> 06:05:10.539144 packet:        clone< 
> 2ce07cf65edade653cb333d98cc21ab231a564d4 
> refs/heads/import-github-language
> 06:05:10.539308 packet:        clone< 
> e3f4c6230130eee750eed4b750d015f847eb2af6 refs/heads/import-improve-ux
> 06:05:10.539515 packet:        clone< 
> f2178708198f68b1b367efd802f52e9cabfd57ea refs/heads/import-updates
> 06:05:10.539667 packet:        clone< 
> 4d0aaf4030ef7d85bb9bbf1a2c7a1831560cab40 refs/heads/improved_search
> 06:05:10.539879 packet:        clone< 
> e65c272342c64a28942b21f7b3851e190795900e refs/heads/js-theme-bundle
> 06:05:10.540035 packet:        clone< 
> a49a85eb6e1b6f453083bbf6e06fb20d295b8622 
> refs/heads/less-strict-oauth-patterns
> 06:05:10.540247 packet:        clone< 
> 3fcf523598555c6c23e4cee99ff49aa2dedddfa7 refs/heads/lint-project
> 06:05:10.540398 packet:        clone< 
> 49624cb9b31f08d0c75ee6f6bf2e2565015c83c4 refs/heads/lint-raise-profile
> 06:05:10.541513 packet:        clone< 
> e7848bf2f3b862bf95ce6944264fb1583f132e5f refs/heads/maintenance-mode
> 06:05:10.541669 packet:        clone< 
> d789ced47cd9cca76409656507ea5bdc646c4051 refs/heads/master
> 06:05:10.541949 packet:        clone< 
> e422ffb2ce1173ad94e908aeb206122690043215 refs/heads/move-doctrees
> 06:05:10.542108 packet:        clone< 
> 01e3709543e7b00aafe7af7cd640effe26e38c4e 
> refs/heads/no-sphinx-build-subprocess
> 06:05:10.542299 packet:        clone< 
> c39e5369a7d736910e48f54bfa10f14e5c9b0b5f refs/heads/no-www
> 06:05:10.542449 packet:        clone< 
> 3590d4aa1752342927f4915e951f6a3321ac24f6 refs/heads/ops-docs
> 06:05:10.542672 packet:        clone< 
> e21c857cef2a0e5a512aa7baba8ccb1f509cf1f1 refs/heads/privacy-backends
> 06:05:10.542825 packet:        clone< 
> 68eba9cb5fd319020972b30d74985c2dd9cb1e38 refs/heads/privacy-filtering
> 06:05:10.543037 packet:        clone< 
> a4c1333f480e30511f613bc870624e722b9181f0 
> refs/heads/private-repo-resolving
> 06:05:10.543203 packet:        clone< 
> e6cfd9604ec5bec9a9c9bc2a322b8741a6bc1122 
> refs/heads/programming-language-support
> 06:05:10.543432 packet:        clone< 
> 28bcd521dbf5fb0e08036159a2307b9ca583d3df 
> refs/heads/project-container-settings
> 06:05:10.543586 packet:        clone< 
> b8aa29a0d4b00b7a9bb39de75b218000e3fb95fa 
> refs/heads/project-migration-sync
> 06:05:10.543774 packet:        clone< 
> b13d24aa1d7b87c6d8371d767bfc2313f82988d3 
> refs/heads/public-private-symlinks
> 06:05:10.543951 packet:        clone< 
> a37d34a770b7fe5dc301e7386f09877b8eafb34e refs/heads/python3-port
> 06:05:10.544163 packet:        clone< 
> 10231547896ec495ce64d18737339b62b02c6df8 refs/heads/rate-limit-builds
> 06:05:10.544321 packet:        clone< 
> 18ce6ce0f8da0f9369235b081901c69738266e24 refs/heads/redirect-keep-version
> 06:05:10.545439 packet:        clone< 
> 01565fb6eea8183fdb2d895dcf566786f885cfea refs/heads/refactor-builder
> 06:05:10.545605 packet:        clone< 
> 89f3aef86db05d84839e31ff219d283791c58acc refs/heads/refactor-redirect
> 06:05:10.545807 packet:        clone< 
> 8238bfc9f34c2699275a4befa850f2c621367456 refs/heads/rel
> 06:05:10.545956 packet:        clone< 
> 28848a0405b966ef93a5c5b5477ff88c4675fef8 refs/heads/relcorp
> 06:05:10.546179 packet:        clone< 
> f60e4cf16ffc8bea83db73b1bbb1219544897830 
> refs/heads/remote-oauth-constants
> 06:05:10.546341 packet:        clone< 
> d67360a1d240af0835b531ce51570be15d037bff 
> refs/heads/remove-manager-public-kwargs
> 06:05:10.546544 packet:        clone< 
> 38b762008930f9af7290af5595a19ef6d428db87 
> refs/heads/remove-user-project-permissions
> 06:05:10.546701 packet:        clone< 
> 0704513323d95710a7a777eb410b7521a68dbeee refs/heads/rename-docker-image
> 06:05:10.546919 packet:        clone< 
> 67e105846f25fc6416b0bec181ce92fa7b561766 
> refs/heads/respect-domain-in-middleware
> 06:05:10.547073 packet:        clone< 
> 905486a40fa386d444505def314ade5957ca2c8e 
> refs/heads/revert-1568-haystack_upgrade
> 06:05:10.547282 packet:        clone< 
> 602f08c858e831349eb665d3c56e3b035b0bcb89 refs/heads/revert-conf-changes
> 06:05:10.547434 packet:        clone< 
> 2227afeed39ed9e256e9618ec9fcd97b69819088 refs/heads/rtd-build-backend
> 06:05:10.547651 packet:        clone< 
> f0f3f4b2824c0c2b28bcd79dd647c66615c07a4b refs/heads/rtd2


