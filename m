Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099381F42D
	for <e@80x24.org>; Fri, 18 May 2018 11:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeERLbF (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 07:31:05 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36527 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeERLbE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 07:31:04 -0400
Received: by mail-it0-f41.google.com with SMTP id e20-v6so12712918itc.1
        for <git@vger.kernel.org>; Fri, 18 May 2018 04:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anmol.io; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QPmq1RVz8zuveMg27LwqEIWk5UaS/2k0TVwLFMFAPRU=;
        b=DkquYHpHECN5e/JRw0rInMsYO/2lVgc3E68Be8fwKbpVDHoOoKjxb+THEHjYcK9QLr
         mugeNsxlxhGIc68Jc9pVfpyUwJebO9nDk0YaSH5FbP2OeCaG6dmStLIM42dAZTkuAwzn
         4YgoNKfE/XcULhqWu1HLAUoi5erteKj5pHysA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QPmq1RVz8zuveMg27LwqEIWk5UaS/2k0TVwLFMFAPRU=;
        b=B2eTSCOX3X06xAxTftU1qas0AfarQhjegwWXI5cA5QyPAM8TKrEj3874gxgObEdvji
         Fo3tgD84Lf2nFTSEwr/49CWvJpcAwTJ/O4lUNc5MOv/Ennr7MzoMli5vcnNoFu8nG5yi
         lJZgRGl/d+1d6bRI+sQaKGQMz53XPF3jM7aI8brddEOIuDfGyJXC4p9HBaVv2I69M9e7
         /9RBkbXbtOZJ0zDI2Ksn58ONVdAk8Isq0hvs1XnVorOh7ssw4ZHGhxoJosptzK49M+aX
         4OpeTUR284ZunNjBx6nrDrsEFEeD7HExJfMeanQeN50SBuakGVQvdxB3EB8CbsthgRoY
         tLiQ==
X-Gm-Message-State: ALKqPwcE89HsRgl25huY0BxCMZ6gXBtGoHW6srt5Pki3rcKOaYfx2+PS
        0QeaUtLnOT0yIvnLGaZamBAvwA==
X-Google-Smtp-Source: AB8JxZp3r7KerCjornGmCbwQ0RDEuTQxoxHH+/DHidAIOiOg0swcasD1ejWIuvKJvGwp5TBxWZkj0g==
X-Received: by 2002:a24:79d6:: with SMTP id z205-v6mr6408848itc.91.1526643063606;
        Fri, 18 May 2018 04:31:03 -0700 (PDT)
Received: from ?IPv6:2607:fea8:4da0:8ef:7088:aff6:8a95:3ce6? ([2607:fea8:4da0:8ef:7088:aff6:8a95:3ce6])
        by smtp.gmail.com with ESMTPSA id q6-v6sm5107592ita.44.2018.05.18.04.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 04:31:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: Add option to git to ignore binary files unless force added
From:   Anmol Sethi <me@anmol.io>
In-Reply-To: <002a01d3eddb$cdd3d8f0$697b8ad0$@nexbridge.com>
Date:   Fri, 18 May 2018 07:31:02 -0400
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE668F59-95D7-48AB-AD3B-A37AE404B368@anmol.io>
References: <285692D0-1DE8-4CAF-9BCE-F1A04D5C66B5@anmol.io>
 <CA+P7+xqQZzTrm274rbbP_O85Y+YGZ4PQ8PMFJnJtKR4wR0AObQ@mail.gmail.com>
 <002a01d3eddb$cdd3d8f0$697b8ad0$@nexbridge.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That works but most binaries do not have a file extension. Its just not =
standard on linux.

> On May 17, 2018, at 8:37 AM, Randall S. Becker =
<rsbecker@nexbridge.com> wrote:
>=20
> On May 16, 2018 11:18 PM, Jacob Keller
>> On Wed, May 16, 2018 at 5:45 PM, Anmol Sethi <me@anmol.io> wrote:
>>> I think it=E2=80=99d be great to have an option to have git ignore =
binary files. My
>> repositories are always source only, committing a binary is always a =
mistake.
>> At the moment, I have to configure the .gitignore to ignore every =
binary file
>> and that gets tedious. Having git ignore all binary files would be =
great.
>>>=20
>>> This could be achieved via an option in .gitconfig or maybe a =
special line in
>> .gitignore.
>>>=20
>>> I just want to never accidentally commit a binary again.
>>=20
>> I believe you can do a couple things. There should be a hook which =
you can
>> modify to validate that there are no binary files on pre-commit[1], =
or pre-
>> push[2] to verify that you never push commits with binaries in them.
>>=20
>> You could also implement the update hook on the server if you control =
it, to
>> allow it to block pushes which contain binary files.
>=20
> What about configuring ${HOME}/.config/git/ignore instead (described =
at https://git-scm.com/docs/gitignore). Inside, put:
>=20
> *.o
> *.exe
> *.bin
> *.dat
> Etc....
>=20
> Cheers,
> Randall
>=20
>=20

--=20
Best,
Anmol

