Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2711F45F
	for <e@80x24.org>; Mon,  6 May 2019 04:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbfEFEcw (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 00:32:52 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:33984 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfEFEcw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 00:32:52 -0400
Received: by mail-ed1-f51.google.com with SMTP id w35so12095513edd.1
        for <git@vger.kernel.org>; Sun, 05 May 2019 21:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3cGrBSnxhevWHfSLqi/fFmSSn1Dcrkv16bNaWz4lAy0=;
        b=Y84qYZ21dmYZkY7ZVbG4MeLlEgIx6JEEZJtzRuXockuVM09jN2hZNjji47O7lbdAVU
         2HtNZGFOEKZdSrT9eh0Y3aSbN2O9aUJVDEy5u+pUNE74vpQM0zCNqFC1dXk4fe2qVZp5
         Fg/TJhujIXf2iKsRdE+LEdNPaiuOr0+4mDG7lU6q0a4ZL1e0tY4YAVvQjdBEDbnhvs0B
         zcfzPYvDhvEE7iTZcLiu17z6y7fQsh9At5zNXWSC85YO3boWUl+YEmKJBmGBUS7+otIV
         w1ldlA/0RW8nRt0KdVuX3QWRwLTmF6gOoxSkJE0iD9fD282WBJph7W14CGEOiOvMRmlG
         Jr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=3cGrBSnxhevWHfSLqi/fFmSSn1Dcrkv16bNaWz4lAy0=;
        b=E2Jxvjo0hsHtUdcbirPOZR2ZaPoMFvTl5GeCtkZfa5nOmbouzQnfirBOvKrX/4rWUu
         blGCOQgtsUeEujKN+fokT72S/Rb+o1Kjoo/t0LfjnvFGKVbt98tCLg3cqPna4Rx+HsQY
         WVKDlkYx0b6Ub1k21HrQCxCZR+e7Z9lDWej5O3V2lfweUj6+xEybq+wBYKGupWuecca7
         tBRsxpkGoKeIjE4TUg/axe6ll1vCovgOHIr2wVlt3qjJE36ZPYK5YF0tudpjGCqE8WR0
         zY3IlSYLGvY1V+kVR99Sz/+UY7TtXRmVLvwnfFIByBpJLDlCgAkFPguauSlh2hDOX7kl
         QJMw==
X-Gm-Message-State: APjAAAUtKh050PquRppTmVHreIzG2OW61w6l3NmZ22zUfU7aadTgBNGf
        2nvbtKMCEP/Frt37pkMnkR0UBq4EqugKZK+5pFw=
X-Google-Smtp-Source: APXvYqzjlpMRnzWSrxFE5ehapMurHTHOd7LdQmxRZISBInRRu6BmJ0JqQamnETN7Z0gze8b8oSPgiUzJPXvU+0QCmrI=
X-Received: by 2002:a17:906:8318:: with SMTP id j24mr17079079ejx.199.1557117170517;
 Sun, 05 May 2019 21:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-aa2c53fa-25e5-49df-83f9-68f310683943-1557052051546@3c-app-gmx-bs61>
 <20190505181444.GA7458@genre.crustytoothpaste.net>
In-Reply-To: <20190505181444.GA7458@genre.crustytoothpaste.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 5 May 2019 21:32:41 -0700
Message-ID: <CA+P7+xraNUBN_UjN+fL0vfTEzpHmNYUj5f=YLUF9etxo79zEPw@mail.gmail.com>
Subject: Re: git has issues with international characters in branch names
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ax Da <discussion@gmx.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 5, 2019 at 11:16 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Sun, May 05, 2019 at 12:27:31PM +0200, Ax Da wrote:
> > The documentation doesn't seem to be clear about which characters are a=
llowed as branch names.
> >
> > We have been using umlauts and apostrophes in our branch names, and bot=
h are having issues:
> >
> > - apostrophe:
> >   git removes the apostrophes from the branch name when creating/pushin=
g a branch.
> >   In our TFS server repository we're having the same branch name twice:=
 Once with apostrophes,
> >   and once without. And I don't seem to be able to delete the one witho=
ut apostrophes.
> >
> > - umlauts:
> >   The umlauts are not correctly interpreted when SMB is used. "gem=C3=
=A4ss" becomes "gem<C3><A4>ss".
> >   (See images attached.)
>
> I don't think Git itself has a problem with Unicode. I literally just
> the other day created a branch with a Unicode apostrophe and pushed it
> to GitHub successfully using macOS. It is possible that TFS doesn't like
> them; that depends on the hosting solution you use. If you're seeing
> problems with TFS, I'd reach out to Microsoft for assistance.
>
> It looks also like the Git CMD interface isn't rendering them properly.
> I would try using Git Bash instead, and if that doesn't work, please
> report that to Git for Windows. The folks there will have a better idea
> about the portability issue that's occurring; I expect there's a wart
> there somewhere between UTF-8 and UTF-16. It may also be that SMB is not
> a good choice for sharing repositories if you require
> internationalization, or you may need to change the character set your
> SMB server uses.

In my experience, the regular command prompt will have significant
troubles displaying UTF-8 characters.

I had better luck in Git Bash, but I don't recall if I had to do
something for it.

Thanks,
Jake

>
> You may also, depending on which version of Windows you are using, have
> better luck at the command line with Windows Subsystem for Linux.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
