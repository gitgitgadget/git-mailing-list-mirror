Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDD61F462
	for <e@80x24.org>; Mon,  3 Jun 2019 13:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfFCNtw (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 09:49:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:49101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfFCNtw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 09:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559569777;
        bh=Js3IiojjxrF2vNnfZ/itno7TqTlIPgQ+ponw6n/f7A8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WNpTjqS6YNpPpQ3SoFJgoJfzkoIC35/8eOQFJ5p+r6L3v9Sjlx2anzfxsPZccCjmZ
         uZ2jYzQCBcqeYwKGrxaQhbRVKDgVwatYnOOFnlnS8nhAe6uR+b1xShpdITufg4B2DE
         eA/sxTD1AjoKd8v09fRvcwaHkOntgR2T6rRxPO1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnDof-1gvBGe2cw9-00hQHt; Mon, 03
 Jun 2019 15:49:37 +0200
Date:   Mon, 3 Jun 2019 15:49:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: RE: [ANNOUNCE] Git v2.22.0-rc2
In-Reply-To: <005f01d5194f$5cb08240$161186c0$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.1906031544000.48@tvgsbejvaqbjf.bet>
References: <xmqqpnnzws9q.fsf@gitster-ct.c.googlers.com> <005f01d5194f$5cb08240$161186c0$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Pa3GpApIncHlt867u1btWSPFLE7/L+//MG00c1qJma5vXJGyUt6
 RNmq++tGCOsFGFlC7f1ryyUk7wu1iJm0oPcJwIR5PQnKtvVzh5pD4KtIl91Idc+H1Pmgu+E
 ALQeL5t116Vw4yRf/1hzitLfPN1bJmv2FTRuc4i8i1VB67c2nBZxBdivosicc0nuHKs3rXS
 y58c8vV54EtkFBCx8dURQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0NQ7DqOlZjo=:9uzk9iTeumbjK6Ne/RbmEd
 qO+w1kreQkC1KXhQeNvZNgIgMjQ/ZoDIqpybksN3eI4dKG2rUnz+qVNYReRdROAKFDSp8hm27
 Ztu8dW0Q2vF+YJQjxWoCwWAS5NkYkvOlItXRHUxib81FwF37gYBMjc5M0q5udxgBGKcgcpOZn
 5oRonerYSASKHnHb4WEm+ax0ORYvQQxTXKfuF4TZXvOHxUAKkvJs7MeoBAN0/A8INoGDURwa8
 J4629tXR6YL4pAlW4nx+D8f4XoZ1dwXU9bgREftrARrMH1XKl3yO6SPfRRG5A1pX7QHYkOihC
 b/jRX1ybt/freTyle2HfXO3O0T7lwuFLHKxjowEEG8gAgiY+LY+ocRz4cw0eMgTEoL3Y1iqTb
 qRXEdS+zfqxw20zdm7Nvt048UOEomWwIztvJ36lZ7PdAoTeUBuHca9i+Ur0/sAEelnYQjLMkb
 KTFKBUNrY53l6l6DEq7IyESXKYwsI1PYWtx7XOVvkIq+39ieXzxbSXXElEUt9TEYDQK2O9lnf
 s1LK2QP76ErK7O/pNVNiFXgHYwCmmllHrW3LpwrWog1E2awqOvS+YYq/Gz37xBugA+A6k/z6x
 46D8ljOSIOePpBXItEC3TK4dT7P3wma8srtKmWd64JcwJf0H/D8hni3tOTnth0SzcXsztdT0A
 emnTiT5oTi/D7bdJQV4Mv6z73P79rdCbv/j6CVW8cSYYVm07wuXbEsaMiWbJbPBfU8zsOVA2B
 emo6phlzJFmtFJPbbyThmhfSzioO4qUCLdqHcrNBC0NTyRrCcLv7x1ATnjCZtNUah05oJbYzi
 CqeE2MoxXXdZdfavrkuqRHMJ2h8rhARyL5FMeuyTX1RZfWjNFSnK3qhZGiv1Mp9/UXQN8mFRz
 onmve1og+Bae7tS0Sn99NhBxUii7ynuahDGsNH2H50O313KP6sTpxl6R+o42sQffYgGSta/eW
 cvWYFdxNHVy24FFyKF/durztT7XPYs8akt2xnDU0ClyQgMuHiBZ7S
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Sun, 2 Jun 2019, Randall S. Becker wrote:

> Just a few small nits from RC2 test results on the NonStop TNS/E
> platform:
>
> 1. t0021 subtest 15 is being flakey. It fails on the first run (make -k
> test) but succeeds when run in isolation. This is new on the NonStop
> TNS/E platform. t0021 has been a bit flakey in the past, but not
> recently. Just thought I'd mention it. It's only slightly disconcerting
> because I make very heavy use of smudge filters but since it runs fine
> in isolation, I'm going to assume it is fine. We had one unsubstantiated
> report of an occasional misfire of smudge filters, but no substantive
> evidence at this point to reproduce the situation.

t0021.15 is indeed flaky, and not only for NonStop. It is so flaky, even,
that I opened https://github.com/gitgitgadget/git/issues/241

> 2. t7519 subtest 25 still does not pass (previously reported for RC1)
> when run via "make -k test" the first time. This runs successfully when
> run in isolation or the second time.

I offered a fix for that in js/fsmonitor-unflake, and it already made it
into `next` (and hopefully into v2.22.0) as you can see here:
https://github.com/gitgitgadget/git/commit/b5a81697520 (look for the
branch symbol below the commit message).

> 3. t9001, t9020, t9600, t9601, t9602, t9604, fail, but should not run on
> platform (not new, just a reminder). We do not have sendmail or
> subversion.

At least for Subversion, this should be detected. For send-email, I don't
know... There *was* a bug in t9001 where it failed to mark a send-email
tests cases with the `PERL` prerequisite, but that was fixed, and I guess
you have Perl anyway?

Ciao,
Johannes
