Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AADD1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 15:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932367AbdCGPvT (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 10:51:19 -0500
Received: from mail-ua0-f182.google.com ([209.85.217.182]:36709 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdCGPvP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 10:51:15 -0500
Received: by mail-ua0-f182.google.com with SMTP id 72so8932334uaf.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 07:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A0hWxlM6JXgpHlCnq6X23gvtqbI5gj86+5nWQN/BO7I=;
        b=CXF7s8erXMGFbJrV5W6U7s5w1t/OUNszlVjqCx2D2ySJEw9+2Y8dWXRiu+TJuwhNrn
         NrnPXf7RYD4v3kZ1h/cq2DwXirAc5qppANrIDZ4LeO6kCcUa+ASZRUQUpJNNGcVoFFDb
         WnonnkOHli0iY14pcRTdQgU4+xxK1gGImvf/8KW8BigZkr53+UwLlaF3tHxtCtwl+5RD
         F5eeNUcKtIOuHBSfgg149psQHnlUpVHpMtRzNd7DalNCAsUU476ZznZzRSfxLfPB0dbu
         Lve4K+4qniLKvCEddH2HWRdo005PZbNW0d0U5F4ZXN2mKPt9UFJtul2HlLd9AqchOsEV
         lubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A0hWxlM6JXgpHlCnq6X23gvtqbI5gj86+5nWQN/BO7I=;
        b=loS9jMVmRDFw26Jd1CHwMPZZilzrUXpuV2M5QcFZjIs3JIZypt442Q5HfR5T740n8y
         7O/ZBL0MCEh/PHf2ZXk5uMDn8ztin7YN5YvhpZiWI7DLmc0VQCtCSAYNH5y8rvInAJai
         veuCGQ2RMK5JP/trf2/2c01oQiCPHCG/s4GDGpQ1erBS22XzO7Loqaj1JpmCLuzL2h4w
         UBiVBnFuj4lWz7RhgDhO6w1WQHEcK16gQX31jE5cEmX6+w+ujs9DhG3EF8Vt8CawdwDO
         qImHWwl5rg01uDFmHNxBPwWIOVUPnmpTFNsALk/PLBiyJrKL1fajq1vhRmVJhx73kVCC
         iz8A==
X-Gm-Message-State: AMke39nupQo9ZffGIWp1XvA0yIN5TFYyDnwtzMdLcEaH1n8zmdab6Cp+MsfayrtSija8QwyBkPzPGOqiKnqRfQ==
X-Received: by 10.176.82.8 with SMTP id i8mr546839uaa.77.1488901873359; Tue,
 07 Mar 2017 07:51:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.87.218 with HTTP; Tue, 7 Mar 2017 07:51:13 -0800 (PST)
In-Reply-To: <CACczA6WCdu0sdd31R2Z6xbr=meo5PTtcOVYCdVHdgZXAfK-3rg@mail.gmail.com>
References: <CACczA6WCdu0sdd31R2Z6xbr=meo5PTtcOVYCdVHdgZXAfK-3rg@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 7 Mar 2017 21:21:13 +0530
Message-ID: <CAME+mvWk18_Ja7TGfNTCyrN7esoJzweQtd2T=tZ9-_7fjQsQKg@mail.gmail.com>
Subject: Re: Reg : GSoC 2017 Microproject
To:     Vedant Bassi <sharababy.dev@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 3:52 PM, Vedant Bassi <sharababy.dev@gmail.com> wrote:
> Hi,
>
> I would like to participate in GSoC 2017 and I have chosen the Use
> unsigned integral type for collection of bits , idea from the Micro
> projects list.
>
> I request the help of the community for clarifying a few questions that I have.
>
> 1. Is this Microproject already taken ?
>
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
>
> Thanks.


You can search your microproject on public inbox of git to check if it
has already
been taken or not.
