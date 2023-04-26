Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAE5C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 06:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbjDZGqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 02:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbjDZGqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 02:46:13 -0400
X-Greylist: delayed 436 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 23:46:11 PDT
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F61C129
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 23:46:11 -0700 (PDT)
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
        by wilbur.contactoffice.com (Postfix) with ESMTP id 2CDAC2CA;
        Wed, 26 Apr 2023 08:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1682491133;
        s=20210208-e7xh; d=mailfence.com; i=pareto.optimal@mailfence.com;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=799; bh=xYA6HKexsXJreWLikSwy0KPK274n+7RMePEPaCbGOO4=;
        b=0dUFOtomxF1Pot4nheUtmgyVy5/gLvLULPJ+sCe2eegsgVfu7bFbwtjjJwPfv0st
        q1ZKoybfOQN8960v7LyHG6brT/PRia3OKia0i+PrnftjrbNT5KkvN4AzBK3OOQadJro
        4PkB0eIUeFxxAeD3qW+D0uFx/WEecYFevpM/mcOp/kpocARjYyqSdY/Z2T60OHTwatF
        AhudU7iblfJr71CqVIYfESpQItnJrG0h9lbwAtx97NGVcDlQNRvY4hAMtb0nXbNcCyh
        Kwt2jB3RQsS97qM/Bw1Y/QpJHaaGDqknAyH1m6+UO09mRs6yKimeFx3z+wNA1UWEDGF
        J0/UdwKvUg==
Received: by smtp.mailfence.com with ESMTPSA ; Wed, 26 Apr 2023 08:38:50 +0200 (CEST)
From:   ParetoOptimalDev <pareto.optimal@mailfence.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     git@vger.kernel.org
Subject: Re: With git+ssh deprecated, how can multiple git identities be
 managed?
In-Reply-To: <CA+JQ7M-jjzWFg-fV=zm1TLPibFZZyRz4-uojyUa9vwjRcf47Sw@mail.gmail.com>
        (Erik Cervin Edin's message of "Wed, 26 Apr 2023 08:25:52 +0200")
References: <87h6t3rxod.fsf@mailfence.com>
        <CA+JQ7M-jjzWFg-fV=zm1TLPibFZZyRz4-uojyUa9vwjRcf47Sw@mail.gmail.com>
Date:   Wed, 26 Apr 2023 01:38:48 -0500
Message-ID: <878refrvuv.fsf@mailfence.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ContactOffice-Account: com:311504211
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin <erik@cervined.in> writes:

> On Wed, Apr 26, 2023 at 8:11=E2=80=AFAM ParetoOptimalDev
> <pareto.optimal@mailfence.com> wrote:
>>
>> Then I could use it like `git clone
>> git+ssh://paretooptimal-work/some-work/codebase.git` or
>> `git+ssh://paretooptimal-personal/some-personal/codebase.git`
>> respectively.
>
> Maybe I can't see the forest for the trees but why can't you use
>   ssh://paretooptimal-work/some-work/codebase.git
>   ssh://paretooptimal-personal/some-personal/codebase.git
> instead?

Wow... yes I just cloned a repo with just `ssh://` rather than
`git+ssh://` and it works perfectly fine.

I simply didn't know that `ssh://` could be used and mistook deprecation
of `git+ssh` as deprecation of git integration with the ssh protocol.

Thank you!
