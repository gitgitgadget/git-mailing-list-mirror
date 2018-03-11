Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5931F404
	for <e@80x24.org>; Sun, 11 Mar 2018 20:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbeCKUxg (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 16:53:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39221 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932209AbeCKUxf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 16:53:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id r66so6122897wrb.6
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 13:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fZZ9notCeAaBR2qlavK8cWOryWdcXrOpcGTgOiH+A/Q=;
        b=pFI8hOLT3m+MNRoPNA6vmC4cP8y8WQmN/z5f7XZzC8+gVaEJiar1NvJTlpmaVC2Ehu
         NHoKSRIXrdNDv9DmWj2Y8OcYdVqhX+0tXLrM+eoqpiuORbpA5/GSnkukPmAvjhcflQyn
         t4ZNjYbrpxGi8URKbboIdR4dfB/Zh2gOGGoqf7h3hBuUrKmJIp/6EjQEIUeZUnyRdKrd
         oV1QLCpw6eQWMkM2nb3cWY0vdpXvAj5wOfW7K9CAb7ukzVJV4T0oLgIyxgnV2ZI29DJs
         QO+wPCjxV0irSUFijfmkGr0qbIPDnOC8qrnP3Ba51Jx//Sd34AUe3YckC38YUoa+DmPt
         RfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fZZ9notCeAaBR2qlavK8cWOryWdcXrOpcGTgOiH+A/Q=;
        b=TCqkgq9xCk+nQzK8erN0W/EFYgXvR/m0vvnH0U3XbZ491Hvpl8WO3FYA9GkjSi3Ln2
         ApkJvwtiFAXGA9FVvDpwbuIFQEsimDyS5hTcHyTgzI1XbO/ug+/f0/+Z3ggQmpG04F00
         kYiSwYvqVmsV72S8HBTxovm12r7hZaAR6rHelDHQtCiiNKWKZEJ9OCRs2xfXvHot7qHs
         3WJJpz2CNoazzKTrx42E4XbDN37ulVfLAulaw5AoqHQLcdzZZ1h+ggRsVih8UF861oiC
         1FHNF+ThlFy3amrKZaE41KNYKSNiMN07AwBf4l93xhPDM/JIGmQn616ZKSsc2WNNFLpc
         EqVw==
X-Gm-Message-State: AElRT7F/ilWOWV16d6ndE+YqTNBOudX/CJhtZacGBrRGIhaUSx3R8BWr
        hOYom2EiHTIn3S9xMoXoCzGJ2r1umwo=
X-Google-Smtp-Source: AG47ELtKTksEhnKmNrYpC8HUjancsHRFLpXKQhifDxZVTg9y090PR+UtQKenpCo41Vvd0xUpr3lafw==
X-Received: by 10.223.189.1 with SMTP id j1mr4751500wrh.174.1520801614427;
        Sun, 11 Mar 2018 13:53:34 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id g52sm10141983wra.20.2018.03.11.13.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Mar 2018 13:53:33 -0700 (PDT)
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87vae8yq15.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
 <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com>
 <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com>
 <d29d3c0e-6473-0461-c8ea-02975ce4de14@gmail.com>
 <nycvar.QRO.7.76.6.1803111644380.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <6362804d-e204-a9e0-9ff0-51d8497ce921@gmail.com>
Date:   Sun, 11 Mar 2018 21:53:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803111644380.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 11/03/2018 16:47, Johannes Schindelin wrote:
> 
> > > > Phillip's method is essentially merging the new tips into the original
> > > > merge, pretending that the new tips were not rebased but merged into
> > > > upstream.
> > >
> > > [...]
> > >
> > > Here`s a starting point, two commits A and B, merged into M:
> > >
> > > (3) ---A
> > >         \
> > >          M
> > >         /
> > >     ---B
> > >
> > >
> > > According the "patch theory"[1] (which might not be too popular 
> > > around here, but should serve the purpose for what I`m trying to 
> > > explain), each merge commit can be "transformed" to two non-merge 
> > > commits, one on top of each of the merge parents, where new commit 
> > > brings its original merge parent commit tree to the state of the 
> > > merge commit tree:
> > >
> > > (4) ---A---U1
> > >
> > >
> > >
> > >     ---B---U2
> > >
> > >
> > > Now, we have two new commits, U1 and U2, each having the same tree as 
> > > previous merge commit M, but representing changes in regards to 
> > > specific parents - and this is essentially what Sergey`s original 
> > > approach was using (whether he knew it, or not).
> > >
> > > When it comes to rebasing, it`s pretty simple, too. As this:
> > >
> > > (5) ---X1---o---o---o---o---o---X2 (master)
> > >        |\
> > >        | A1---A2---A3
> > >        |             \
> > >        |              M
> > >        |             /
> > >        \-B1---B2---B3
> > >
> > > ... actually equals this:
> > >
> > > (6) ---X1---o---o---o---o---o---X2 (master)
> > >        |\
> > >        | A1---A2---A3---U1
> > >        |
> > >        |
> > >        |
> > >        \-B1---B2---B3---U2
> > >
> > > ... where trees of M, U1 and U2 are same, and we can use the regular 
> > > rebase semantics and rebase it to this:
> > >
> > > (7) ---X1---o---o---o---o---o---X2 (master)
> > >                                 |\
> > >                                 | A1'--A2'--A3'--U1'
> > >                                 |
> > >                                 |
> > >                                 |
> > >                                 \-B1'--B2'--B3'--U2'
> > >
> > > ... which is essentially this again:
> > >
> > > (8) ---X1---o---o---o---o---o---X2 (master)
> > >                                 |\
> > >                                 | A1'--A2'--A3'
> > >                                 |            \
> > >                                 |             M'
> > >                                 |            /
> > >                                 \-B1'--B2'--B3'
> > >
> >
> > Having explained all this, I realized this is the same "essentially 
> > merging the new tips into the original pretending that the new tips 
> > were not rebased but merged into upstream" as Phillip`s one, just 
> > that we have additional temporary commits U1 and U2 (as per mentioned 
> > "patch theory") :)
> 
> But if the old tips had been merged into upstream (resulting in the new
> tips), then the merge bases would be *the old tips*.

