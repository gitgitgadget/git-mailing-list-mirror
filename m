Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418561F954
	for <e@80x24.org>; Wed, 22 Aug 2018 17:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeHVVSh (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 17:18:37 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:33049 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeHVVSh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 17:18:37 -0400
Received: by mail-yw1-f48.google.com with SMTP id x67-v6so972655ywg.0
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 10:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NqZNb09LJl1pka/fkuVnC2kQDUIWRQvVbj/0ifsvMmU=;
        b=TBLo/GOjt06i5GbgNFnvmRMW9PYeXPTX56wY6ZxzyLcFRzpK/PPGPGI3an88H1oc2M
         06m00y5Ic/jUhK3HvdWqhsgNYDsjPk3pjqSdB0DCl8lR6VFIIKkkVOX3rwMw1t87hSyo
         G9a7yrQ+5Hf+wBiB1bB5RGg4otz2MeXGQVIibvV5cG5IRsleph/8TxYU1sri4tXZD/uJ
         cgDrvhF0SZ/Q0lck+kTSdjFriI+zr5Tp6u/19AmW5yhFYB28oR+Kez5KnI1ooivMhNSi
         zw3kxuVrqsKh1gZFvWc40zPrlWL0YQ9qXueL4N22SY/I7YvT1H0jJ3Ue54C4pwmBy5xd
         mrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NqZNb09LJl1pka/fkuVnC2kQDUIWRQvVbj/0ifsvMmU=;
        b=pR9NrqKAKaEctQCRttYZdlUbZxKxQeINc90zI1bTSFXBycQoeuJAyXMJEce78qnBaW
         hUA1o9CF7v/Xzne3TBDMU8qPTTXT4nkeFWcB3RrISyRUWQptfFwfcvWx4U1efMKwCkMo
         lZT73QGoL8+uJ+S+proD/HjfcCYl5rIm0dtfsrki7yteyvG5i9BDd99yoRZRPs3p6xSL
         N7Tz+cqdHtH+1uNGNL0OvJ025x+Uo44aniZ7M+1ZovlxzDKociZUXGRKkxyduqm9DVxv
         DU2z5UdUmYYAEpdioEW8Sh5W+U5aiD8SEPkbXsZRXpfIYENWPD8Ddafmh8Ute4KfsEzX
         FfvQ==
X-Gm-Message-State: APzg51BWDbuUoCB9Q3DpfTgShswypHS1Gu3HEuX1RziUSKAXqU3Xw/xe
        oe6NuB2BDzhTfF1X3T1cj/dwlaTxBfv79MadYtwks7gnGkk=
X-Google-Smtp-Source: ANB0Vdbsi729wFuZQEJhs1c7k9Dq6tBp0GzTP/qgrvgfCmP8esQQC0WO1URp2Nsvcx2eQblui1NcXs+dgZrlwZBCDOQ=
X-Received: by 2002:a0d:e6c8:: with SMTP id p191-v6mr640301ywe.119.1534960364147;
 Wed, 22 Aug 2018 10:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5=pr8+x-=9ZYKQSAYp3D5TRmqKf7ui7utgvwsxmf_e5vrGoA@mail.gmail.com>
 <CAM5=pr9LZ_zpmqFJTiOw765sbDkq0AoujzOWK1U_bjstC5FyEA@mail.gmail.com>
In-Reply-To: <CAM5=pr9LZ_zpmqFJTiOw765sbDkq0AoujzOWK1U_bjstC5FyEA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Aug 2018 10:52:33 -0700
Message-ID: <CAGZ79kZLyVnH72=GXu-bX0qaE-pD-BOrdx9aiJFsW7TRHCojAg@mail.gmail.com>
Subject: Re: Contribution for an Open Source Git
To:     satingaux@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Welcome!

In the Git community we do not ask permission to write code, but just do it=
.
See https://github.com/git/git/blob/master/Documentation/SubmittingPatches
or Documentation/SubmittingPatches in your local copy of git.

Cheers,
Stefan
On Tue, Aug 21, 2018 at 11:01 PM Gaux Nation <satingaux@gmail.com> wrote:
>
> https://drive.google.com/open?id=3D0B_6x2GR6_FTMc2RERHlJZVpQc0RIMFMxNi13b=
E95UU1fZmp3
> On Tue, Aug 21, 2018 at 10:54 PM Gaux Nation <satingaux@gmail.com> wrote:
> >
> > Hey there,
> >
> > The name is Sachin Sharma(19 yrs old, student, India) and passionate
> > for innovative technology and digital content.
> >
> >
> >
> > Why Open Source?
> >
> > Open Source connects like-minded genes in the whole world. This lets
> > contributors to get engaged with the groups of different communities.
> >
> >
> >
> > Why Git?
> >
> > I just love the platform your organization had built,
> >
> > 1.Branching and merging.
> >
> > 2.Small and fast.
> >
> > 3. Distributed.
> >
> > 4.Free and Open Source.*
> >
> >
> >
> > Why I?
> >
> > I=E2=80=99m a new bee, therefore I might not have that long list of pro=
jects
> > but I have that level of commitment, attitude and ability to follow
> > directions which are expected from a student.
> >
> >
> >
> > What do I need from Git?
> >
> > Guidance, neither too deep nor too short(optimum).
> >
> > How can I get started for a contribution?
> >
> > What are the necessary technical skills needed for a contribution to Gi=
t?
> >
> >
> >
> >
> >
> >
> >
> > GitHub:  satingaux@github
> >
> > Contact: 8572020330,9138258580.
> >
> >
> >
> > Quote: I might not get selected, but an interaction with you will make =
my day.
> >
> >        I assure you, sir I will work hard to give my 100%.
> >
> >        I feel blessed if I got chance for contributing to an open
> > source community.
> >
> >
> >
> >
> >
> > Technical Skills: JAVA, JavaScript, SQL, C, C++.
> >
> >
> >
> > Thank you
