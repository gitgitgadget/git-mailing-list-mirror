Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49447C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 14:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjBBOUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 09:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjBBOUd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 09:20:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9858C1E9
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 06:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675347626; bh=HhoLEORQ9JRwkZBJYTF/RY6ilR13EwB0Zlizh9vAtwA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Idjsqi43g3850mQaEdXt2nOpqs6tyqYLRjb73q+RDXKIR/omIb7T2iauN5TpZAfd6
         Vx7s05V1SrabiPYIy4TU8ciW+AHZDbcLqNmIq8K+RZR7zvnavhtnTUOlc2rSJAxcrh
         Dk8pf15r93XzN5LhTNkgNwZcrqDA7a3skwWVEP9tq/2h5eDUlTU3Y4bpqCgXOQbfHL
         zzqE9n/04LR1v6eTti6TJHrsmfIb5si4hDmNk49xwgb5kEAIY+NNUhAQ6HnsccSFTW
         OKfXPe4SY5BHfEy4diVHNLIkYY8DlYFUc5er4ornA3bmuYISUj5TrK2O9xDmowJ0up
         E349zrkRuk6Jw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.128.75] ([89.1.215.7]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1ob2EL3MFE-0149nU; Thu, 02
 Feb 2023 15:20:25 +0100
Date:   Thu, 2 Feb 2023 15:20:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: Is GGG mislabeling topics?
In-Reply-To: <xmqqpmba1ld4.fsf@gitster.g>
Message-ID: <52c9ed08-43c3-80c6-32f6-42209b799af6@gmx.de>
References: <xmqqpmba1ld4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:szO6ujbvAgw2bLaYy8qpD2xuuYCtj81siM2sbvUsVLsvhpM988L
 2gkcvHgKwTwimhmgzAQJMusAHW3hHMgVVCzf8jdY4XGqUr2Qd/pLh5dhhF5NyPt29nnfZt7
 NhXNamWpX4DEpXcMZCmgkrpiebZj4UQ1ytRfm//RMJKkd1oPzvQmx6vAFKCncwSwVBlBF3l
 1c7cxeuS7m7Yin0134ZsA==
UI-OutboundReport: notjunk:1;M01:P0:7jxa05A73cU=;jQ5eqTNuJEXj5WIkMioZh8YuqoK
 zoKy48hsAXhbV++Q15aRjM1YSphzQ+LWcNoOvvMBXl1i1cNFjVoBkSYcplL0WRNFB6sXVrTUe
 748lO4+nI1/JFusRwGVbKiVS7dNDZl6wuOUWmJGeydwly5t1U1NAyUNBVvP92apGw4N0G68Wg
 tUz6Haz5x+Xc5hLuMydyHfLIBPqMUjwJHYckz8cUglwTDAUbEnbky0nBxhpQ0OxlSOya5g1T0
 Iu/FeZE5S/3Fh5YERFcX/PWLtawcO9vFdQ2q/c0SO2E+5ndi2r/NX0PX8JwB8SLli/gUjkKpa
 XF3J6IiP6d45xY9DHoNepCwf81bNunnecWOL4cLE9PlBxgClc4sPYDepg0b+dWFv3Tfqmt7kF
 HAPXQXN+xm92jDiZkSF14hL5e7ImBk2DVb83ThWLZ3wpHAKP+VyOdrJt+Kaja0lGadpTHL6k8
 3Bi4ye/82AyDsokaRuXUdtiPzJD8YcYIHGJYehtuDr+gA3fndFaeGK8D7LOPDBGLlJpz9w2f9
 Qun1spbKWj73CNO4Xv0AD5BD/5llSPQ6kjL1boY34D5d0UM+j3LIonbIBcxOLe19Xj6slUZgM
 4i50IQRcL8FJUyc7Teg52AlajUQAfI5KUQWi7Iob46g81IT6q+81RJnQliQbTGKZyiGP65C93
 ETn/ZgpJdEWkdffAFsmy3XlU6r12HnQxrJsLAEYK9HUUswdbmxWu5BB8JRs20spwIfOIoXABI
 gApGB8QLF/6OP6CJGWNRZA4GbMvM6lE+jzWiGfrJH9fBkEO0vAderG15z9HB+0Bce16nV6Cjc
 5GKq6MOnUvqqrkoKPCtNZzdhWWMd8RM0bFsXhShz7n0kGjiX5Pk4CjtuzyOFMO0ua3AEjWE6g
 qtYgmlGCO7jCdQ+NxQ3zSjWxigZtum1iAzk0yqlTr+tGjTLoCDGJ2xQFz2OFNDEIbHNav2e3f
 cqFLnOy1I+QPOijlFGZ4lTAVXVI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 19 Jan 2023, Junio C Hamano wrote:

> These comments from GGG bot
>
>     https://github.com/git/git/pull/1435#issuecomment-1386301994
>     https://github.com/git/git/pull/1435#issuecomment-1386302018
>
> add 'next' and 'seen' labels, citing merges e3ead5f and c52b021
> respectively, but these merges are of a topic that has little to do
> with this pull request (#1435).  Is this expected?

Since I could not make `amlog` work reliably for GitGitGadget (and you
will recall that it was not for lack of trying, not by _any_ stretch of
imagination, I really, really put in a few weeks and it just turned out
that there was no way to come up with a 100% correct record of mappings
between patches on the Git mailing list and the commits in git/git), the
best I could do was to use `range-diff` to identify which patches made it
upstream, and what the upstream OIDs are.

What you see in action is that this is imperfect. Because in the absence
of actual git/git commits that correspond to the GitGitGadget Pull
Requests' commits, `range-diff` will even identify replacements or
alternative patches as the git/git commits corresponding to the PR.

I don't see how this could be made robust without forcing you to adopt
different processes than you are using right now.

Ciao,
Johannes
