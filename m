Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191281F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755911AbeDYQVh (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:21:37 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:37645 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755808AbeDYQVb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:21:31 -0400
Received: by mail-ua0-f178.google.com with SMTP id i3so4006063uad.4
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IHnaEs+wucfXDiuMwO7IhlBACJHoEcrdYWfB8GTM8NY=;
        b=TwUG0Jhe2yAu4i1t/CVUWEbEUEjaNzJwo78nP76VR5B5hvWvljACRtlzvVD38UmqQE
         zLz9lbCkYjdV7SpZO1p6XGJYGZyvOxTdnAo/LudKcsrtHOV5oJPUQC6c0jwjvQadPMgw
         ku5lfnY15UsGRFVJ99rEXczuNICJjEUknjqHrmPRXtnWk2ThFSSJ06tojTVJcUl9xfgh
         mpz+0pRpDG2AMpdyRfbVaNjWgsS1B+oaoaX46H35pqZcygmM2BTAO6bWimAwJ4LI1XbV
         cSYytO336lBDisq4evzilF5aU0WeBqv8mIGyqGJXQhWkw5dNp13k8daxmJtJol/OukFP
         obgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IHnaEs+wucfXDiuMwO7IhlBACJHoEcrdYWfB8GTM8NY=;
        b=sLWAARVjQ579H2PweZHxmDPRk5WqZvn/pfPX/jbfkjE/sE8cahEy8Jj6TAeMvCu/jr
         4AfPXMtWEkVgkVjvwQf9dXJOcK89RB74+DXtgKaf1kEyhalPTv1HDJ6gYpMEIFUmrvzg
         msbyZBRQhldsFwZZX84eVVLmduTtYy//g4kvlzz0pad8XQXgk+ggkvm4RKnE1M+SJy8g
         m47T39Rh/9TJnWBFOSMAn5hrOnrAQ96b5HGjw3bEIjMePeXTlLttYGAq0Oeamnwq52+C
         ZQwnNLqVqu2uqIdyBwipv54EuAiytLFZl07u4icBr+vMCoJa06mjDRR6K0dCs3Wr4yw2
         yEuA==
X-Gm-Message-State: ALQs6tADRCvgDxArIAy2PtpWpfWeuvErjeQMeOdRTbl6JJ2DzEtAV911
        NSmVqy/Ws8O4SFNdPSFsxNBXSThMFJ0WQ+VVcH0=
X-Google-Smtp-Source: AIpwx499s2lgMlLe4Uq+fmhp1RktIdoGFxuyrvz9luw7Qp3iCbxIcdXVHUnfBHIfJVmOjYWsVykNa5PmHTNiwtMMCko=
X-Received: by 10.176.90.48 with SMTP id l45mr15687045uad.79.1524673290375;
 Wed, 25 Apr 2018 09:21:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Wed, 25 Apr 2018 09:21:29 -0700 (PDT)
In-Reply-To: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
References: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Apr 2018 09:21:29 -0700
Message-ID: <CABPp-BHE0H+Y1FNH2NmYjjMRfPsKjzmfVfT5XQatqyFTi8_2kw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #03; Wed, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Apr 25, 2018 at 1:37 AM, Junio C Hamano <gitster@pobox.com> wrote:

> * en/unpack-trees-split-index-fix (2018-04-24) 1 commit
>  - unpack_trees: fix breakage when o->src_index != o->dst_index
>
>  The split-index feature had a long-standing and dormant bug in
>  certain use of the in-core merge machinery, which has been fixed.
>
>  Will merge to 'next'.

This topic...

> * en/rename-directory-detection-reboot (2018-04-25) 36 commits
<snip>
>
>  Reboot of an attempt to detect wholesale directory renames and use
>  it while merging.
>
>  Expecting a reroll.
>  cf. <CABPp-BHZ-agTY77iqe9BxLC2ijrcKO+UPk83Bn+0cckA3fJFYg@mail.gmail.com>

...is the fix to the issue mentioned in this email you reference.  The
various revisions of the en/unpack-trees-split-index-fix patches were
even posted as a response to the parent of the email you reference
(which I thought made sense since the parent was the report of the
issue; sorry if that confused things).

Would you still like a re-roll?

If you do, the _only_ thing I'll change is a minor typo in the commit
message of 948d8a6f0895 ("t6046: testcases checking whether updates
can be skipped in a merge", 2018-04-19), doing a simple s/year/years/.
There aren't any remaining outstanding issues with this series I know
of, and I've tested everything I can think of to test.
