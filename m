Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F56D20A93
	for <e@80x24.org>; Wed, 11 Jan 2017 10:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759627AbdAKKNF (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 05:13:05 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33513 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756615AbdAKKNE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 05:13:04 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so90127045wjc.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 02:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SqcCgDkQTgZdo9dIDEsouZ0ljsJK02uodvZevgpEZEo=;
        b=KqguuvniY89dO551czihw90HGoh88Nf9ykaaP0aMN+/lKBcLbgPTOBu7ga8RbbuWFM
         d/jjrrqiUniHk8bt1HGBMCgT5ND3bOa0iVl9VFgFdiK2hxyS6Uwjub8K+ZjhvZFclZVH
         1tHHPSIGs+RHxr7osfzufTCQ9tXqswCnrsc+bdkl2NJhVPk/+PHkfiZszFcM2WnK9hV6
         l4q3TDGcrnin3vcq6AmQj2pQI0IIQQvvLsJT2xOswPHhFVykTlQ2lp6tNBBOYNC2BXrA
         gg8oNdrtMo0juGNb0OmAtz/XLGJsoLHxsh9gMbkQ/2kLnhsjFfjtWimN4gCsQBZI1D4M
         zOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SqcCgDkQTgZdo9dIDEsouZ0ljsJK02uodvZevgpEZEo=;
        b=Q98sS5u3kCUiNOTl+5Sk62TCwDJrl4pmJ0hwXc4Q1roDpuXCR5XOFzulm7KBvXMsOx
         S9FAZO2pxK475UhgozjTfxoqgs8D2vMFelXTnzkyOPIwqkKy+Wboq0E8qB5GPO5IkvR7
         /u1D83TDF/2DQ3Hgsrw4CYhkM8oVGA28QSfw95vJdQ/DGB52wjWO3knaCq8A82PtZXX7
         T1LT96dzosjzeGtLaAKf/iwYvJbV7AJb5nvxWNPG+GT/3kNjosbBM4tyFxvRbD8LggHJ
         m6IsbtpgICgw6108qjZNiR8Kh8hExAbYONiFbHCdYFcPxz4+vzz8dRe/BG1vfsGC5dmT
         e5Kw==
X-Gm-Message-State: AIkVDXK+aQNpfp4zh8zNEegnz2YXUF+5K69abz4If6Ax29OsE/VPAkZpVjBLtfKQhU3/bw==
X-Received: by 10.194.202.167 with SMTP id kj7mr5394621wjc.191.1484129582644;
        Wed, 11 Jan 2017 02:13:02 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5866.dip0.t-ipconnect.de. [93.219.88.102])
        by smtp.gmail.com with ESMTPSA id d199sm3430551wmd.0.2017.01.11.02.13.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jan 2017 02:13:01 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170109233816.GA70151@Ida>
Date:   Wed, 11 Jan 2017 11:13:00 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        e@80x24.org, jnareb@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F533857D-9B51-44C1-8889-AA0542AD8250@gmail.com>
References: <20170108191736.47359-1-larsxschneider@gmail.com> <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com> <20170109233816.GA70151@Ida>
To:     Taylor Blau <ttaylorr@github.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Jan 2017, at 00:38, Taylor Blau <ttaylorr@github.com> wrote:
>=20
> I've been considering some alternative approaches in order to make the
> communication between Git and any extension that implements this =
protocol more
> intuitive.
>=20
> In particular, I'm considering alternatives to:
>=20
>> 	for each delayed paths:
>> 		ensure filter process finished processing for path
>> 		fetch the thing to buf from the process
>> 		do the caller's thing to use buf
>=20
> As I understand it, the above sequence of steps would force Git to =
either:
>=20
> a) loop over all delayed paths and ask the filter if it's done =
processing,
>   creating a busy-loop between the filter and Git, or...
> b) loop over all delayed paths sequentially, checking out each path in =
sequence
>=20
> I would like to avoid both of those situations, and instead opt for an
> asynchronous approach. In (a), the protocol is far too chatty. In (b), =
the
> protocol is much less chatty, but forces the checkout to be the very =
last step,
> which has negative performance implications on checkouts with many =
large files.
>=20
> For instance, checking out several multi-gigabyte files one after the =
other
> means that a significant amount of time is lost while the filter has =
some of the
> items ready. Instead of checking them out as they become available, =
Git waits
> until the very end when they are all available.
>=20
> I think it would be preferable for the protocol to specify a sort of =
"done"
> signal against each path such that Git could check out delayed paths =
as they
> become available. If implemented this way, Git could checkout files
> asynchronously, while the filter continues to do work on the other =
end.

In v1 I implemented a) with the busy-loop problem in mind.=20

My thinking was this:

If the filter sees at least one filter request twice then the filter =
knows that
Git has already requested all files that require filtering. At that =
point the
filter could just block the "delayed" answer to the latest filter =
request until
at least one of the previously delayed requests can be fulfilled. Then =
the filter
answers "delay" to Git until Git requests the blob that can be =
fulfilled. This
process cycles until all requests can be fulfilled. Wouldn't that work?

I think a "done" message by the filter is not easy. Right now the =
protocol works=20
in a mode were Git always asks and the filter always answers. I believe =
changing
the filter to be able to initiate a "done" message would complicated the =
protocol.


> Additionally, the protocol should specify a sentinel "no more entries" =
value
> that could be sent from Git to the filter to signal that there are no =
more files
> to checkout. Some filters may implement mechanisms for converting =
files that
> require a signal to know when all files have been sent. Specifically, =
Git LFS
> (https://git-lfs.github.com) batches files to be transferred together, =
and needs
> to know when all files have been announced to truncate and send the =
last batch,
> if it is not yet full. I'm sure other filter implementations use a =
similar
> mechanism and would benefit from this as well.

I agree. I think the filter already has this info implicitly as =
explained above
but an explicit message would be better!

Thanks,
Lars=
