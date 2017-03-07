Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A617A1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 20:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756211AbdCGUdl (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 15:33:41 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33300 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756206AbdCGUdj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 15:33:39 -0500
Received: by mail-lf0-f43.google.com with SMTP id a6so6334090lfa.0
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 12:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U4XzOZeAUoJLfNkReVbStcYdkP5nccjzdDdOE1TlYt4=;
        b=UJ5PPApqCtkOvyWqoWu91kX8ezItQFbtQNL/qYS1orMBqFVOYRuBBqASUxF309Hccb
         EguiKuA/9JpCdiMDTIRVmfuZrZK5D4CjgN9LlnDvA//wF2awyc+Ls+QNcV9spxJQ2rGY
         BfN3MN0tGJc+Eggjny9AQplIkL5QBdhW4RnMCgh37JfBtYLhZY+DVRIeGaBmiSO/5DIW
         Y2RkQoiG+Zy5PHdMR8TTcngjzAc5BHn0jSV5YQGK3wt5THbqyAOHCzvEiS4DhunWlNIy
         z4D/vjsm4+xvvtv+Y8SUcBbzKI05uWAaqmc2NLCUr05FkT7ntuA9BP66QqbHHacCFkds
         Qw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U4XzOZeAUoJLfNkReVbStcYdkP5nccjzdDdOE1TlYt4=;
        b=J764nnGPESLHfelkc5DnhLa4BAzfLOWbNc91cpiYgnpKnKbA8U1HVTUJi/o3VLahG8
         okV7afH065ybUlngDNZ6tm3BEEmNUgFF6xjTUijaw9L2l++YVvXuurkohv5ML3wiakOc
         fk4qFuCPETuo9R7/rp3KPywe//ldS0Xn/DYcRv+iJmH7ADL8CS1nXgeJH8W73XEcK7Yl
         1nL6M3qWJOAxIl9RGKCJ/Qvj2jrwYqMJSZ9vSx+S1Vt5WrBvIMdAMmexiCLzHNgZmP6R
         5w2yxOOUyRD5EssRGhD4emsQsM4OCweyKQFHzBfDRLJJf8TFYzqJe/zGjKkTp55vnwO9
         mC1w==
X-Gm-Message-State: AMke39mOAA5lbi9OIl9uF3oYEzyO6RALHPuTFThB32MG/GAWUaMI0ADH68p54JtkyvHKotP046+nGt8BPXp+2A==
X-Received: by 10.25.160.132 with SMTP id j126mr583998lfe.24.1488918817575;
 Tue, 07 Mar 2017 12:33:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Tue, 7 Mar 2017 12:33:37 -0800 (PST)
In-Reply-To: <CACczA6WCdu0sdd31R2Z6xbr=meo5PTtcOVYCdVHdgZXAfK-3rg@mail.gmail.com>
References: <CACczA6WCdu0sdd31R2Z6xbr=meo5PTtcOVYCdVHdgZXAfK-3rg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 7 Mar 2017 21:33:37 +0100
Message-ID: <CAP8UFD2vXQzPzdyG=DO1pOsxSmmvrE+z1kjLyz5u14M3hHQFQA@mail.gmail.com>
Subject: Re: Reg : GSoC 2017 Microproject
To:     Vedant Bassi <sharababy.dev@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 7, 2017 at 11:22 AM, Vedant Bassi <sharababy.dev@gmail.com> wrote:
> Hi,
>
> I would like to participate in GSoC 2017 and I have chosen the Use
> unsigned integral type for collection of bits , idea from the Micro
> projects list.
>
> I request the help of the community for clarifying a few questions that I have.
>
> 1. Is this Microproject already taken ?

As already suggested, it is a good idea to search the mailing list.
This way you can find if it has already been taken or discussed.
You can use https://public-inbox.org/git/ for that.

> 2. If it is free , I would like to point out one place where a signed
> int is used .
>
>       In bisect.h , the structure struct rev_list_info uses flags of
> type signed int but , the value of MSB is not checked as a test case
> for any error checking. Hence it can be of type unsigned int.
> It is only used in rev-list.c for checking cases (BISECT_SHOW_ALL and
> REV_LIST_QUIET ).
>
>  Is this a valid case.

Yeah, it looks like it is a valid case.
