Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714CD1F405
	for <e@80x24.org>; Sat, 22 Dec 2018 02:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeLVCUR (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 21:20:17 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:36243 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeLVCUR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 21:20:17 -0500
Received: by mail-it1-f172.google.com with SMTP id c9so9236779itj.1
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 18:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q31dmCAzC6BBRmMFOZSra78B67qtpzxsZ8R+wf6ga/k=;
        b=m84Mm60qZ+hKSdYVUW8l51yPeKBjYFsL1qbvA1pubmhOJNAa01vRTA2Ed8se7ueRNw
         oHcQAlAf+NfGD+dM/oOrVQsVPz11AAKuFATaW47qITJQn9pEBUjdwDvfwgsx8zGZ/QG2
         YFfz1T8rwOOrPVKW5ZWCpE5EbefLwUVZwQJVVMbI9gtw4VTAfc2ZqsGbT06U7dILpAVg
         mIN9pEACDTGscQYwUG7TIy+tCONbhGCkHcuBgxKNkfALZHTR8PIE7Qdjk4tmyny2Vgmv
         9ATLsoueE89vt01lASFC7EtUigy/T13k4RvI3eJ/1rZMxXe0equA7syfpe1dAvWSED8P
         3rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q31dmCAzC6BBRmMFOZSra78B67qtpzxsZ8R+wf6ga/k=;
        b=PMGQZYWxxQ2vpwLpWsG7Vot+hbA94Kdk0ra9jJDI7voZrQk6NugwA/IbC9NWPcnHVl
         SgEjWx0c12lAgmohj5v3Q98iAMW8E+1HXuvPY0lF17UcAaEGPgHdQZCno4zUt8z+Rgyf
         lVOIalDql9kxK24kGLwL6LE5LgFLW8PqEtLP1qlFL28B0kCuDR9v4EE74WLecmUCjLXi
         R5PUUZf6RWnJOIfdxX5btybwKpbZn/vWV5wEJkIYuCzv86EKlmYl938FglqZXPti4Yrw
         aBPawz6wmT78h3lLLND3VB6iPCWcIlub08woVauAmFDez0QEM6zljsN6peXAEHDE1eb6
         Dokg==
X-Gm-Message-State: AA+aEWY4NRgU2D9VbOlLTwlVn6diNDGkj+Rfcbdrr2PXfmvG8P2QbF2p
        IzPjmFegt5UMNzzqHF6e5Yvcqyl7aolIpLYlw4CArA==
X-Google-Smtp-Source: AFSGD/VPSagvDcLjnL/D04huszI+IIlNrN/S/k3gNTmKXgCx8F7CsyS727m8gMyDJyPnOnORjEvm2SbLN1crGR8V+M8=
X-Received: by 2002:a24:d902:: with SMTP id p2mr3392256itg.112.1545445215529;
 Fri, 21 Dec 2018 18:20:15 -0800 (PST)
MIME-Version: 1.0
References: <CAArbzTBWk2WhEeuqCzUuXC1FAnF1i3ZyM_RsJRDP0Pm0+mHa3A@mail.gmail.com>
In-Reply-To: <CAArbzTBWk2WhEeuqCzUuXC1FAnF1i3ZyM_RsJRDP0Pm0+mHa3A@mail.gmail.com>
From:   David <bouncingcats@gmail.com>
Date:   Sat, 22 Dec 2018 13:20:04 +1100
Message-ID: <CAMPXz=rsZG85dwUokXJj3qnRqCFi7TBPa3qMO2MBKY0s_mRnrw@mail.gmail.com>
Subject: Re: Show-branch without commits
To:     Brian Johnson <brian.johnson@takehiko.net>
Cc:     git list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 22 Dec 2018 at 10:04, Brian Johnson <brian.johnson@takehiko.net> wrote:
>
> Is it possible (or could a flag be added) to have show-branch only
> show the branch hierarchy at the top and not print out the commit
> list?

Does
git show-branch --list
do what you want?
