Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339BB20964
	for <e@80x24.org>; Tue,  4 Apr 2017 21:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbdDDVNV (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 17:13:21 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32903 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752352AbdDDVNU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 17:13:20 -0400
Received: by mail-io0-f196.google.com with SMTP id f84so16225098ioj.0
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 14:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P6hox2PJo76yO57IZNQZq9ambE4gYlKImriRgOc5fzE=;
        b=C3byr4KMLHKs96xUZqRKDZMUAcb5M0mYAH0KxdKohLuHaMYmJ1cmzpv7rggdMtNsVl
         Fp1kABAP4ZkDtTfmoeVGf3jO/ZxhnImrGTffbxPLPl7CecHrd/UVL7vKsK9sP73hmtcK
         ivU4zWNiBUeAD9ljnCk+LV1kl5LKfDT9ZL11OkfV993Z/zPBYgCgB1Gd9YpbhmWfaLxz
         KFa2cKw9u52uo6xjofugZSIRpnUQD4D0qnE1pAKoyijnxuh0bBGGe9eM2dNvKoy+EDGU
         1uYVtV2K+wzbMHuLE6sh3UxrqfFxzi3mJ7u+gQZwyoN8asETU2h290vkqiRk2/U072gk
         rn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P6hox2PJo76yO57IZNQZq9ambE4gYlKImriRgOc5fzE=;
        b=qksoiIR2BHY3Si9rOQ1O/PnCsz7juLomrRqRSdjwJSXp6JoJMQXGFXdb8ZtAYMo+aL
         qvDdx3t2zySzOx9ohclY6L7SEugJ9G9Or1/knLz8hLpOeBOuvFIFeZZSvjtX/iGnVn1T
         GgrIPULRCXHEsvDeXtrMAOtA853dDiDR+VoqrUXs04Bq+ukNEZEsy/eJsTbU8DaZ5Khc
         sainZgLtsxppFLNqgnWXLPTR2TnlW4qTokw1K/SFS8PkOmcULYnW/NKGTHnmDW5ckKTt
         tdZwfbZUGxSV8JZcqVAjihUgy1r7QvIqagYygrsu6nIxPaT75lubxTNA8BD/E0d/fADe
         ZWOA==
X-Gm-Message-State: AFeK/H2ffKsY/fS0SAmNFVBxPMME0P8naWWRY6j55Tsy6tukYrZTq84DSWftgMr8WMTKdSnv7Azn9wZA0V69Ag==
X-Received: by 10.107.32.199 with SMTP id g190mr26552718iog.117.1491340399130;
 Tue, 04 Apr 2017 14:13:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 4 Apr 2017 14:12:58 -0700 (PDT)
In-Reply-To: <20170403223956.GA3537@whir>
References: <20170403211644.26814-1-avarab@gmail.com> <20170403213440.GA1409@whir>
 <CACBZZX7R5svNJ+Ak3LFh8+kY48i6V7Yo6JDS+PSDJCkZ5vHb6w@mail.gmail.com> <20170403223956.GA3537@whir>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 4 Apr 2017 23:12:58 +0200
Message-ID: <CACBZZX6qDUvbuOQ-tJ+enARJUcoUoipbapVxi4Lf=84xBCmbQw@mail.gmail.com>
Subject: Re: [PATCH/RFC] gitperformance: add new documentation about git
 performance tuning
To:     Eric Wong <e@80x24.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2017 at 12:39 AM, Eric Wong <e@80x24.org> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>> On Mon, Apr 3, 2017 at 11:34 PM, Eric Wong <e@80x24.org> wrote:
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>> >>  - Should we be covering good practices for your repo going forward t=
o
>> >>    maintain good performance? E.g. don't have some huge tree all in
>> >>    one directory (use subdirs), don't add binary (rather
>> >>    un-delta-able) content if you can help it etc.
>> >
>> > Yes, I think so.
>>
>> I'll try to write something up.
>>
>> > I think avoiding ever growing ChangeLog-type files should also
>> > be added to things to avoid.
>>
>> How were those bad specifically? They should delta quite well, it's
>> expensive to commit large files but no more because they're
>> ever-growing.
>
> It might be blame/annotate specifically, I was remembering this
> thread from a decade ago:
>
>   https://public-inbox.org/git/4aca3dc20712110933i636342fbifb15171d3e3caf=
b3@mail.gmail.com/T/

I did some basic testing on this, and I think advice about
ChangeLog-style files isn't worth including. On gcc.git blame on
ChangeLog still takes a few hundred MB of RAM, but finishes in about
2s on my machine. That gcc/fold-const.c file takes ~10s for me though,
but that thread seems to have resulted in some patches to git-blame.

Running this:

    parallel '/usr/bin/time -f %E git blame {} 2>&1 >/dev/null | tr
"\n" "\t" && git log --oneline {} | wc -l | tr "\n" "\t" && wc -l {} |
tr "\n" "\t" && echo {}' ::: $(git ls-files) | tee
/tmp/git-blame-times.txt

On git.git shows that the slowest blames are just files with either
lots of commits, or lots of lines, or some combination of the two. The
gcc.git repo has some more pathological cases, top 10 on that repo:

$ parallel '/usr/bin/time -f %E git blame {} 2>&1 >/dev/null | tr "\n"
"\t" && git log --oneline {} | wc -l | tr "\n" "\t" && wc -l {} | tr
"\n" "\t" && echo {}' ::: $(git ls-files|grep -e ^gcc/ -e
ChangeLog|grep -v '/.*/') | tee /tmp/gcc-blame-times.txt
$ sort -nr /tmp/gcc-blame-times.txt |head -n 10
0:18.12 1513    14517 gcc/tree.c        gcc/tree.c
0:17.35 66336   7435 gcc/ChangeLog      gcc/ChangeLog
0:16.87 1634    30455 gcc/dwarf2out.c   gcc/dwarf2out.c
0:16.76 1160    7937 gcc/varasm.c       gcc/varasm.c
0:16.36 1692    5491 gcc/tree.h gcc/tree.h
0:15.34 94      493 gcc/xcoffout.c      gcc/xcoffout.c
0:15.22 54      194 gcc/xcoffout.h      gcc/xcoffout.h
0:15.12 964     9224 gcc/reload1.c      gcc/reload1.c
0:14.90 1593    2202 gcc/toplev.c       gcc/toplev.c
0:14.66 11      43 gcc/typeclass.h      gcc/typeclass.h

Which makes it pretty clear that blame is slow where you'd expect, not
with files that are prepended or appended to.


>> One issue with e.g. storing logs (I keep my IRC logs in git) is that
>> if you're constantly committing large (text) files without repack your
>> .git grows by a *lot* in a very short amount of time until a very
>> expensive repack, so now I split my IRC logs by month.
>
> Yep, that too; as auto GC is triggered by the number of loose
> objects, not the size/packability of them.
