Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44524202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 02:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbdJUCHg (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 22:07:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50879 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753294AbdJUCHf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 22:07:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F147B5F4D;
        Fri, 20 Oct 2017 22:07:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OftZWr3W9II5Va2Anv5WQyglTtQ=; b=mnLWhd
        +bUHehLz1XtxSKQxPTH49NuDgo7v5JCAmCz8nWDyfVaG/F+oBW54rvya0pHam7v4
        tWIaXys6mr0mfyXeWz9ge+qXYjuQrXsx1q8dg48i2vOJm+NWSWQOJoyXYNW4cxRR
        3ou2bGe/i1/fTrv7GTz9RlvTnsiFILJa+dG+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bVVB1FYFv7jJwci7pJnzrxUaPLnFk6GM
        tqdyW7XqcqwlKa/MITqqv8U5nanHY6XxrjLo7XVjwFe7tTR8NoGCxHXoTLITfaFq
        3T40xArvIXVLr/kcxYBdE7MojYJRF7zxtlig61Mu+VF5D9a3jgHffzB8hN4nayB7
        vb/HOqfi86k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 272A9B5F4C;
        Fri, 20 Oct 2017 22:07:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 994A8B5F4B;
        Fri, 20 Oct 2017 22:07:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Users <git@vger.kernel.org>,
        git-for-windows@googlegroups.com
Subject: Re: Git for Windows v2.15.0-rc prerelease, was Re: [ANNOUNCE] Git v2.15.0-rc2
References: <xmqqr2tygvp4.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710210020290.40514@virtualbox>
        <CAGyf7-HCsTaqa-CC1omtT+O9A4P_SspaNZUf4UbZHcUbh71+OQ@mail.gmail.com>
Date:   Sat, 21 Oct 2017 11:07:33 +0900
In-Reply-To: <CAGyf7-HCsTaqa-CC1omtT+O9A4P_SspaNZUf4UbZHcUbh71+OQ@mail.gmail.com>
        (Bryan Turner's message of "Fri, 20 Oct 2017 16:49:22 -0700")
Message-ID: <xmqqy3o5fe3e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A81F95A-B604-11E7-AE87-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

>> The Git for Windows equivalent is now available from
>>
>>     https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_git-2Dfor-2Dwindows_git_releases_tag_v2.15.0-2Drc2.windows.1&d=DwIBAg&c=wBUwXtM9sKhff6UeHOQgvw&r=uBedA6EFFVX1HiLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=3DdPEJGQe01zvIuHjX8rNURKuGEY_cPkUXvnur9xlNg&s=ZC45D6NoNiE4A8qs_F1ZDMJlGMdXcQ9DwDIpE1-whrU&e=
>>
>> Please test at your convenience,
>
> Thanks for publishing this, Johannes. I've run it through our Windows
> test matrix for Bitbucket Server (~1450 tests) and all pass. I've also
> added it to our CI build as a canary (pending the final 2.15.0
> release). I've done the same for 2.15.0-rc2 on Linux as well.

Thanks, both of you.
