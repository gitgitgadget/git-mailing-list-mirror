Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3071BC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 14:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbiCJOys (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245417AbiCJOjj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 09:39:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56CB4666D
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646922750;
        bh=XiqCrQQI/vDSpW7mS3ZfBTTia/ep9iyoSDnx4N5CivA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EjaqW63s89XzMwAFOhaWeQTBHmYRJUioUCB5lc8rMYQXWfGxld7aUmRb6sitMPTeE
         M+Eg9LTUZQnIlWCRi6cJh02e0tUNBy2/ArJCx99kFw2+uRBcUjov7WW9P5PAmtWhef
         MJ/ULjJRwtFOvJCkaBppddWG++HfuH9nFMpLnqRs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCOK-1npVWM26YG-00NAqt; Thu, 10
 Mar 2022 15:32:30 +0100
Date:   Thu, 10 Mar 2022 15:32:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
In-Reply-To: <220309.86bkyfmctk.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203101445360.357@tvgsbejvaqbjf.bet>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com> <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com> <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
 <aa6276f9-8d10-22f9-bfc0-2aa718d002e1@jeffhostetler.com> <220309.86bkyfmctk.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-347439598-1646922750=:357"
X-Provags-ID: V03:K1:FAReks+9vDo6F6YqTgeN/Y2MgyywXVRIJrZk+eYHxk9aKHuz12A
 2XCf4J8yU2rHJygIlt/iWiwFcfkNmfhICZ+Lgwg29qg9Ctap4Efpay3sILVnjrfbVIrsDTx
 GmgXCKcx89efEjnddXjcADdwx8wVUTihGpyHkyScxxKGmzaah3R0rnhyDoURQJyLq4EsffB
 J4fEJttxCowgv+zxpeY8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0kDgSjhgg/g=:QWph/m2/FpAF44OOjzsTdD
 4lRrz0zo14ljiH1uVkkI8DoROMrxIVBTjlcY5QDNccvK4XBLU8vwXw1zK1Cap8w2k9l33IEPy
 S2n3lR3E8GGTeeAudWbfgjkEy6pzhk0pk1vi65pw1+PKEHQhXbywkd66NWcVyElyIcqC5xspG
 34Imha79rvvOvrQfJTLUZoTKXGN3xu7pwRu8EShyczcnKgASmh4UN7aJltrdAVthT+Rx7xpRO
 9WmJnYNfHd7x4aym56VcgHBUXEVfyLugxLW7sngVirhbP7N5XH/ObYSSXenyuj0cOQTzMnnHp
 jv20BwhetHhKVSw7msQS1mplumy2AfXjU4N/T/NO0Psw9LTtkgy0ycZIHIy2sScSHrEjsko0N
 Qle3bgMrRedSFvmdpY98pBm6cwQZ5gOF9ayGRsr6IBbiYdPC+xyh9tD33/4ptjVqMi7WN0yOy
 MV25Un3v5lAxGZGYQuXucXndi2tIZ4OJgMCuvyDcR8YBIDUS+j/lKTOiG0Sr8rIj6dnS0SNXQ
 NHxiacX5v0eqIScSe/K8jVc9R6H1CvxVO12UjwbCoH1J/afET8RjVLE9wjAji01dMsUK6Jdmq
 8MGNMcDhkXoXu8Zt192VBMUJ6Mlv+BdX7sV53cxqDkt2KRAlnz2n61Gd68zcXgRH9Q4LyptnM
 3+v0GhEdrPnTXEhh1JGRJ64uaomRk3BtqcJdr1N5O3pEy+nZ/SrWP0qHY3bERAZkGpPSpQqDp
 UQ05YvPWde28z+jdTaq8HC2D5qIOvDWNJm+RBxlOLCdhy8fElt3UZ1sH39oSZC3vi41lCjbtj
 4516VdkBqPpSMIqm9CpLIqDLyT2iKpOJXdS3GtL3AnaNwTSlN95jOvALcK2fD1yYLuP//Scjz
 6K3tpWiW/DUKo03JznekDjnzZH1HsKbCyjeuYb598IW76giSZHaPX8vaifxhMfGUl8LwBYTW6
 RXR8Go/XNQwBo3NrNHdgBYjhg4xFKCFuYzDmokYJOWYeqwW69lXmViCmNRGLhzcPZVQN9ajCU
 Dl7PCxPgc4g7vwo057cxkM/qvZD+aG77QGNc3T2hHT9otb0TTo4KspEWa0ex+XcFXxYkSo3Jg
 mkIt8z2An7WGMg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-347439598-1646922750=:357
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 9 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Mar 08 2022, Jeff Hostetler wrote:
>
> > On 3/7/22 5:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
> >>
> >>> From: Jeff Hostetler <jeffhost@microsoft.com>
> >>> [...]
> > [...]
> >>
> >>> +#else
> >>> +/*
> >>> + * Let Apple's headers declare `isalnum()` first, before
> >>> + * Git's headers override it via a constant
> >>> + */
> >>
> >>
> >>> +#include <string.h>
> >>> +#include <CoreFoundation/CoreFoundation.h>
> >>> +#include <CoreServices/CoreServices.h>
> >>> +#endif
> >>
> >> In cache.h which you'rejust about to include we don't include
> >> string.h, but we do in git-compat-util.h, but that one includes
> >> string.h before doing those overrides.
> >>
> >> This either isn't needed, or really should be some addition to
> >> git-compat-util.h instead. I.e. if we've missed some edge case with
> >> string.h and ctype.h on OSX we should handle that in git-compat-util.=
h
> >> rather than <some other file/header> needing a portability workaround=
.
> >
> > [...]
> >
> > While it may not (now at least) be necessary, it's not doing
> > any harm, so I'd rather leave it and not interrupt things.
> > We can always revisit it later if we want.
>
> In terms of figuring out some mysterious portability issue, I think the
> right time is now rather than later.

I do not see that.

In FSMonitor, this was clearly a problem that needed to be solved (and if
you try to compile on an older macOS, you will run into those problems
again).

If you are talking about the mysterious portability issue with an eye on
`git-compat-util.h`, well... you can successfully compile Git's source
code without this hack in `git-compat-util.h`. That's why the hack is not
needed. Problem solved. Actually, there was not even a problem.

> I.e. now this doesn't have anyone relying on it, so we can easily
> (re)discover whatever issue this was trying to solve.
>
> Whereas anyone who'd need to figure out why we include string.h on OSX
> early in this case later would be left with this otherwise dead-end
> thread, and a change at that point would possibly break existing code...

Anyone who would need to figure out why we `#include` this header early
would read the comment about `isalnum()`, I would hope, and understand
that there are circumstances when Git's `isalnum()` macro interferes with
Apple's, and that this `#include` order addresses that problem.

They might even get to the point where they find
https://github.com/dscho/git/commit/0f89c726a1912dce2bdab14aff8ebfec855034=
0d,
maybe even the "original original" commit at
https://github.com/kewillford/git/commit/d11ee4698c63347f40a8993ab86ee4e97=
f695d9b,
which was a still-experimental version of the macOS backend, and where the
`#include` order clearly mattered, else why would Kevin have bothered.

Further, I strongly suspect that it had something to do with
`CoreFoundation.h` or with `CoreServices.h` being `#include`d, and if you
care to check the code above the quoted lines, you will see that you
cannot even `#include` those headers using GCC, it only works with clang:
https://github.com/jeffhostetler/git/commit/cdef9730b3f93a6f0f98d68ffb81bc=
b89d6e698e#diff-4e865160016fe490b80ad11273a10daca8bc412a75f2da4c6b08fb9e5e=
3b5e18R3

At this stage, anybody investigating this issue who is a little bit like
me would then be a bit bored with the investigation because there is
actually no breakage here, just a curious `#include` order, and nothing
else. So they might then drop it and move along.

Even you might find it a more satisfying use of your time to implement,
say, a Linux backend for FSMonitor on top of Jeff's work, instead of
worrying about non-issues ;-)

Really, there are so many more interesting issues to discuss than this
`#include` non-issue. And on this note, I will steer my attention to
precisely such more interesting issues.

Ciao,
Johannes

--8323328-347439598-1646922750=:357--
