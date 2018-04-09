Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3EF1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 17:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbeDIRXw (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 13:23:52 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:41595 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeDIRXu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 13:23:50 -0400
Received: by mail-yw0-f174.google.com with SMTP id u15so3054565ywg.8
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F3GC9TNL6afJe+VpAljrEEIpIkmW+xD9zYPOKNzMJ60=;
        b=Q6JpnIOqw9f6wAliKHfRRqhI+4nwdg4QkGRWh7e2TdEBiCahyo4bX2pUr7S3nkMsq3
         w9sBLkuBN2BiGW0RQoWjq0nnROlH6hPmU6YIoLgw/KsqsS+fx3aN5u1eUtYioPZ1LvJO
         etee4sP9yRBQ0D5GtZ8j4JoPNmuztUNAj4nYinm7k71vgfBsltUZXNEepJaOfjVh2k0H
         FMXSMFFO4platBIPBIg98kR9WUJVdprZt3YCy5wxYzlpQMQGeSQtP6uQJ/75FKx+ugr8
         YFUXAyjJ4zpDPRcCqboeIdXMTJJ3bwMlqDLkXmLOXC6fljmNc7KrmhoSh+dAu2BmhIMR
         7N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F3GC9TNL6afJe+VpAljrEEIpIkmW+xD9zYPOKNzMJ60=;
        b=FVqCwgHpJskpYFQD1IkRLN2Z58NWsCuuTlj8naR8JvWEkkdgfChvIiY2v0ZB16vpui
         +yi/DisqCsNWVSc0kCj14AdFMHx53TTFSG6EuuzX+92NmEysDO8fQsJZ+UR0bTvhnZYW
         1Lul2Gye8tKGfnWH8qRVSe2qL/CfaLgSogna3M4K7xiAkwjtA8kmNTL9CFXxJBQQAspe
         tNCRnt97sxk9tDLb8sVVqYnrmUYKhRKWOa4Rl0d/UtIQB8u2weKlepi7158FJPUxjVyS
         BU1R67PGOiyqAQyGgu1hHbV2Wv80trIQUDmVzVaFC+jK8I/baE8AMZPIly7eq+GLMZce
         wXQg==
X-Gm-Message-State: ALQs6tDWfsjRyJF59bzXe/bCmVIiDyMmH7FL63NBV/Nr/NdCetKE22gy
        jgO2d8X6J2Lv88Y21CtYGr1cqGEnOuSsadi+M8OnXA==
X-Google-Smtp-Source: AIpwx4+J6TS5gD+bBIrdF8p4qp/tTnpyFqNLg3hIIbREGXwSV6OWqLjId1iQy64Mn8zqkSFPHbgFvjvoeDimzu3IgU8=
X-Received: by 10.129.232.5 with SMTP id a5mr12377575ywm.421.1523294629643;
 Mon, 09 Apr 2018 10:23:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 10:23:49 -0700 (PDT)
In-Reply-To: <CACsJy8C4GUy1xv10oQyrDVkdy4nq636N24b2_pGo-nivPY-x=A@mail.gmail.com>
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com> <CACsJy8C4GUy1xv10oQyrDVkdy4nq636N24b2_pGo-nivPY-x=A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 10:23:49 -0700
Message-ID: <CAGZ79kYECaGUvHscsDaT_pzBLdRaO0E34275UsxM4LMW1Ykt7g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 8:31 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Apr 9, 2018 at 12:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> * sb/packfiles-in-repository (2018-03-26) 12 commits
>>   (merged to 'next' on 2018-03-30 at caa68db14d)
>>  + packfile: keep prepare_packed_git() private
>>  + packfile: allow find_pack_entry to handle arbitrary repositories
>>  + packfile: add repository argument to find_pack_entry
>>  + packfile: allow reprepare_packed_git to handle arbitrary repositories
>>  + packfile: allow prepare_packed_git to handle arbitrary repositories
>>  + packfile: allow prepare_packed_git_one to handle arbitrary repositories
>>  + packfile: add repository argument to reprepare_packed_git
>>  + packfile: add repository argument to prepare_packed_git
>>  + packfile: add repository argument to prepare_packed_git_one
>>  + packfile: allow install_packed_git to handle arbitrary repositories
>>  + packfile: allow rearrange_packed_git to handle arbitrary repositories
>>  + packfile: allow prepare_packed_git_mru to handle arbitrary repositories
>>  (this branch uses nd/remove-ignore-env-field and sb/object-store; is tangled with sb/submodule-move-nested.)
>>
>>  Refactoring of the internal global data structure continues.
>>
>>  Is this ready for 'master' by now?
>
> I think so. Things start to look much nicer.

I think so, too.

I am working on top of that series now for the third part,
assuming this is good to go.
https://public-inbox.org/git/20180406232136.253950-1-sbeller@google.com/

Thanks,
Stefan
