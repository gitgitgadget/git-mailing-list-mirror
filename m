Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17FC1FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 00:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbdBIACN (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 19:02:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:53300 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752166AbdBIACM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 19:02:12 -0500
Received: from [192.168.178.43] ([88.71.190.186]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mdren-1cnVCE3quL-00PcjU; Thu, 09
 Feb 2017 01:02:00 +0100
Subject: Re: Automatically Add .gitignore Files
To:     Junio C Hamano <gitster@pobox.com>, Thangalin <thangalin@gmail.com>
References: <CAANrE7rmUZcJkw+thMczv3D=7sqcUHBsorzvEZgYg=6AEfrU=w@mail.gmail.com>
 <xmqqmvdwtfq8.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <64116970-0907-2e95-e49d-068e1a25ffa6@gmx.net>
Date:   Thu, 9 Feb 2017 01:01:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvdwtfq8.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:VJUCzUfRCxZqNM4fMNiRkKYvEuNYmKnlFOa7ruhGQYnkGwJAaSP
 sRV295Ks9qsfiYUpyIUcm5ZRgIYYTZ/W9VRjn1kr5fKYELpSlydv33bIqF86x2vfRbVKjVN
 5fPNjBDqSl78+/ofoTEiQZqe1EHGsLCqUPSOwT7zGgGWppr3LtLghm0FAMAY6whPQVdKUfB
 035Ps30/ZRI8zaLkO6/Uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0DgJRntErdc=:nU7ytxgcXHlk2Nn5Nz2tsm
 7retDVlJD+VjHbbo9G6Ro7cApOfmAB7mSSh7cKcbWx8rAFLXFlZWw1r0RwlRFSkrvpLE8Kscy
 J2cJJrDwQu7Yv8sKFmEl/YToSP73DNxUTqo8aduFvr4iiAlsHmvW3SbWHzWfLv/uMI5mhtnFk
 VRufqGLc/dl9MzZktllMRdmoMA68DxCUPQ9YJ/nwFVABI2BMHQpWnpFXEFU3MekIcGctzxZNL
 /zOBQnZaOiqO8cic0Q812j2YICf9JQw7FqQmIw9bMVYuQJDcXTgElws0TN/zmJhJGSO+iigwL
 lu8IR6jKe5iaJDBPq8HvW7mU6q6wcX/EzaETa5ovYkzCc6kTymcco3THD5bsVqp09Eld3V+Jh
 dUYM30ios+pl69LMfJ+CxeDJtQYCsTJmhrMceGTgEethqMbiR4tkH4o0pkZ4Qdbijsn/2mPwi
 /aEZ02JZiR+VpAgBhsm97Qk+W9JTc+Mqsj41bE6H7hI04D++eZyI5Pnm6iAKuRpHlJgng9YJX
 jnWycmm052pNhfljyJIPi4dhB8GY1VQiDTpGwOeR8hMVYN0h6CQtWQ+xouUkeu1xepWGXvk4t
 vK99UMTBxfqiaKZeh4vJapeTWNn4yxYpQYhN70DD+7JDJNr90WkChPaqJOYgiXgoZCuhuQvR1
 tGYLVn5tq66TvkK07ZW7LUX3D4iEJjHEHT9dfJsYvTUmfl242JkTwQ6E3dU8xpPNu0nuWT4Mc
 XxyTuhPwI6bMKWseN1FmApQ/98CrfEtcT/1AZRqSAZqO1lwVWyeNeAKKzJ/rsJ6aBGWgPsfzU
 LMOyiMn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I am tempted to say that there should be a way to somehow forbid use
> of the "-m" option to "git commit" by default, until the user gains
> more familiarity with use of Git.

Since I am using git, I am tempted to say that "git commit -m" should be
abolished. If I tell somebody how to use git, I never mention "git
commit -m". Unluckily they find it out themselves... ;D

The typical observations I have when people use "git commit -m":

 * The commit messages are either too long (in one line!) or
   too meaningless.

 * People don't check what they added and commit wrong stuff.

 * People make fast temporary commits with "asdafsd" commit messages.
   Then they get distracted for some time and work on another branch.
   When they turn back to the old branch they don't know what "asdafsd"
   was...

Thanks to git rebase -i and/or git commit --amend, it is all not too bad
after all ;D

Best
  Stephan
