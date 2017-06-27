Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9978320401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbdF0Sh0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:37:26 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36767 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdF0ShY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:37:24 -0400
Received: by mail-pf0-f179.google.com with SMTP id q86so20626008pfl.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+ph+v0roHfNR3xE2JnveRflj74FlC8s1iJ1r2iErots=;
        b=Zewe/Fw32r7tzSjYjM+2/1EXeB20zE9mJhVxUzBBSxDWOwIgpky2itvlaH1hTNc+V9
         o7/stgR14ZVp98uwY5eN2Sa4F5fstw+x81Abh6F9dc/a+u2YSuGnT/HbjXj9dFKB6MNI
         DFQnlePw+kQDJpXK4mztYVUiLldVkuzhVWg2kqZbaC76wYQ8F7FsoByHGVmsUI+kOwVN
         QHCv0ZZ+h50I5H5fEp+ZAM36yrJrFfoYGci07LgS1HPnKrhInbH3TKnvcYa3WXVqHOrc
         vzD5ouvpwILDPaDkKDzpGj4x99JX3f9BKPdAwD8FrOFe/H5FypUG0i0zPhOl96iT1Q/q
         5ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ph+v0roHfNR3xE2JnveRflj74FlC8s1iJ1r2iErots=;
        b=pO6+WB1OSlIkPCrIdANzMouNgLo9WcjKel2oQio98LaJs4g5tXQKbo4rnNtgMU81sU
         TZL3cpLmkILy2vtAlOasUmxth31lmXdQezrhHiJtt4apQzf/T5Na+DgQ/eRYqPHlc7kI
         9XjlUs/PFE0btB5jW/mHC2JMroPws/egPxNRvD0npaSyb4M2c4E7QyxoY9QOjeGndMBx
         mdnxtUlAcRJMlZhqOyzJcqek+SenGjVRW+/qE64fbWr7az1W4N0TS43FOSBwaIGX0Hfi
         IPL7sxyQVJEX2rm/8TvJVhIayBsgLnT9siJf1DGbiQg7Z0xUbuMTWasua+fwxN3XQ5wg
         QiUQ==
X-Gm-Message-State: AKS2vOxhn2pgpilvj36GR8BQcytimMPfW2kXhUA/nJzO8Qobnk9rWoJK
        1/LTWCMXQcg2NbtHkKtUrHDTZEQByrhf
X-Received: by 10.98.69.76 with SMTP id s73mr6521910pfa.94.1498588644070; Tue,
 27 Jun 2017 11:37:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Tue, 27 Jun 2017 11:37:23 -0700 (PDT)
In-Reply-To: <20170627121718.12078-1-avarab@gmail.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <20170627121718.12078-1-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Jun 2017 11:37:23 -0700
Message-ID: <CAGZ79kYbPfzH2vDhDuo5mePSSMcWZJgKNT19U4Nb20tpG6xJXg@mail.gmail.com>
Subject: Re: [PATCH 0/3] update sha1dc from PR #36
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 5:17 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> This hopefully fixes the Solaris SPARC issue & doesn't cause
> regressions elsewhere, e.g. on Cygwin. Adam, it would be great if you
> could test that platform.
>
> I've already confirmed with Michael Kebe + another SPARC user
> (CosmicDJ on Freenode #Solaris) that it works on Solaris SPARC. The
> question is whether it breaks anything else.
>
> Per the upstream pull request:
> https://github.com/cr-marcstevens/sha1collisiondetection/pull/36
>
> Marc would (understandably) like some wider testing of this before
> merging it into the upstream project.
>
> WRT the submodule URL & branch changing: I have no idea how
> git-submodule handles this in the general case,

It is trying a couple of things, see cmd_update in git-submodule.sh
look for the call sites of fetch_in_submodule which tries to
fetch the default branch, by-sha1 if that doesn't help.

> but it Just Works with
> GitHub because it allows fetching arbitrary SHA1s that any ref
> (including pull req refs) point to.

Which is only half the story (but it works most of the time).
They may have uploadpack.allowTipSHA1InWant but what is
really interesting is uploadpack.allowReachableSHA1InWant.
