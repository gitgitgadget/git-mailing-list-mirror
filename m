Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18A181F453
	for <e@80x24.org>; Sun,  4 Nov 2018 16:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbeKEBwy (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 20:52:54 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:33995 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbeKEBwy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 20:52:54 -0500
Received: by mail-it1-f169.google.com with SMTP id t189-v6so5674861itf.1
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nPfvV/Df15qj0buglRhLeGYZvptdXpZ6JbzJ4VuO920=;
        b=eaNsBnLd7DVYJFZjsRk80cZP38FQNOKuhx9oKFVwFwKwm2WvOgkChStPvRodDN1v06
         hK0MTRJTcOa6IELwZSwU1r2hw6UjmsSkINg1VZh/U5dxfTxzyrUKT/fEt40tgyJ1WMDt
         9OSRpoWcmrpXjHO2l6Fu8RLWxmxHhpguPLMuXSS+1oUqWXR+ay4bwGJ7v8p1fy2PwrdK
         +SE2C82tZDw/Pidp93w/nEPhgiXXryuyaP01WXep0zsr0PXujmxdxG3oprG+vqPjpjjd
         LO4oWI3OrCWQzKE10tMBonOfJiauDIdCYGTrJ1MbDxsJYtUQ/m0NI3/rAgCE25EEjrsZ
         MyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=nPfvV/Df15qj0buglRhLeGYZvptdXpZ6JbzJ4VuO920=;
        b=egI2n0lxDJpskvyv4SIMj0xAm7ymi8H1oqJZGaFdyfPs5O8R5o5BaVt9MSfZgH05K7
         H0Vel3Ox+ZaGrp3RJVjjgvSbhUcjdTewTF1SRiDQV2WSx6Z8NPhjvUtTx676b5Bk+IkX
         ItLES0w/t+E6MiB4CZn9BNbIY07tZ8Vb5A6e713PWEBSDg6xhoIHv/5PS+q9N3ysqZb3
         6BATNgVE1X9vLsDHX+uJY8aVIjqeWMBDEtqy9BXr3VIY8N0lGAlfrMA384bmvmjTPfIP
         72Nbic1m80zfee0qrL0nUE5iJf1zxdWnEXxOgCKv5HUBDNd+8fxjdO3nAzFUkzU/mXmp
         vZrQ==
X-Gm-Message-State: AGRZ1gIlJroFYvFooY+RdWxscfEPHbET3mt4dtUVpS+EsOQ+swB7Rct+
        LLqhWhbPoe4o42+IGfkxOQ0ZS5QhYwaz6kcAXq13UK0L
X-Google-Smtp-Source: AJdET5fcb3IAYi7l7RgxXYvNeuX68wv/bs1Ai55xND7rhXyexkGNnqQyRQMroWmoEKLWUhHgwuhG1J/x67uIKFxeoI4=
X-Received: by 2002:a24:bcc1:: with SMTP id n184-v6mr4133408ite.174.1541349441726;
 Sun, 04 Nov 2018 08:37:21 -0800 (PST)
MIME-Version: 1.0
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20181104154744.GI731755@genre.crustytoothpaste.net>
In-Reply-To: <20181104154744.GI731755@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Adri=C3=A1n_Gimeno_Balaguer?= <adrigibal@gmail.com>
Date:   Sun, 4 Nov 2018 17:37:09 +0100
Message-ID: <CADN+U_Nw5wCyK1SPRgsxzFbJ-KKnOV2Ub8YA3_a80SZYwKC5FQ@mail.gmail.com>
Subject: Re: git-rebase is ignoring working-tree-encoding
To:     sandals@crustytoothpaste.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El dom., 4 nov. 2018 a las 16:48, brian m. carlson
(<sandals@crustytoothpaste.net>) escribi=C3=B3:
> Do things work for you if you write this as "UTF-16LE"?  When you use
> working-tree-encoding, the file is stored internally as UTF-8, but it's
> serialized to the specified encoding when written out.

When I use UTF-16LE or UTF-16BE, then I can't commit or view diffs of
specified files, as Git prohibites BOM existance in these cases,
showing an error when attempting to commit. But BOM must also exist
for the project. I even experimented for fixing this issue within
Git's source. It turns out that Git is following an Unicode rule that
says that BOM is not permitted when declaring exact UTF-16BE/UTF-16LE
MIME (and UTF-32 variants) encoding types:

https://github.com/git/git/blob/master/utf8.h#L87

> Asking for "UTF-16" is ambiguous: there are two endiannesses, and so as
> long as you get a BOM in the output, either one is an acceptable option.
> Which one you get is dependent on what the underlying code thinks is the
> default, and traditionally for Unix systems and Unix tools that's been
> big-endian.  If you want a particular endianness, you should specify it.

I wrote a "counterpart" easy fix which instead only prohibites BOM for
the opposite endianness (for example if
working-tree-encoding=3DUTF-16LE, then finding an UTF-16BE BOM in the
file would cause Git to signal the error right before committing,
diffing, etc.). That way user would be encouraged to modify the file's
encoding to match the one specified in working-tree-encoding before
allowing these actions, therefore preventing Git from encoding to the
wrong endianness after file is written out. With few repository tests,
this new behaviour worked as expected. But then I realized this
solution would perhaps be unacceptable for Git's source code as it
would violate that Unicode standard. Anyways, here is a PR in my Git
fork with the changes I did, for reference:

https://github.com/AdRiAnIlloO/git/pull/1

Ah this point, the solution I came with recently for my project was
writing some code in Shell to fix the endianness of the re-encoded
files to UTF-16BE after the Git's write out process (or a "working
tree refresh" in my own words), within the same script that I use to
pack assets including the localization files.

> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



--=20
Adri=C3=A1n
