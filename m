Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5E1215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755295AbeEAM0d (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:26:33 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:42140 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754907AbeEAM0d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:26:33 -0400
Received: by mail-oi0-f44.google.com with SMTP id t27-v6so9921129oij.9
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tjLHCr9rtUCahCYlYCKvkDWZX8f6xAgWefyRaypx/qw=;
        b=lyniSt/25aimeRk4NRuzwOcXDgoW/yUaI6k4QOPGYmXyOw7DHwDhorodSfqsgtpDnY
         QmlJgZTQe6oNB6YG3QAB+n71WWxTuQlkK063Zxzy6luCg5pKkfupljon2/UCICaCCI/u
         oSwRFjR09/Ki/Wrwl4wqv86l0NuEb6RuiA3Ui9e66ZrMjQEyCxHJqNoVpE5cmA6IOjpk
         o7LYh2M3mRlkCFzr5i7YkrrO8aI3rX/xDgBnBKBsEezTMHIGeVLVm9FinxI27zj7cgpi
         WSLpo7D4WeGMHgFNS56+ZCPmgU2Ii3ppL32X035iQeYhLYNkVJ9UI3O/GSAGwH8CNbGr
         N2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tjLHCr9rtUCahCYlYCKvkDWZX8f6xAgWefyRaypx/qw=;
        b=fbglwmdCcwbuTycNvFD035NADyUVawY6qj+yS6ynn962l7K5dqlrhVXK4OM+uJXqvV
         Yw5mO1U3uDgD2cbLv/gC/FRPiX2ij8Sv0fz8bXRy6yYsvKiMF6BLOjaOiwGu4eUhwzjG
         pYN5VRrFAZKGBtAF6IuDJpqNG4eoLH2wlMMeB1JdvcX4+2uWVq9/mtfWrGC0QjCr6tTN
         KHS3Iqh9wrmVkf9bPrX7dexe1lJ9O2leLX6c/lddxrPwz3xBjKUHNjSpJsJpPgR9P7vQ
         CQBE2RubuRNbeESRpiDP4hqjCHOM6jS/ERTgrbg+cPUbOnzWd8QuWwiX77oZU8xqdryu
         fJ2Q==
X-Gm-Message-State: ALQs6tBWILNPNxstGJq+EiZAjOuUXm0zC0BvvQx1ZZQVQ5KNR4uK9XKr
        CRyZ47rOQyhvuxkAAS7STVSA01PBEzad8NKmnPnWoA==
X-Google-Smtp-Source: AB8JxZrqStzD/R63QcjNc+NtIk9Al9i877J68LiHXK40drusHbNbGAt4j//lvhbkoM/srQ6hcWMvIrEl4EZgQoRShEw=
X-Received: by 2002:aca:51ce:: with SMTP id f197-v6mr9805837oib.32.1525177592489;
 Tue, 01 May 2018 05:26:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Tue, 1 May 2018 05:26:02 -0700 (PDT)
In-Reply-To: <CAPQz56bts8zFfUHyKJqnefQoH97L5TTA-k3be=5HsdeEbcMqOA@mail.gmail.com>
References: <CAPQz56bts8zFfUHyKJqnefQoH97L5TTA-k3be=5HsdeEbcMqOA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 1 May 2018 14:26:02 +0200
Message-ID: <CACsJy8AD2bjdRyNDBxcBOEWSknn=kzXfKGtkaYtZmiLshjUg3w@mail.gmail.com>
Subject: Re: completion troubles with bash
To:     Pascal Bourdier <pascal.bourdier@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 2:17 PM, Pascal Bourdier
<pascal.bourdier@gmail.com> wrote:
> Hi,
>
>
> If "GREP_OPTIONS" is set to '--color=always' , then the git completion
> send some escape characters like this :
>
> ^[[1;35;40m^[[K                  d^[[m^[[Kiff-files               mergetool
> a^[[m^[[Kdd                      d^[[m^[[Kiff-index               mv
> a^[[m^[[Kddremove                d^[[m^[[Kiff-tree                name-rev
> a^[[m^[[Km                       d^[[m^[[Kifftool                 notes
> ...
>
>
> So you could find a small patch to disable color with "grep" in attachment.

Yep. The topic 'nd/command-list' on 'pu' accidentally fixes this too
since it removes the use of egrep.

>
>
> Regards,
>
>
> Pascal Bourdier



-- 
Duy
