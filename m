Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304B7C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbiCGQc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiCGQcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:32:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D78931B0
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646670686;
        bh=O9ASZuW+ipRZbx6eYcbrNO+evZnh1c8i2jXXFiUhy2c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DUiKLtwQT8QBruQ77n0BwR9LjpekCyi+HEDTDnZumuWIHYZM53hXaYcHz3LqKE5mB
         yLFLebnOJzFWe+acl8++C0ANq8MP7fs37RyJV6zdKAlOhEl19/w+EKNqPVZZAwa/lm
         U0k6Ua4f9YyILRetq9nUKUp98lcSRXpC2XcLdkBU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1nssOA1mvc-00lRrr; Mon, 07
 Mar 2022 17:31:26 +0100
Date:   Mon, 7 Mar 2022 17:31:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: en/merge-tree (Was: Re: What's cooking in git.git (Feb 2022,
 #08; Mon, 28))
In-Reply-To: <CABPp-BGZ7OAYRR5YKRsxJSo-C=ho+qcNAkqwkim8CkhCfCeHsA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203071728410.11118@tvgsbejvaqbjf.bet>
References: <xmqqmti9ssah.fsf@gitster.g> <CABPp-BGZ7OAYRR5YKRsxJSo-C=ho+qcNAkqwkim8CkhCfCeHsA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HA5ZrqkyBltrYm+pVFrQKZSsffLa9VmVttGPHkkM2jwzF5h5HIl
 SplRs3z3PIg96sUdpzfU8XC4u653z3x6cyORIqtmEnSRnQ1aLEY7YLqf0HBpnX/kTj6KZ7z
 +uXf3cbpRKqQQluvI9KwModeqWjqR1O2RN8FUJFf3bKduGiu9ZZxt+Ih3Sx8kcZERrjb9WX
 dZ4vhBMiOJ4gykGRXb9Jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0R12+m7KyHs=:ZzoahiulvMHdTdp2VQ1s74
 6j5YQdwixT81kw2UxKGMYn5t1rMFxEsDdrjP07o4wSNeH0doH50VyDyaM5YyolAJAuK+dktBz
 QDd6leyYv7poLmNod6cndTMSyruA++y910Gg5v5nwOS5ZIOEtqosxhSo9amoFSxweCaChsmRK
 LVZW0wy5TL+PHSLJLFvl5Lh/X+g0e4dckR2nnpyzJs+5uEZzN0mBmsqzeC46Lt5ZNQrRn26mD
 L5kn857uDJ8zxtqaybQ7sEKCy+1K7qMJYmVjAVyqmv5oY18hPrpt6cNG7Ps83ywvZzHPhNcQa
 ROrnffuBfr/MoMeI4W6cP9DuE0SpKiNlgdhAXRz6QYmWN/Tay1LqWTWL4aSpqa9UcErw+FzuW
 FG63wOORxEVIs1S3UARiatCKJF90pQ4sfYJL+9Tcv0b11y4aD5vlA03pCbyztZ2l9pYxPrxBS
 ziYw4idof00c5LuUeWExiTZ6FhxawFI/WSfOgCwf4q0dnzfeOiGWgzQiZ4B2YCSr+di432W5Z
 Ut6jJPymFZ7E7tdUPx2XY8e4EZEwsc6j6VloFAz9tMECiQNkDsavI7xFGoSejOActPCBwZm01
 3O+/4mlUaSNqgB8LrIG3vRi8Pq8TgzMW8ZfKUGNWxDb8eRvtQTLXu7pUrexOHb84YYqQXH51C
 DJbUafgTjgGQq4n6SKp4S+GdFDZ88hnPsTJcYQNopiPOu41aMDnUukZLsfqcw6I2pFAf+tbqb
 M5YAmotDVRjKYrCPAlrUCyo30jBSA0ot+5iB9YwJi0FpOfRo5fEYHvm7Z06AIUbjEMnEY7lDi
 JZ4vKElUzSjt1OHjlb5ZcIseE/DGZOt4MEY7taKktIy2w4IkPAb93JPWlTg7HOOhsdvjmy+6B
 ryY18/YzD0/ilGdBTrQdyebcDr3iw93Z4vVHEclRElB0zXlR+BuFCFEDe44X2Aqc6T84K9WGO
 3uVhNMzPwBQXURdbh2A/9hJc5xeYgJ4WvsGd1D3k5qD0IOzGYQn+/cZDlHNWpEdpz9mZi4KNj
 SZz9/2BRsmqtk8Wa7Mb7pozIAwT3Jod179rK3N687lRh7HMvjHfF+RWa1zJTTC/zJn0I+DOmP
 GNssOoezik6b74=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 1 Mar 2022, Elijah Newren wrote:

> On Tue, Mar 1, 2022 at 7:26 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > * en/merge-tree (2022-02-23) 13 commits
> >  - git-merge-tree.txt: add a section on potentional usage mistakes
> >  - merge-tree: add a --allow-unrelated-histories flag
> >  - merge-tree: allow `ls-files -u` style info to be NUL terminated
> >  - merge-tree: provide easy access to `ls-files -u` style info
> >  - merge-tree: provide a list of which files have conflicts
> >  - merge-ort: provide a merge_get_conflicted_files() helper function
> >  - merge-tree: support including merge messages in output
> >  - merge-ort: split out a separate display_update_messages() function
> >  - merge-tree: implement real merges
> >  - merge-tree: add option parsing and initial shell for real merge fun=
ction
> >  - merge-tree: move logic for existing merge into new function
> >  - merge-tree: rename merge_trees() to trivial_merge_trees()
> >  - Merge branch 'en/remerge-diff' into en/merge-trees
> >
> >  A new command is introduced that takes two commits and computes a
> >  tree that would be contained in the resulting merge commit, if the
> >  histories leading to these two commits were to be merged, and is
> >  added as a new mode of "git merge-tree" subcommand.
> >
> >  Will merge to 'next'.
> >  source: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
>
> As I mentioned on the last "What's cooking", let's not.  Please mark
> it as expecting a reroll instead.  I'm waiting to hear back from Dscho
> on whether my latest proposal at [1] would solve his usecase.  That
> proposal suggests output format and various code changes.
>
> [1] https://lore.kernel.org/git/CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95=
dKAR-e1zSjQ@mail.gmail.com/

I am _so sorry_! I didn't expect you to wait for me (and even then, I
cannot take time where there is no time to take, I am unfortunately quite
short on time these days).

=46rom my side, this patch series is totally ready to be merged to `next`!

In the interest of heeding the matra "the perfect is the enemy of the
good", let's avoid adding more concerns that this patch series needs to
address.

Whatever machine-parseable info we want to provide can be made optional,
and we can iterate on the design by marking that option as experimental.

Thank you so much for your hard work!
Dscho
