Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1571F406
	for <e@80x24.org>; Mon, 18 Dec 2017 10:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758270AbdLRKyf (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 05:54:35 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36068 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbdLRKyd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 05:54:33 -0500
Received: by mail-wr0-f193.google.com with SMTP id u19so7246357wrc.3
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 02:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BRf5wMvHP1Xn6zSGGjVaPPJ9nCYgLoMWqgRtJdnCX9s=;
        b=NdG0liQz3o3sNwmUa9PHjtWrAUWR8AlyZ8r+R3XyTF/83KIYdRcOBkYK5Ino9LAIJV
         O/UGRn4a87JOxRdnqdLNSSOMFPevbkaLP1He7NOdAHirWACT33n4BGPAnFI5R20EBVpm
         X4YabeRrZ0Gkf5BkSwDwZOxH5/99aiuzzI7ZE5FkJMyik5Ts/r4c9951EktKqGQDM1Uc
         cPwMIuiADkmDClk/w6aAXdbWuMhbxY0GpbTStU53vWqPpgUP2Bl1jVBFu3DvZFxV2xaa
         78wqkrkYl8ngLCw1IgNS0r2NurAr/UDY6soI2ffZjO3wLNtiZN4gYKoEk7qNYbOqbXvm
         2Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BRf5wMvHP1Xn6zSGGjVaPPJ9nCYgLoMWqgRtJdnCX9s=;
        b=OOdT+P4boDRN1CxQfFgyWv90MIRR96yjVR+9tcocCktTqHF89YLRLLdOobaX/Vn14Z
         5t45pxvjRqOqOTHA7BV8vO/Wm0HZhvXfsUV/fdfoG+WnZi/87M/Uu8K+LTqodZJfN6DQ
         ssJo980GQ4pOc0U+0IfaCyixmsmLV52J3tbYbBcSgFTc9rqcP+Hq9lYt91H6AWV9GI0t
         YnaI1tGwIrBQocRqi87umZ7R2k0yT4o4g4CZLke+wUgEb67qr0Dkge0eSAoH4/F9GHOs
         bLm3e76uwYnMJ0rDl6fbejbDaiInMr78DwPkjIljWHXchOf7moMDLuB06lQfsllMczGm
         A5Iw==
X-Gm-Message-State: AKGB3mItgQfkn+ltKUjgMVKoljLGFkmZ2oxC4wGIclWlHopyPL98h/hO
        eJnHC4mE2t+T83GT7GKHFDzYsuKQ
X-Google-Smtp-Source: ACJfBos3HSUQf4oXOFAHXwdF+88Iz2WcAe+bONBbO43XmgEWahn5ds7KrV3AtoJSOoWpy9ExzCPVBw==
X-Received: by 10.223.176.52 with SMTP id f49mr4044766wra.105.1513594472533;
        Mon, 18 Dec 2017 02:54:32 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id o10sm8447260wrg.5.2017.12.18.02.54.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 02:54:31 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171215095838.GA3567@sigill.intra.peff.net>
Date:   Mon, 18 Dec 2017 11:54:32 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, tboegi@web.de, patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1E22F0E-EC10-4133-9177-AE20F398A8AC@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com> <20171215095838.GA3567@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Dec 2017, at 10:58, Jeff King <peff@peff.net> wrote:
>=20
> On Mon, Dec 11, 2017 at 04:50:23PM +0100, lars.schneider@autodesk.com =
wrote:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Git and its tools (e.g. git diff) expect all text files in UTF-8
>> encoding. Git will happily accept content in all other encodings, =
too,
>> but it might not be able to process the text (e.g. viewing diffs or
>> changing line endings).
>>=20
>> Add an attribute to tell Git what encoding the user has defined for a
>> given file. If the content is added to the index, then Git converts =
the
>> content to a canonical UTF-8 representation. On checkout Git will
>> reverse the conversion.
>=20
> This made me wonder what happens when you have a file that _was_ =
utf16,
> and then you later convert it to utf8 and add a .gitattributes entry.
>=20
> I tried this with your patch:
>=20
>  git init repo
>  cd repo
>=20
>  echo foo | iconv -t utf16 >file
>  git add file
>  git commit -m utf16
>=20
>  echo 'file encoding=3Dutf16' >.gitattributes
>  touch file ;# make it stat-dirty
>  git commit -m convert
>=20
>  git checkout HEAD^
>=20
> That works OK, because we try to read the attributes from the
> destination tree for a checkout. If you do this:
>=20
>  echo 'file encoding=3Dutf16' >.git/info/attributes
>  git checkout HEAD^
>=20
> then we get:
>=20
>  warning: failed to encode 'file' from utf-8 to utf16
>=20
> At least it figured out that it couldn't convert the content. It's
> slightly troubling that it would try in the first place, though; are
> there encoding pairs where we might accidentally generate nonsense?

At this point we interpret utf-16 content as utf-8 and try to convert
it to utf-16. That of course fails because utf-16 content is no valid
utf-8. How could we stop trying that? How could Git possibly know what
kind of encoding is used (apart from our new hint in gitattributes)?

I asked myself the question about nonsense encoding pairs, too. That
was the reason I added the "X -> UTF-8 -> Y && X =3D=3D Y" check on Git
add. However, with ".git/info/attributes" you could circumvent that
check and probably generate nonsense.


> It _should_ be uncommon, I think, to have a repo-level attribute set
> like that. It's very common for us to use whatever happens to be in =
the
> checked-out .gitattributes for some attributes (e.g., when doing a =
diff
> of an older commit), but I think for checkout-related ones it's not.  =
So
> I think it may generally work in practice. And certainly the =
line-ending
> code would share any similar problems, but at least there the result =
is
> less confusing than mojibake.
>=20
> Playing around, I also managed to do this:
>=20
>  echo 'file encoding=3Dutf16' >.gitattributes
>  echo foo >file
>=20
>  # I did these with an old version of git that didn't
>  # support the new attribute, so they blindly added the utf8 content.
>  git add .
>  git commit -m convert
>=20
>  git.compile checkout HEAD^
>=20
> which yielded:
>=20
>  fatal: encoding 'file' from utf16 to utf-8 and back is not the same
>=20
> Now obviously my situation is somewhat nonsense. I was trying to force
> the in-repo representation to utf8, but ended up with a mismatched
> working tree file. But what's somewhat troubling is that I couldn't
> checkout _away_ from that state due to the die() in convert_to_git().
> Which is in turn just there as part of refresh_index().
>=20
> And indeed, other commands hit the same problem:
>=20
>  $ git.compile diff
>  fatal: encoding 'file' from utf16 to utf-8 and back is not the same
>=20
>  $ git.compile checkout -f
>  fatal: encoding 'file' from utf16 to utf-8 and back is not the same
>=20
> It may make sense to die() during "git add ." (since we're actually
> changing the index entry, and we don't want to put nonsense into a
> tree). But I'm not sure it's the best thing for operations which just
> want to read the content. For them, perhaps it would be more =
appropriate
> to issue a warning and return the untouched content.

Absolutely! Thanks for spotting this. I will try to run die() only on
"git add" in v2.

- Lars=
