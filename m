Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F1C1F790
	for <e@80x24.org>; Tue,  2 May 2017 17:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbdEBRHB (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 13:07:01 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33008 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdEBRHA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 13:07:00 -0400
Received: by mail-pg0-f48.google.com with SMTP id y4so59102381pge.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Anr+dSfldb1Hl4oGYyizNQySWOzXlwraiUrwpo9dlHo=;
        b=Qv5C+bSh9ZFw8oHGAZ3/IA3kmMiYpqa87UyIS5EI5aBxcyOjUhcJlOKDOjbYwJGUdj
         X49V20wxH65ZB2+frxq2R4fouBi6ET9n4C1LspdFm2nlg5jmYvffmsUl5qWtZJUUxpd1
         nUMDif8amtJ504kGp9ZTRKjc+QoQdWnIvqqvcPJpxnF+YP+ZEeaydtSnxjIlmo0N/nah
         VCjvnpVlM04VfdKPyaIV1zFYLnw8jjjT5LTfx77h1e1QF1KQAKeP9EdDkTZDKvyoUDGk
         8vhXgtwHQ6yn4yZYcv77nblMboJL/0tAy1nK+Qvnhrtm66h9HOIxwi9lfx0GMBsHwcuR
         SzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Anr+dSfldb1Hl4oGYyizNQySWOzXlwraiUrwpo9dlHo=;
        b=gsYMTXtdwhutOyy9oSy9iq0KYSv1w1RxTA1eOfDlgJtzyrYUVgu1pIad8SxGcM22jA
         aT36yXRNMRBLiHVPg4QmsdInzk78wze4DhQmjBJ/+MBdlSjIIxSh7v/HDb2RBMh8tLxN
         RRAHSgL4TGcDHs+YG4PyjBx/NC2RmfAgbAsxZXMh8jLODVPqeVogY50u6cnHj+vzEzey
         9kdmQ3+3+UL9dWsb554z5iNbrdLr75AimvSvgCwnzv1+JgFbr5apd+vdYmB/Wh2W8t/r
         uaJfPVXZKeBpEhE93w5db/JugG40h9YO6BQSxMb6oqVrgcFr2Dv3KalZxXPXfn2J1QA+
         HScg==
X-Gm-Message-State: AN3rC/5E/06PRNFcr1f+E1ZLzUxhhMl+y5NLbvfaHUQ9sZvrT5BIh9aW
        /RvRkd9fOlyjPOegwFXiWoiGw0ffYVw7
X-Received: by 10.84.228.207 with SMTP id y15mr3728490pli.172.1493744819705;
 Tue, 02 May 2017 10:06:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Tue, 2 May 2017 10:06:59 -0700 (PDT)
In-Reply-To: <253450f8-4ece-e31b-c139-5d8a3863fb9a@jeffhostetler.com>
References: <20170501190719.10669-1-sbeller@google.com> <253450f8-4ece-e31b-c139-5d8a3863fb9a@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 May 2017 10:06:59 -0700
Message-ID: <CAGZ79kYzDTgtwx6JT4HULTm4sXGLicc_-sMATuL9ayOHxR-4+A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 8:35 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> You may also want to look at unpack-trees.c : mark_new_skip_worktree().
> It has a local variable named "the_index" in the argument list.
> You may want to rename this to avoid confusion.

Thanks for bringing this up. I just made a local commit,
to be sent out with v2.

>
> Thank you for bringing this up and making this proposal.
> I started a similar effort internally last fall, but
> stopped because of the footprint size.
>

Yeah, I also have a bad feeling about the foot print, which
is why I asked if now is a good time to go with such a series.


> In addition to (eventually) allowing multiple repos be open at
> the same time for submodules, it would also help with various
> multi-threading efforts.  For example, we have loops that do a
> "for (k = 0, k < active_nr; k++) {...}"  There is no visual clue
> in that code that it references "the_index" and therefore should
> be subject to the same locking.  Granted, this is a trivial example,
> but goes to the argument that the code has lots of subtle global
> variables and macros that make it difficult to reason about the
> code.
>
> This step would help un-hide this.

Thanks for pointing out the actual underlying reason, that I was trying
to formulate. I'll borrow these lines for future cover letters.

Thanks,
Stefan
