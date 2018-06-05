Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4561F403
	for <e@80x24.org>; Tue,  5 Jun 2018 05:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeFEFsx (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 01:48:53 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34073 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbeFEFsw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 01:48:52 -0400
Received: by mail-vk0-f67.google.com with SMTP id q135-v6so670568vkh.1
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 22:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qOS7YB6egY/08sHHIKjHXBCe5wRHtnskFvdnxO9Q2+0=;
        b=CCbSgxeCB8db8geWyxdCWtfG/5Qhun47gv8REjF6Se20CK1H+7FF0ntTBgShPka4xr
         g0UmMDxhILaneSAFFiiaKudLI5Xo4ZEpPz1m2kIilLCxG0OKn2uuzkixzyAvnRWU3F30
         wmvKqbj+9C9ln4tEgPB/3Zl0OsyuIXz4Pe2JXOf/cNOaxlfXm3EZL6u0c4DMZ/weQpLo
         Y0EYhCUHQEu5SgIWs2nfQAy3kobdaV+RpqntLxfCnRrf3PVDH9IAHw588SBgUDgH/RTh
         bOO+VivHcLBao8v/f6FdYQt7Y4PBUw53F/yc4JvOKMtsNRXW97BfPKLOuYXzrKlJ1LQq
         6sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qOS7YB6egY/08sHHIKjHXBCe5wRHtnskFvdnxO9Q2+0=;
        b=fWcl49dFXnAPnertWfRmAIYiaUDUum24TEl6eyjBdAH/4kKlPj6fuGsBwc/jzWhPdJ
         Sz1yF0kwJlSqR9vFQjFGjoQQNk5nRyLsImi/B03lu1nXkhRUe/XYcbj5p9dOZghWHR8e
         JY4YHBhvThibHKU1MkbZUFQX7VBzVexg+LozYMJ9iDMeNfn/+t8clENfvL6YWU/uKPKJ
         /oVU4bO8IyjGE88zSLeg2SrRVXlr796W2jYGOHPtkGT2MI7Hr3DLznRCqsYjIJsBBCOL
         mlsaxdr5OG2DzaPr/+JubvUMvHm4N6ue8Ljo63uGR0j+LwEUANBWjDPycAMESzuRPzc2
         O4wA==
X-Gm-Message-State: APt69E3t4mElkbfJEkk67QUP3PeNekfMcUulltdiID0lQTpZuLlMnOtN
        2HBRE6gpgYSs/7TkDDP0yj61gQC+khRL6O9cfrw=
X-Google-Smtp-Source: ADUXVKKLyKB8Oan6oDUpE1rU4U6+407j9G0QE8TzRXV1BrKzUUHVIDBgTCFbn/+DgRwrfHSPRskfTNIDJhnzh16VDjY=
X-Received: by 2002:a1f:2b87:: with SMTP id r129-v6mr4145515vkr.99.1528177732004;
 Mon, 04 Jun 2018 22:48:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:6404:0:0:0:0:0 with HTTP; Mon, 4 Jun 2018 22:48:51 -0700 (PDT)
In-Reply-To: <xmqqd0z61xsv.fsf@gitster-ct.c.googlers.com>
References: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org>
 <3a3eb88e-0d7b-e689-c4e4-207569ebd667@macq.eu> <xmqqd0z61xsv.fsf@gitster-ct.c.googlers.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 5 Jun 2018 07:48:51 +0200
Message-ID: <CAKPyHN0j0VPcMCN4huVP2Dqsg0g3WmOw304S8dcRbWVtZTphHQ@mail.gmail.com>
Subject: Re: git-gui ignores core.hooksPath
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Maes <chris.maes@macq.eu>, philipp@gortan.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        avarab@gmail.com, Git Mailing List <git@vger.kernel.org>,
        philipoakley@iee.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Maes <chris.maes@macq.eu> writes:
>
>> Is there any hope from here that anyone will pick up this / these
>> changes? Will anyone else be assigned the main responsible for this
>> git-gui repository?
>>
>> Just hoping to revive the discussion here, since the
>> https://github.com/patthoyts/git-gui/ repository seems quite dead.
>
> It indeed does.
>
> I've played a patch-monkey in the past for git-gui and have a few
> topics queued still in my tree, but that serves merely as a bookmark
> that is slightly better than a pointer to the mailing list archive.
>
> We need a volunteer to take over this part of the subsystem;
> somebody who actually uses it, passionate about improving it, and
> can speak tcl/tk somewhat fluently (I qualify none of these three
> criteria myself).
>
> Any takers?

the last time this topic came up, Stefan (in Cc) offered to volunteer.
Stefan, is this offer still open? I would support this.

Best,
