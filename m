Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB5B208B4
	for <e@80x24.org>; Thu,  3 Aug 2017 20:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbdHCURi (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:17:38 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:37015 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdHCURh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:17:37 -0400
Received: by mail-qt0-f182.google.com with SMTP id 16so14303340qtz.4
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wUDRYYxyusBOn7mxPXAMYuluIvdowhqVNFwigDDpXM4=;
        b=GOmdXsiDnf/thFFfAn2o+RIKXgstz4nvgn4etIGGqbzXbrR6x1dOnlc8b12mW5gXOj
         20jQMm2N+/VX5ama67yOSEDEL+P0tOLT30qaSfvPUPwfYoxGIhHEVD5jr8DjdP/nAx8u
         J4n2n5wOhG4miFckToZDAaEIS2hiwNzyXTigXn84qBuCangdH56j0TwcvWiFuJLddyBf
         14ArWCq/eNJV6XiUWDPFsYjxMr4adSWCZ+tLzxsWO7m0LkQnuY3AX9hB5EK69lbNt0Ns
         qNK/6PyufGZpEJBgB70fr/++Dz0fZtftzQMf5IO4tsowvDMbhDzv0UkN3cpgkIX6JH15
         bLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wUDRYYxyusBOn7mxPXAMYuluIvdowhqVNFwigDDpXM4=;
        b=WXzhKlI6vOUKXm9ojjuSACtQc40JVyfxLLQpLVClpSY6tNmp61Q8Qv2OCKAFBoudKd
         vhNhpEr/AUy5z+IoPv/wLzr+rnuSYl2il9VIe0ZdoTWeBzEvR1sYmFDe3iG5gNWMTAkV
         62fRJ+f+W9tjks/zOPJM9/+j8CUAOBEJEVRGb6rSM06M70r4rM27ABubTDqf+AZdRrzp
         +vfU4vQi3jV6uIK0sO/Wn0K9eaZ5B6Mba9GGOnztfcVeyr7Qw7KJMs5/gi/x7bvEdSAX
         oCN09kXcrxKrocSrawr8jvnDABU82ZMhP1dWRR75q9aWnYV0Y/LE+/hjRwcOvMTntVwO
         xRrQ==
X-Gm-Message-State: AHYfb5gRC4sXg4X/7kOa3ZlrqZIQfUDoOlFb2+eBEZaxHyOGVX4q/IfR
        1KFHr+NW5iD3tx97iaP577wFQNvjCQ==
X-Received: by 10.237.39.142 with SMTP id a14mr63761qtd.194.1501791456691;
 Thu, 03 Aug 2017 13:17:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.39.194 with HTTP; Thu, 3 Aug 2017 13:17:16 -0700 (PDT)
In-Reply-To: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com>
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Thu, 3 Aug 2017 22:17:16 +0200
Message-ID: <CALiud+nKTNsr_z528Wwv3ELLk+uKoJkYa8hctg-C1dtXrbkvKg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> * sd/branch-copy (2017-06-18) 3 commits
>   (merged to 'next' on 2017-07-18 at 5e3b9357ea)
>  + branch: add a --copy (-c) option to go with --move (-m)
>  + branch: add test for -m renaming multiple config sections
>  + config: create a function to format section headers
>
>  "git branch" learned "-c/-C" to create and switch to a new branch
>  by copying an existing one.
>
>  Will cook in 'next'.

Junio, are we still waiting for interaction with other patches to
settle down or simply cooking it further for any potential
feedback/suggestions on this?

>
>  I personally do not think "branch --copy master backup" while on
>  "master" that switches to "backup" is a good UI, and I *will* say
>  "I told you so" when users complain after we merge this down to
>  'master'.
>
