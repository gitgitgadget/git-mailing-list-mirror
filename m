Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAF2C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 19:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDMTDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 15:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDMTDH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 15:03:07 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE511E59
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1681412583; i=tboegi@web.de;
        bh=4vbzPoBceNneo/q6SRDHofWHGvkj+Zi9DcbzRxMaz10=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=U9xgzwRmt2pq6l6PN+97MgXg0/efaY4FoyuFdb+KwqdiA9MQtdfCTL9ssKazailwk
         7nAbP/5I53HcTSddGtlCyGQjH1o/INll5Cg5+nKQ2X0+mMx3Xw8HTxLlRQj1fG0WlR
         fHHvmaxS5LQuVY+oBIN559qHDHTjBX51aC8t053IG6YhqdLsxsvo+pDctgEpbiQIfd
         CAigBLmATCyp916jSPRuqgMiQhkw4NwY9dU7oyivZZWU9D/IICnvj8C1wGViTtH5Uj
         Ds66YrvjAuiyJ6n/waCrQqNJ1UNrgIyTtAg8jz34qNu1jnnIIjmFLr5TbnXesAFZgE
         x7BmEjAwYULyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOhn-1qB7MO21Rv-00oZ5s; Thu, 13
 Apr 2023 21:03:03 +0200
Date:   Thu, 13 Apr 2023 21:03:02 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ilya Kamenshchikov <ikamenshchikov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git branch capitalisation bug?
Message-ID: <20230413190302.drmmdrkv7vfps3qg@tb-raspi4>
References: <CAAp-DqK=CPxpH0ZhA=k8GRFvSz3odoOLhOgAqfYSBpz28JK+hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAp-DqK=CPxpH0ZhA=k8GRFvSz3odoOLhOgAqfYSBpz28JK+hg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:hd9tUyV7CmfNN9lOlgbA+Zjs7Cp1ExQQwSwm487LCBptc88gYBK
 epfkViXNKaZl5qazydOctMs6GC0gHrRJ4W3ivzosCUvlWJOQPdjDZEanmPsaBPXWp3+/mp1
 Ro8R9BKywFemufrhamGeuqlyLig0TO+msCuL0DXoIPdj+SFaTqPo5TvoVFJlIJzmg8eQM4f
 1DIzgDokJMxUgH1KZ5aCw==
UI-OutboundReport: notjunk:1;M01:P0:KQYgnJa1GHs=;b1IUILSsnPpGUvLVGMk7K3yPMyq
 OGJKof03aI6AHiN+bCQwtEFS3I6imAyTy9tPMIs2bze6x+d8Thd0QnBvJtMaiFCMllVgRqJ54
 q0lHi1MZ9HaPFJe2KOJSHvzMl3reQ7d3+nmZThfFbrcUjJVaxWIV4QtqjMUIwspxkRMoEx7aQ
 UPhJdN1DhMcT8u1tEPHrYHXs0iRn3i+FzQ7Cn4bXxqZNfRX6G+bvN5s4CkSWx36uz1hhFNzP7
 c32u3NKnIp2wKfHjnU3mnl3dqyb469tN9jqEUIiFjaU1hO91rpjhgUba365lxP31hlLHevKsP
 uf9lMFfc6c9So0yWmS67zavoUELoOTVoz+DT09YemZtOlC3hqUZsU1gbtslX5qWrMOf3jFQJj
 DPmcu4W38M0BeTRipXT2bFwEU1/SSepfnLeAy8XRNTPRg1Tr/qNTS+zvkAeYdL0noPo6v2BFr
 Q54p3p4o2x5Cjjo+zut364k1t6KKuGGhA/mK1VlW09J9/QHeB8GR4s8HJsEp5gEELp8kyWuxB
 CmOPVWJU3rvYONKadNsfOusH/uThc14SklWT6aSl8uDH3D9X4bWevxFcs09+6/ZxVRrIEIdqb
 AY3Bp5cQnuH6XndRLZSmv63xLvWQR+0tMgI5yO7lQGFlMH9BwV5iV/uGZ07/gTbjQkdp5VnGA
 /L5wxdKnNRqxhNRKHHl2TRsjVRFy5HiXrBO6rC0tir23UlfSXdo0RCEjanmDgef+9U/P9t3XL
 LQYgwDiySYyzaCqktpFJEHSKLKKYJjFIcKNn4zwk5kTStXwsR8cb1pWdpErLSF3Av8OihSIrx
 YC2OS0p+XoeKWLtMvpg5g3i6fM+Du0q+FzKWg7+8TwyMZuY2MaEpvBsclEnMvUyN+mFNKvgYH
 qRTkE8AzTTWo0sZ3IOnXHGTnvOfux7Bcjs3fqsi/POh3Pc7Rm+JEcOusU8GzQ/Zim3t7Cmcgz
 xDwOOw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2023 at 12:35:36PM +0200, Ilya Kamenshchikov wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> Created a branch "feature/macos_tests", pushed to remote as
> "origin/feature/macos_tests".
>
> What did you expect to happen? (Expected behavior)
> remote branch "feature/macos_tests" to be created.
>
> What happened instead? (Actual behavior)
> remote branch name is "Feature/macos_tests" (capitalised). This
> doesn't play nicely with not case sensitive macos FS.
>
>
>
> [System Info]
> git version:
> git version 2.40.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Mon Dec 19 20:44:01
> PST 2022; root:xnu-8020.240.18~2/RELEASE_X86_64 x86_64
> compiler info: clang: 14.0.0 (clang-1400.0.29.202)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /usr/local/bin/fish
>
>
> [Enabled Hooks]
> pre-push
> (remark: reproduced also when uninstalling this hook)
>
> Raw output:
>
> ~ $ cd bosch/rlcore                                       (base) 12:11:4=
2
> ~/b/rlcore (feature/macos_tests|=E2=9C=9A2) $ git push            (base)=
 12:11:49
> fatal: The current branch feature/macos_tests has no upstream branch.
> To push the current branch and set the remote as upstream, use
>
>     git push --set-upstream origin feature/macos_tests
>
> To have this happen automatically for branches without a tracking
> upstream, see 'push.autoSetupRemote' in 'git help config'.
>
> ~/b/rlcore (feature/macos_tests|=E2=9C=9A2) [128] $ git push --set-upstr=
eam
> origin feature/macos_tests
> Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
> Thank you for filling out a Git bug report!
> remote:
> remote: Create a pull request for 'feature/macos_tests' on GitHub by vis=
iting:
> remote:      https://github.boschdevcloud.com/CR/rlcore/pull/new/feature=
/macos_tests
> remote:
> To https://github.boschdevcloud.com/CR/rlcore.git
>  * [new branch]        feature/macos_tests -> feature/macos_tests
> branch 'feature/macos_tests' set up to track 'origin/feature/macos_tests=
'.
> ~/b/rlcore (feature/macos_tests|=E2=9C=9A2) $ gl                  (base)=
 12:16:10
> c001bc75 2023-04-13 | commit message (#514) (HEAD ->
> feature/macos_tests, origin/main, origin/git_problems, origin/HEAD,
> origin/Feature/macos_tests) [Rich..]
>
> Best Regards,
> --
> Ilya Kamen

I am not sure, where this Capitalizations comes from.
I don't have an account on boschdevcloud.com to test.
Is it possible to reproduce it with a public repo ?
Otherwise, should we suspect boschdevcloud.com for it ?

Any other thoughts from anybody ?
