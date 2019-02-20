Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0E31F453
	for <e@80x24.org>; Wed, 20 Feb 2019 09:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfBTJmU (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 04:42:20 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51856 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBTJmU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 04:42:20 -0500
Received: by mail-it1-f194.google.com with SMTP id e24so52058itl.1
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 01:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KufOvCkdTMgzE4Di7/NFV86kE4zrnn+KnQtF3LFNfKE=;
        b=AjMLneyZKC+4OpdYUAZEhfgfRBp55Of4ttCHSWw8S6PJAy43YFaS+1U5q12TajAFWF
         Hw4OIoCZnd4mgIITXl/xPetU2r8JvmJ+CReLAduTH5tROxQ6cWCGXnjyKRU003cZpssm
         Ko2ARKGLDO5TV7fuvJwqvJ4RO76KD+O1m6o5OA7bwIR2+q5yLHBWchl12cDg/xYojn2u
         Y8cf41s7jSj5SpInvv/DFKPXqZdUstm7kdqTcGbURDsfzRGqQ52PK4qVdD4wqc3Hgq2F
         Iy+x6CI+8GpfeBQNG2LyM+1RmLsztBj9bpscN9iFqo3v3+i/L4zpR8Wi8s/+LuZOFFkl
         OLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KufOvCkdTMgzE4Di7/NFV86kE4zrnn+KnQtF3LFNfKE=;
        b=CewLN6kGj7KkHGiJ0dGwAAj0cFRmi8e2BPAwRizHpaRgs9FYEl6kM15B+Is8sFneef
         g35dwLzl0dLcGj+eS32AWyN9TVnISdve3+wpHZn8v9EqPxKqq0km8MV3blfH3M0dcG11
         I+wGPriH6WkVAf4R7V+T1VDUnOi0STdR/MpB57qo/ry+J5FIjE1/UU0fa0gTukvWangc
         G+3YB0Hxo8k5dy+knOZO5z1I5uKXQw2OzkqvNfa4bx3cbi9643pw7S/2dwbB+5Boy33v
         LR23D5noSS30QpF5ZKigJWrctJ35/+JRAwjQLwv1KGZVPZ5HcmE+G6LEVEx5oqkrchpF
         Nn4w==
X-Gm-Message-State: AHQUAuYQIIm0Hl81tA1ydoZJKhTWlzKM5fM15MPitKw422PKsVD4Cu2W
        mmUX9BFZv+9BIgGo1I6jH5zGPpRoGmr+//Qw6cs=
X-Google-Smtp-Source: AHgI3IZu0rbXl47qk1rEEdeHjjyDJ8yRvbBmUDWykimWGc+5qysrGJNnx8NRWlZHEKNJ9GX1VUa8zTA+i0lv+KDCBiI=
X-Received: by 2002:a24:c056:: with SMTP id u83mr4174315itf.10.1550655739368;
 Wed, 20 Feb 2019 01:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20190216114938.18843-1-pclouds@gmail.com> <20190216114938.18843-2-pclouds@gmail.com>
 <87wolzo7a1.fsf@evledraar.gmail.com> <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
 <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com> <87h8cy6cme.fsf@evledraar.booking.com>
In-Reply-To: <87h8cy6cme.fsf@evledraar.booking.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Feb 2019 16:41:51 +0700
Message-ID: <CACsJy8B15hORnaOdYW8TNE3Gniv9NBJopyLYmHR5iF0U3beq6g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 4:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > I personally do not believe in "backup log"; if we can screw up and
> > can fail to stop an operation that must avoid losing info, then we
> > can screw up the same way and fail to design and implement "backup"
> > to save info before an operation loses it.
>
> Yes, there could be some unforseen interaction between git commands
> where we should have such a backup log, but did not think to implement
> it. I'd hope such cases would be reported, and we could fix them.
>
> But those sorts of cases aren't why we started discussing this, rather
> we *know* what the data shredding command interaction is, but there
> wasn't a consensus for just not shredding data by default by making
> users use "checkout -f" or "merge -f" to proceed. I.e. taking some
> variant of my "trashable" patch[1].
>
> > If we do a good job in
> > supporting "precious" in various operations, we can rely less on
> > "backup log" and still be safe ;-)
>
> Is noted in previous discussions[2] I think that's entirely
> implausible. I think at best the "precious" facility will be used to
> mark e.g *.o files as "don't check in, but don't clean (Makefile handles
> it)".
>
> Most git users are at the level of only knowing very basic
> add/commit/pull/push command interaction. I feel strongly that we need
> to make our tools safe to use by default, and not require some
> relatively advanced "precious"/attribute facility to be carefully
> configured in advance so we don't throw away uncommitted work on the
> likes of merge/checkout.

There is a trade off somewhere. "new user first" should not come at
the cost for more experienced users.

Making "git checkout/merge" abort while it's working before breaks
scripts. And requiring to mark trashable files manually duplicates a
lot of ignore patterns. Have a look at any .gitignore file, the
majority of them is for discardable files because "ignored" class was
created with those in mind (*.o and friends). So now you would need to
add more or less the same set of ignore rules in .gitattributes to
mark them trashable, and gitignore/gitattributes rules are not exactly
compatible, you can't just blindly copy them over. Every time you add
one more .gitignore rule, there's a good chance you need to add a
similar rule for trashable attribute.

Maybe we just add a new "newbie" config knob and turn on the safety
nets on. Leave the knob on by default. And I will turn it off in my
~/.gitconfig as soon as it's real.
--=20
Duy
