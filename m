Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2485B1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 23:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfARXvP (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 18:51:15 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:53090 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbfARXvP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 18:51:15 -0500
Received: by mail-it1-f169.google.com with SMTP id g76so9203122itg.2
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 15:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bZcDfwveVBWnXfk/80sV2Dmjba8mO+gKSTdvaCvaJc0=;
        b=f7lyjlGXupHYGa6GIHT8XbheunUlev0Cuy+t/PYq0XVST2cZjBFljYAk1axYP+6T59
         m1NoDBrQMrspAONArbvzEiChD/VB4QtNp0h0Eid4dA6dKlS2fdjH3/2sx8JWjqW5j3EE
         iIX5FjkcqSOx8H3oeqn33XhQJ8Ylm1E2M2KF5nZFuEiPGdShrmNO8i9s+9j7weNTexxh
         Cd+ZBUa9wbYWoGMI8ulm3zlFRZYPXteJM9FxPrl5I+PdZdNjVyYoIyHXdODbaJ9Ul4xf
         MH+uVfAhrCIkItI2+P52Lq2QbMxNv/0jm/fVWEht4JYZRptbpIglPabA7k09DM892rmM
         4k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bZcDfwveVBWnXfk/80sV2Dmjba8mO+gKSTdvaCvaJc0=;
        b=lylnXGqtL21v2zNI2HcoaIlYzPLBBDsgeNde3259Pzd/y7HTPnJLDgE37zipvMtg3/
         8q/847nbQOK/s5YGE5q5glV/VFSdiehUEPWo+NY+KLb1MD5JgXwjSLQ4/P9DxbsmusfS
         misjb4iepq23lYkczhaxT7KWTEGGN+XiJRdcm3x6Exud0IBVlaBypcCMaMH6yjz5jEll
         QvuMomjYHQmxDFxbb58+3TpgSlO3S0TdueBmXb3Ns0+mGNmAITrejnusCoWmgQ8Ykk24
         l1flf0qs7Snu4HMY/rcaMsL+vAd2YQT9Nv+AKCyypsHNmLgl7LonFNOTcbTRmJstlgll
         XOWQ==
X-Gm-Message-State: AJcUukfH1oGPWfmz8EiaHxpQeJLWEaXRm5u5Rq4lrDQwwpBjf5khjh0k
        U1lN4jnku1708+/Wq5sBNbN7po/6HFLlG3JmMe0=
X-Google-Smtp-Source: ALg8bN7nDP1FjY1+lFPooaSF962B7WZiOUrCZ7U1CC7O7bMQJZn5MObE/h66Q8/H8o9Bcb8tvIv1ZuMU2CBBOZ44yJM=
X-Received: by 2002:a24:5f4d:: with SMTP id r74mr12201525itb.170.1547855474191;
 Fri, 18 Jan 2019 15:51:14 -0800 (PST)
MIME-Version: 1.0
References: <CAFd4kYAbrUcV2U1u6Fz3VgZDN_YcpLrSymeA5bvvLy1LY98aHA@mail.gmail.com>
 <87lg3i4b15.fsf@evledraar.gmail.com>
In-Reply-To: <87lg3i4b15.fsf@evledraar.gmail.com>
From:   Farhan Khan <khanzf@gmail.com>
Date:   Fri, 18 Jan 2019 18:51:03 -0500
Message-ID: <CAFd4kYBo7HCBD56KddWdHH_E=nToQcCuAmBpWw7P6A3O2eYtcA@mail.gmail.com>
Subject: Re: Calculate packfile and idxfile checksums
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 3:36 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Jan 18 2019, Farhan Khan wrote:
>
> > Hi all,
> >
> > I am trying to understand how git's index-pack works, particularly how
> > it calculates the packfile checksum and idxfile checksum.
>
> It's unclear if this is what you're asking, but the pack checksum is
> just a 20 bytes of SHA1 of the preceding contents at the end for *.idx
> and *.pack. As seen with this program:
>
>     $ perl -MFile::Slurp=3Dslurp -MDigest::SHA=3Dsha1 -wE 'my $f =3D shif=
t; my $c =3D slurp($f); my $cp =3D $c; $cp =3D~ s/.{20}$//s; my $n =3D $cp =
. sha1($cp); if ($n eq $c) { say "Computed checksum trailer for $f" } else =
{ say "Failed trailer for new content for $f is different" }' pack-79c2ccce=
950e6676452dc9f0473f80003e7ccdef.idx
>     Computed checksum trailer for pack-79c2ccce950e6676452dc9f0473f80003e=
7ccdef.idx
>
> You can also feed it *.pack files.
>
> > I traced back the packfile checksum in the source to the value char
> > *sha1 that is utilized in write_idx_file() in pack_file.c:45. However,
> > I cannot
>
> It seems you mean pack-write.c not pack_file.c
>
> > determine where this value is set.
>
> It's initialized in cmd_index_pack() and then passed down to that
> function.
>
> > My printf() debugging has it set at pack-write.c:171 (right before the
> > hashwrite call) but it does not seem to be utilized prior to that
> > point. Please assist.
>
> I'm happy to help, but still not quite sure what the source of the
> confusion is, maybe that the variable in index-pack.c has a different
> name and is passed down to pack-write.c's function as a pointer?

I apologize for my poor email and appreciate your willingness to help.
Let me try that again.

My objective is to identify how to calculate the packfile and idxfile
checksums and/or where this is performed in the git source code.

You said that this value is initialized in
builtin/index-pack.c:cmd_index_pack(). Is it correct that this value
is the 'pack_hash' variable? At a high level, how is this value
calculated?

That seems to be the packfile index, how and where is that idxfile
hash calculated?

Thanks!
