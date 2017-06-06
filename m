Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF325209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 18:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbdFFSjj (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 14:39:39 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33745 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdFFSib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 14:38:31 -0400
Received: by mail-wr0-f179.google.com with SMTP id v104so57943683wrb.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/5huf0iY7CPkNz9iNFlIdAAYa66Nz+X7B7Avx33GmFE=;
        b=fTxRPSH74mBCsHgJYEkufchi3Hz2OF8FJg/QRWIA2vZkB3GwBzkTql0+JmG7DUg4iR
         wx5zR/8uWSOsL7gL29wzl2kVWIP89i1cGyqcFj2sLRprqYaMiyzlCMcq1cle4F4IpK/f
         boj9PJZp0/X3muMki7WGlwR0WvHxYRk30L3xUf81KXBLAQMGMvTA5qX0KOOTCwIFFb7T
         Ea01Z/636+ADK67ndQoprmn/2grIGXcwWnKEWBezijlPdt/A2dPyzliJ1kaxBRKX4t3e
         ATP6AqGkctvuLZGln70SY2fwgQ2j6VG1T5rf7/8dJLlTcFl9DpKjNUqy/yhWeTPRLVXq
         7rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/5huf0iY7CPkNz9iNFlIdAAYa66Nz+X7B7Avx33GmFE=;
        b=KOdC502raII1/tdAbI4uaJKLuCa4PryQmGcRzVHbvgxLheDcHiq5TmTqajuSwOnQls
         1gB1Mqqy8l/P+jzJIgPJXeH3BdfT56prhtYsdFc6vJvskeA8edFoP1eWfVrdsBzMOEAm
         /IFp9koNiuoqdW/8NlFrJ3NCj1R+SLe/rdNZC8soC5rc+jmO+tN62FekwCpJylno1M2y
         x4uc2GPQfzxPI+AFQgOMeJ5E2l/mfS21RavVtM8Itinbb46EZGbF6EwBz16mReb/Jp0A
         R3ZF7tEPcLad8+9JOojUcssU4W+En0j7ND8zTEf32o/UKnN0bkez56UHp2vOrEjzdMLp
         75mg==
X-Gm-Message-State: AODbwcDYVZwzqYOJ9B3KJqE/3TaNJZ1DTqGS7lFb89J5gdejYuYT2243
        garHZ4duHLs7+DKpMHHptABSNXAn6w==
X-Received: by 10.223.177.136 with SMTP id q8mr9844737wra.200.1496774309602;
 Tue, 06 Jun 2017 11:38:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.214.143 with HTTP; Tue, 6 Jun 2017 11:38:08 -0700 (PDT)
In-Reply-To: <002801d2dec9$2cd49dd0$867dd970$@nexbridge.com>
References: <CACkx65CDzw64wsQ_t3YJUm_UP27fBf50n4r7mcMe1wZPW0TSjg@mail.gmail.com>
 <002801d2dec9$2cd49dd0$867dd970$@nexbridge.com>
From:   rajdeep mondal <justrajdeep@gmail.com>
Date:   Tue, 6 Jun 2017 14:38:08 -0400
Message-ID: <CACkx65CRfZ-Se6oPzy6fHtC7R19UWc-EDopudHQY3JiwV-hAAw@mail.gmail.com>
Subject: Re: Feature request: Please add support to stash specific files
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

I completely agree to what you are saying, but sometimes it just so
happens that in the middle of a change, i feel like if some portion of
the changes are fine I can commit them.  Stashing some of the files
and being able to check the compile/tests at this point would be a
really awesome change.

Stash supports a -p option to deal with this, it becomes cumbersome
when the number of files are many.  Maybe it is something which would
be a good to have feature. People need not use it if they dont want
to.

Thanks
Rajdeep

On Tue, Jun 6, 2017 at 9:31 AM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> -----Original Message-----
> On June 6, 2017 9:23 AM, rajdeep mondal wrote:
>>Work around found in:
>>https://stackoverflow.com/questions/3040833/stash-only-one-file-out-of-mu=
ltiple-files-that-have-changed-with-git
>>Workaround is not very optimal. Please add this support to git.
>
> Instead of using stash as part of your normal process, consider using top=
ic branches instead. Before working, switch to a new topic branch. If you f=
orget, stash, switch, apply, then go forth. While on the topic branch, you =
can use add and commit on a hunk or file basis to satisfy what appears to b=
e the requirement here. You can then merge the desired commits from your to=
pic branch into wherever you want to merge them either preserving the commi=
t or by squashing commits together.
>
> In my shop, stash is only used for the "I forgot to switch to a topic bra=
nch, oops" process. I try to encourage people not to use it. I also discour=
age squashed commits, but that's because I like knowing what's in my sausag=
es =F0=9F=98=8A
>
> Cheers,
> Randall
>
>



--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Rajdeep
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
