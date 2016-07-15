Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311ED20195
	for <e@80x24.org>; Fri, 15 Jul 2016 14:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbcGOODA (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 10:03:00 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36499 "EHLO
	mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbcGOOC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 10:02:58 -0400
Received: by mail-qt0-f175.google.com with SMTP id 52so59758928qtq.3
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 07:02:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g7DrWn6vKY8zBYZ7TsNfTDi2R30n5DacGDsgFTKzmoE=;
        b=S4QScDdHKS80JZOS0QAOzwEdwlLDzB12hqoQpAs5uhjjmdpCqGh3ILzbKzWGTCGGM1
         ICot0kFpmv4YrVdoZtapkY3TVB0xv/UpmnR4j5wIl0OkYziRK5hNE0W9PCq/qGJ1EVd/
         QNHPu4adOUMpaxVJ6mCJHAx75Kl2XMjLCY/IUIgrI/m3yCZoOfjhc9ZVIBqp8DaXE3QE
         nF3P9EJKWoyVjkgiAK1GXOY2qLR4QjXPe1mv6ccpopo4ni2x/nnNcQprTRmkEIHXd995
         6q8XURlJEBaK3kl3NMEgtEIw7M+JAsqcsmvOrwz2lzaMZtYDs8qHSptZXvVQQWmkub51
         Tidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g7DrWn6vKY8zBYZ7TsNfTDi2R30n5DacGDsgFTKzmoE=;
        b=VTviiOzR9vEve3wfuzmt/PFMyP3dNWryvXt/UJJWuu+7UUyp+yVzGyLV9nF5UOAVD3
         pBTSSc9fHDnOJNPUoRTvnhcJsUYk5HwF/tX3CDBoUSrtLPJMGaMfTq9OVSajdatAKqkF
         T+p6rb5gcm1keIWkIuq3Fm79NE3Bm+qVIIHXh1Dob4IpGfm3Ai7VS2OVx7hxg85I5fza
         JbSB9qdepOqsD479ugFA/siZ0oC0TfYwt+zG/bBeLPxPFI0rcfQaNmimmL9X459rN4Bm
         LpJbxAtbFdi5cmjj/Hs5nK8tUVKE+CPEjVQCrDLaZtMV/rc3oC1cHqmY4etjrCJZqNLR
         Vo0w==
X-Gm-Message-State: ALyK8tIm6f/8JCYw+NM40qnnawDdA7w9Y0UOLrQpM0iqAGklIY+TV5I7S1RL2vSPksT8UAMk2MK9pi1isedMPA==
X-Received: by 10.200.57.108 with SMTP id t41mr4880802qtb.33.1468590984043;
 Fri, 15 Jul 2016 06:56:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.36.77 with HTTP; Fri, 15 Jul 2016 06:56:04 -0700 (PDT)
In-Reply-To: <CAPc5daXxAqXtUvs1Xr_vgncXqcvR8-VG67oDAgOQ8xPcT7nCeQ@mail.gmail.com>
References: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de>
 <CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com>
 <alpine.DEB.2.20.1607141948530.25238@tglase.lan.tarent.de>
 <xmqqpoqgqdlz.fsf@gitster.mtv.corp.google.com> <CAPc5daXxAqXtUvs1Xr_vgncXqcvR8-VG67oDAgOQ8xPcT7nCeQ@mail.gmail.com>
From:	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:	Fri, 15 Jul 2016 15:56:04 +0200
Message-ID: <CACBZZX7YFQ3o+5wbVz0ca6__3ViD0b-qbrX06CkxhAHE8uQ6oQ@mail.gmail.com>
Subject: Re: Server-side preventing some files from being overwritten
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Thorsten Glaser <t.glaser@tarent.de>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 8:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Thu, Jul 14, 2016 at 11:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thorsten Glaser <t.glaser@tarent.de> writes:
>>
>>>       if test x"0" != x"$(comm -23z \
>>>           <(git ls-tree -r -z "$old" "$subdir" | sort -z) \
>>>           <(git ls-tree -r -z "$new" "$subdir" | sort -z) | wc -c)"; then
>>>               echo >&2 'Untouchable files touched, commit rejected!'
>>>               exit 1
>>>       fi
>>
>> Can't this become simpler, e.g.
>>
>>         if ! git diff-tree --quiet "$old" "$new" -- "$subdir"
>>         then
>>                 echo >&2 "Ooh, $subdir is touched"
>>                 exit 1
>>         fi
>
> Ehh, you need to tell diff-tree to recurse, i.e. "diff-tree -r".

Note that although this is literally what Thorsten is asking for, I
think it's worth noting for the list explicitly that all these
examples that do "diff $old..$new" will *not* prevent your repository
from having *commits* that touch those files, but they will prevent
you from having *pushes* where the end state is a net change in those
files.

I.e. it allows pushing a series which is a series of two commits which:

  1. Change the forbidden file(s)
  2. Undo changes to the forbidden file(s)

This *can* be critically important or not matter at all depending on
your use case, i.e. does it matter that disallowed and potentially
malicious changes come up in "git bisect", or will you ever be rolling
out anything but the latest tip of the branch you're testing in
production?

If the answer to either of those is "yes" you need something that does
a "git log --stat $old..$new" and parses out if *any* of the commits
make changes to those files.

See e.g. my https://github.com/avar/pre-receive-reject-binaries for
one example of that, although it rejects binaries you could easily
modify it to check the filename(s) instead.