Exactly, and that is what part you`ve cut out of the quote was 
showing :) By Phillip`s implementation, we would start with *old tips* 
as merge bases, indeed (old tips being U1 and U2 in this case), where 
it further gets transformed as previously written:

> 	git merge-recursive U1 -- M U1'
> 	tree="$(git write-tree)"
> 	git merge-recursive U2 -- $tree U2'
> 	tree="$(git write-tree)"
> 
> ..., where we know U1 = U2 = M (in regards to trees), so this is the 
> same as:
> 
> 	git merge-recursive M -- M U1'
> 	tree="$(git write-tree)"
> 	git merge-recursive M -- $tree U2'
> 	tree="$(git write-tree)"

Here, `git merge-recursive M -- M U1'` simply equals to U1' tree 
(being a fast-forward merge), so we can write the two merges above as
a single merge, too:

> 	git merge-recursive M -- U1' U2'
> 	tree="$(git write-tree)"
> 
> ... which is exactly what Sergey`s (updated) approach suggests, 
> merging U1' and U2' with M as merge-base (and shown inside that 
> sample implementation script I provided[1]) :)

So from *old tips* being the rebased merge base (Phillip), we got to 
*old merge commit* being the rebased merge base (Sergey), or vice 
versa. Does this shed a bit more light on it now? Or you wanted to 
point out something else in the first place...?

> I am still not sure for what scenarios Phillip's strategy is the same as
> Sergey's (updated) one, as the former strategy can do completely without
> temporary commits [...]

I think the root of misunderstanding might be coming from the fact 
that Sergey was mainly describing a general concept (without a 
strictly defined implementation strategy, not being restricted to a 
specific one), where Phillip came up with a solution that eventually 
seems to use the same concept (as those transformations above should 
show), but simplifying it further inside a concrete implementation.

By saying that Phillip "simplified it", even though transformations 
shown above might show different, I mean he managed to further 
decompose what Sergey was aiming for, abstracting temporary commits U1 
and U2 out of the equation, thus making them optional, but not 
required.

So, if easier to implement and reason about, I think what Phillip 
described is a way to go to produce the rebased merged commit - but 
in case we want to have that "clean rebased merge" check that U1' == 
U2' comparison does provide, as they should really be the same (tree 
wise) in simple (and the most used?) merge rebasing, we can do that 
after the fact, even.

Might be this check could be the most useful in non-interactive 
rebases, where rebased merge parents` trees could be expected to stay 
"balanced" more often (U1' == U2'), without interactive fiddling to 
"disbalance" them. I don`t know, just thinking out loud.

> [...] and cannot introduce ambiguities when rebasing the
> changes introduced by M (i.e. the "amendmendts" we talked about).

Hmm, not following here, which ambiguities are we talking about?

Thanks, Buga
