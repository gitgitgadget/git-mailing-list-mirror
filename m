Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40EA6207D6
	for <e@80x24.org>; Wed,  3 May 2017 09:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbdECJVm (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 05:21:42 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34233 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbdECJVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 05:21:40 -0400
Received: by mail-vk0-f44.google.com with SMTP id y190so6239424vkc.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WM/P+emVYQO2h1lKWWvZ7+9yHWxwvtvTn0/v+je2IFU=;
        b=pY4Wfjlu4wcM+LWC5K573bbaRyiFMscUKHB0f7jRymNasMpLAL1RHZneutB+coxpu8
         P5iJ17bzyr+TMbbAM8GQt4VysdvyjNBGkH1LOMpBIH4BYtP5KHAFSBOxghiDi4xk6hoB
         pK3QiXi6iCrqZhLVu7CKOJxmBK5CdPWxta24bpdnTOn73rhvEywZNag200XvPbCEf18/
         l64wymRndGiEWpl+u0nfoQzidtAf16MdPgkh2hUuwaL955dkMh/H8VxLeJFwYEJ7cVgl
         92Qe4GkNydrHJLdhdVcGsSS00C1wCS9wz5cYt1+UTxy3xJXnBpeJ91Ji4HiQ7MWQU440
         4okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WM/P+emVYQO2h1lKWWvZ7+9yHWxwvtvTn0/v+je2IFU=;
        b=FAEjw6dyVnrjgPZnBAZnY2qOrzBHLnfCp1vK6MwMLvFQ/O5DrPFZGpoFSFcnTK7PJm
         2fTrXjdw4tm0CUflnz645r+UUsYU40EWi64zq3QTpIDaQJD3qBI6QkfO04Q47KccQ3pf
         vxgx104NKiRt2+H+ojn53fU2cCkp667J/79J2icpHCmdkWx4JFS2cBQKUjn1pcDD48i9
         mEqYWAcFeBZONdt6EsAMcgvTyQP5MEfeS88NuhYE0gwteZnsxE/XtI3Lxd2cZe6HFK20
         65Gl4s0rUcp3FSp/AeJifpTqiwkf3+hdRAIQmjpQaCwjQf07VeIEcRyob5hEYPxiBVMh
         I4RA==
X-Gm-Message-State: AN3rC/7w02lhrqYEMOqid2jNtv/o82YydhAqbvgiC1HRf5GaJtqFjGL4
        xFOoUSApYDNZ6lpjG+8+4IZtDHGF57jC
X-Received: by 10.31.171.206 with SMTP id u197mr14477532vke.22.1493803299431;
 Wed, 03 May 2017 02:21:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.9.133 with HTTP; Wed, 3 May 2017 02:21:39 -0700 (PDT)
From:   Rashmi Pai <rashmipai36@gmail.com>
Date:   Wed, 3 May 2017 14:51:39 +0530
Message-ID: <CAOqCAXSOZCG8mijV+yATtmC1PFGYiOSqtraSdbhbP2rRHBO_Qg@mail.gmail.com>
Subject: Bug report: Git Stash; spelling mistake of stash followed by a yes
 prints character 'y' infinite times.
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I am a corporate user of git. I noticed that when you switch between
the branches and do a git stash ( I miss spelled it as git stahs). Git
asked if i meant git stash. and i entered yes. and git printed the
character y infinite times.

Below are the steps to reproduce.
1. create a local branch and make some code changes in the same branch.
2. now checkout another branch. git says Your local changes to the
following files would be overwritten by checkout.
3. Now do git stahs ( spelling mistake )
4. Now git says git: 'stahs' is not a git command. See 'git --help'.

Did you mean this?

stash

5. Now types yes. and you will see character 'y' getting printed
infinite times!.

Though this is not a major bug, I thought notifying this would be a
good idea. The above mentioned issue is reproducible in Mac Yosemite
in git version 2.4.5

Thank you all for making our lives easier and better :)..

-- 
REGARDS
Rashmi Pai :)
