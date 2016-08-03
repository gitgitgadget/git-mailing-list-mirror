Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1CF1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 17:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbcHCROY (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:14:24 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:36510 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932475AbcHCROX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 13:14:23 -0400
Received: by mail-it0-f52.google.com with SMTP id f6so302252447ith.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 10:14:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aTyGe1kiwag+mkPQYto07zDT3b+MtAu++LJv2GNrQwE=;
        b=OCNCh3r+am1hAhvkHvaotfq9TZhb/IpyKchkgjkpIjr9A5GphhdCSWX+02/b6kwVV+
         UBFIwMJbyL1banDWiUdjuyjTJez0UfUxtb8ewq7hWYosmHUQkk2FGrB8hs1KSMrV0wLP
         4QbMtKRNYbIMVgGeZDROLmBuSSPlBm6ljdQ5p6BUHDksu/9SDvbvmbgazl5VEL4+jz3d
         3IFWHlVaHKYIuoZH/3TDkDhV3jWdaSAawsN8kJfZFuEhEQ91C/Y3yFhiAzcS/QdZYvhG
         f+MW5mVisE7XTaNYnt5zDzEpmIK7RcbnVm5VyO9LHkdHNzM5orETM20ihiP/PAmbULIx
         OQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aTyGe1kiwag+mkPQYto07zDT3b+MtAu++LJv2GNrQwE=;
        b=YQCjPRHGKmsCV4PmycdYbaRSTLZv7B2E4UnEKMvQawjwhLnKF5lKkPNabwQ4V7ZmNa
         6LoaiMe+xevklHoPOOteF1nqWRogFmDqtENyHfwDSjb9oXashQCCCOggkIL4gUA0pxKH
         AjMB4YpDQccIaZ1Oc0QxmA4GTXxfczYlihcLB4uqDJDJJLmkAziUUAsdc9naCeM3+efF
         ORFyGgJjFY3tZDB5xVApH51lfCYUa8uy1iuTaXgHgXRlWPcNXQpnQSEW1buusO9M0Uxl
         pjPGrFce+1zF7U5hB2qZ8CN7sNmhRQAW5UMraJSn+PY7sWLWWYVHb4hZGbII0xfBMz4R
         QoxQ==
X-Gm-Message-State: AEkoousOwqWmosG1F59Q89NNYTVOJGjCorfHiLAxjTDN8KphcSxoX8su2OMsRT40G3+PfzV07xwHEGpxVkKrpwsM
X-Received: by 10.36.228.138 with SMTP id o132mr26049825ith.49.1470244462357;
 Wed, 03 Aug 2016 10:14:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 10:14:21 -0700 (PDT)
In-Reply-To: <20160803152510.pgcd2edareqdxnmh@LykOS.localdomain>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain>
 <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain> <alpine.DEB.2.20.1608031721430.107993@virtualbox>
 <20160803152510.pgcd2edareqdxnmh@LykOS.localdomain>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 10:14:21 -0700
Message-ID: <CAGZ79kZPPvi2jpFgu1MZ97gZm=QqBBiZ-XcXUJphm3UzNRP-FQ@mail.gmail.com>
Subject: Re: [OT] USENIX paper on Git
To:	Santiago Torres <santiago@nyu.edu>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 8:25 AM, Santiago Torres <santiago@nyu.edu> wrote:
>  > share things before they are published. Thankfully, this is OK in
>> > USENIX's book. Here's the link:
>> > http://i2.cdn.turner.com/cnnnext/dam/assets/160730192650-14new-week-in-politics-super-169.jpg
>>
>> While I had a good laugh, I am wondering whether this is the correct link?
>
> Oh my god, sorry, I meant to p, not to ctrl + v. My head is all over the
> place as of late.
>
> Here's the correct link:
>
> http://isis.poly.edu/~jcappos/papers/torres_toto_usenixsec-2016.pdf

In 4.1 you write:
> Finally, Git submodules are also vulnerable, as they automatically track
> a tag (or branch). If a build dependency is included in a project as a part
> of the submodule, a package might be vulnerable via an underlying library.

Submodules actually track commits, not tags or branches.

This is confusing for some users, e.g. the user intended to track
a library at version 1.1, but it tracks 1234abcd instead (which is what
1.1 points at).

Thanks,
Stefan

>
> Thanks!
> -Santiago.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
