Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E641F954
	for <e@80x24.org>; Wed, 22 Aug 2018 06:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeHVJYz (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 05:24:55 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44074 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbeHVJY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 05:24:29 -0400
Received: by mail-wr1-f47.google.com with SMTP id v16-v6so558547wro.11
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 23:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Hoe20Kluv0vQU4Hp/nPtxVAZ+C1MxvdLnJH8Mcfsw3o=;
        b=oYQKYKfFp9wdvRWV1ddi/7v6QUx0/iVHyeTrFJC1KBt7q34sifNgr1p/isqbWDuD4I
         PPRBajnVIKnzz2TaprwuNMwi2D16SI7vkxx9m/fBcH4fD+odsVCQ4i2JnTh4kGiJRNKX
         iJRCiikPgyV5SBXsaDn0OHlbS4KM0Me99mrI7WUQuwMJBGYwQhtYEZNQ28PZsdALcf7Z
         HOywJOaZt/yGN9Fo5mNRJ8p5DT6BBt6B5/7fQ1te7XQKrckLLFZBG/hPlWG2KTNvqN3z
         rqqsrpd9rxxJuZVvC3N+IJ4rCZTzg3OeLlRXvmJakoNLOA1aQ1AKwvv2BXQaZYj8rTik
         IvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Hoe20Kluv0vQU4Hp/nPtxVAZ+C1MxvdLnJH8Mcfsw3o=;
        b=PX2hQ8x1qWsFoN912GDV2yhtBI0pV0XjHoU9KSJzUvUEcz5oeGidT6OnYFbeNO7rvr
         uAEB+20Tf1cURASxovp14FzhPyKXstlIgHAKr/tvHbT+TzPtl/DOfFwfmpSWZWm5duJJ
         2BWwzUbW6ygOPUL1tRCSeyg0ENB52PUaIBsL04w/3OZkLJazmBxFA2i/PgjZTjBgiXUB
         ZYjm9AdMAKzvYf4CUpNk2gszvQqlquCS5IYLr+wSF/hx+9ybNzgZezRTR66wMLPO9RnH
         jtWqt17caIq7FNt2bwORZa/FeyZ+jYN6cyOSb2D96geQ78wMGFe0IQpxg6370tK2OCIN
         Uvmg==
X-Gm-Message-State: APzg51DBxUBTgv+ZqRS/r21MWgMV8XoCrNvuHl54ssoO+R2pRwBnseRL
        oln1QJmIX3b9nf+eYcVAmVgvtRAuzHw4Efat90/KMqE=
X-Google-Smtp-Source: ANB0VdYE3NVJDfbeIhwg7fa7f6P2UmOhql/s120pQqe+cetVBE5W/B4Yy3Jc3xiK5/R0pzo0NUXqj68vZoLlpHLiLBk=
X-Received: by 2002:a5d:504b:: with SMTP id h11-v6mr6528301wrt.18.1534917665780;
 Tue, 21 Aug 2018 23:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5=pr8+x-=9ZYKQSAYp3D5TRmqKf7ui7utgvwsxmf_e5vrGoA@mail.gmail.com>
In-Reply-To: <CAM5=pr8+x-=9ZYKQSAYp3D5TRmqKf7ui7utgvwsxmf_e5vrGoA@mail.gmail.com>
From:   Gaux Nation <satingaux@gmail.com>
Date:   Tue, 21 Aug 2018 23:00:55 -0700
Message-ID: <CAM5=pr9LZ_zpmqFJTiOw765sbDkq0AoujzOWK1U_bjstC5FyEA@mail.gmail.com>
Subject: Re: Contribution for an Open Source Git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://drive.google.com/open?id=3D0B_6x2GR6_FTMc2RERHlJZVpQc0RIMFMxNi13bE9=
5UU1fZmp3
On Tue, Aug 21, 2018 at 10:54 PM Gaux Nation <satingaux@gmail.com> wrote:
>
> Hey there,
>
> The name is Sachin Sharma(19 yrs old, student, India) and passionate
> for innovative technology and digital content.
>
>
>
> Why Open Source?
>
> Open Source connects like-minded genes in the whole world. This lets
> contributors to get engaged with the groups of different communities.
>
>
>
> Why Git?
>
> I just love the platform your organization had built,
>
> 1.Branching and merging.
>
> 2.Small and fast.
>
> 3. Distributed.
>
> 4.Free and Open Source.*
>
>
>
> Why I?
>
> I=E2=80=99m a new bee, therefore I might not have that long list of proje=
cts
> but I have that level of commitment, attitude and ability to follow
> directions which are expected from a student.
>
>
>
> What do I need from Git?
>
> Guidance, neither too deep nor too short(optimum).
>
> How can I get started for a contribution?
>
> What are the necessary technical skills needed for a contribution to Git?
>
>
>
>
>
>
>
> GitHub:  satingaux@github
>
> Contact: 8572020330,9138258580.
>
>
>
> Quote: I might not get selected, but an interaction with you will make my=
 day.
>
>        I assure you, sir I will work hard to give my 100%.
>
>        I feel blessed if I got chance for contributing to an open
> source community.
>
>
>
>
>
> Technical Skills: JAVA, JavaScript, SQL, C, C++.
>
>
>
> Thank you
