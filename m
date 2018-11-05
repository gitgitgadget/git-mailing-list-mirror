Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C921F453
	for <e@80x24.org>; Mon,  5 Nov 2018 04:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeKENmc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 08:42:32 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:35042 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeKENmc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 08:42:32 -0500
Received: by mail-it1-f178.google.com with SMTP id v11so4653763itj.0
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 20:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vymebQ9Gg6LawfR+pZaMggeGvPCwL8ZvXqu5unS6Rus=;
        b=osU8ptyGGCdKsCiBtLn4yacmecdVn2PS54+WAujPVGgTyyAdoxTByPSfWhBZeQjhqD
         xTMyyep55UhZER63TLjakQfkZKgNLI52KX6Ua9/EZQ3xGiifeM5GOwsgScoJCvOA+IHN
         MLnKm7MdBDlZrmIj7YVhxZINIIlCZBtKtJaFNqcpeC3SXj5qx//XIajtcAQOehec6AWH
         SjPnRd/AjKa2TSb7B93AUDsRDEjZRquX0kJuhAjg6HHq7PtEnixY+aVxUyjB2NLaLkq3
         QDifXxFilktOeL3j0Ec2r64wj2Gut0VV4ujSrGQ/AUAZ84Tm9RKe1Lh3l70Q6BtajJ0W
         X36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vymebQ9Gg6LawfR+pZaMggeGvPCwL8ZvXqu5unS6Rus=;
        b=GZiX4xJ9Q0ju4r6UpIh7CWVafSgXVr3lWMTrJZjibUZQbol/TtxOL8a62GCxEwC9Q6
         TWG7uJlWp2MV12p53HozKiBby6RimW9egAnH7h0k4W8iAlUI4PkRnYAa//iQyQVI9h8I
         qXVfDIRKSFUUqx8cW8im6vCVSoZuQR3UXvs2mv3HOnYkzVq9rnaebCbXU1MvkN9chqv0
         8hCN34W4DCGBPOZc884tmrVTJov1VlcE2/NtBoUusbo1wjGUGHvI9IncQVwpiu1AG9zq
         Mb65cjJdOdELJaiFZZducRfKA52kkZvnc3N1wkSy69NDXkcvXJMdGfOKVZNfQQSFOivw
         54xQ==
X-Gm-Message-State: AGRZ1gLc+VirHZ9ceeZNEQibt32FhRvqZbKwsKUC2USFe0hZ67d4dMar
        EUbwJFffkRELibRashA7i2jxTBsdrfr+CWe2gBw=
X-Google-Smtp-Source: AJdET5eJfSteykcttPub3kUGbqQzKA5Fc/ErDLAggsXoTshYX3FyYXhOtORulx1iIdOcwczZ817Gj6ytQrJ5k4XEHGo=
X-Received: by 2002:a24:4f82:: with SMTP id c124-v6mr5679669itb.108.1541391891830;
 Sun, 04 Nov 2018 20:24:51 -0800 (PST)
MIME-Version: 1.0
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20181104170729.GA21372@tor.lan>
In-Reply-To: <20181104170729.GA21372@tor.lan>
From:   =?UTF-8?Q?Adri=C3=A1n_Gimeno_Balaguer?= <adrigibal@gmail.com>
Date:   Mon, 5 Nov 2018 05:24:39 +0100
Message-ID: <CADN+U_MgrGHLQ5QNa-HgzxLN4zJLJPu4PaT2MTRoc18=gET+5Q@mail.gmail.com>
Subject: Re: git-rebase is ignoring working-tree-encoding
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El dom., 4 nov. 2018 a las 18:07, Torsten B=C3=B6gershausen
(<tboegi@web.de>) escribi=C3=B3:
>
> Thanks for the report.
> I have tried to follow the problem from your verbal descriptions
> (and the PR) but I need to admit that I don't fully understand the
> problem (yet).

I have created a PR in the Git's repository. You can read an updated
description there:

https://github.com/git/git/pull/550

> Could you try to create some instructions how to reproduce it?
> A numer of shell instructions would be great,
> in best case some kind of "test case", like the tests in
> the t/ directory in Git.
>
> It would be nice to be able to re-produce it.
> And if there is a bug, to get it fixed.

This is covered in the mentioned PR above. Thanks for feedback.

--=20
Adri=C3=A1n
