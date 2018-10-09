Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 014A81F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 20:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJJDlC (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 23:41:02 -0400
Received: from mail.weplayciv.com ([162.221.200.53]:36820 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeJJDlB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 23:41:01 -0400
Received: from [192.168.0.105] (c-3985e555.02-149-6c6b7013.bbcust.telenor.se [85.229.133.57])
        by mail.weplayciv.com (Postfix) with ESMTPSA id BF57194476D;
        Tue,  9 Oct 2018 13:22:19 -0700 (PDT)
Subject: Re: [PATCH 1/2] branch: introduce --current display option
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
References: <20181009183114.16477-1-daniels@umanovskis.se>
 <CAGZ79kaxsbAt7Oa74kNbG0e6vja3H87Za=XZOpPZCv=Oq-03yA@mail.gmail.com>
From:   Daniels Umanovskis <daniels@umanovskis.se>
Openpgp: preference=signencrypt
Autocrypt: addr=daniels@umanovskis.se; prefer-encrypt=mutual; keydata=
 xsBNBFKoLuABCADTUslhPOYPDA+TmmmJr7l5Ybrp7dUTs9A8O6Vkd3ucNeZQue+3lS3/VJwG
 ZPJprysTdFEeZkJWEleO9rYNe4l4EciaqaRjXRR9r95qEqgf7tc37RU003VNxkuvJnweKypJ
 5G247dy6Z3ORMKw8usX4uO+tsxsZqXprgSJJyU1QPMMT9oc5Qyec9ny5GdhRCIbwhVI9y6Q4
 RPpI4Czh9s1Mau0V0Yf9eOoW2zPlD8R67AUZ+myR6Eg9T71STAdYYEy9+EA/G27kc8J+yB43
 NQZ9sAFbMdundbISUoAALxqzC672u83YoTsHdFEzztz76PkY7KpDKH8Kd4Qzr0NZSHAzABEB
 AAHNKkRhbmllbHMgVW1hbm92c2tpcyA8ZGFuaWVsc0B1bWFub3Zza2lzLnNlPsLAeAQTAQIA
 IgUCUqgu4AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQUfamH/05PVqFzgf/Xf0y
 Kx6kovYltkRZovLL+YNQ8ung4dCleC4MHegkscndLX3zgIu7VgqniLWjEnkFA5g/MaKwzKir
 YR9pvb5WlEXjK/Rh1LY+W7laBuGwJHXoPTHb843OGAuGoxbyRXiylsICx95/W0m9UZea/8xM
 6kmIEh1cD+g0Pd7VkCUm7SnOQSEHSnqvsspsGpFe4GuB+8X8dVOCa/4IRMwDSj5JDwX4gmlH
 DF1k4+gqvEzBgNX+ayA+uME0BN1PJ4u/iqo680F5DQGTOBXZCug+nlxYb7gJQXhFVlvdG5uh
 TypRTzCvC/aPAcULaHoCz9M6hwJgvoO/IK4uvEXY7P+qN7Xxtc7ATQRSqC7gAQgA4+8pYlGe
 1s7CFYl2OaHLLeupVpXd6eDMhi4NDKA/0Qnr/VnuF/VaPQ79KEiNDl1HMV1yoXzuQsdvfeQc
 DsnchnJI/YhlSF6m67jG5PQtkcrGqEB87f0JQ1mcgwpJCQx4EzvMlHbg6O9k0vIsP3O8+v7h
 +a8n78gKVUm/nMqIT939eqxtmccfIbiE/KKbigiOwUpiOrUAk8TR4dZ8U2YtIU5WnWhGIJeK
 fzLLHO2Gb5uk4toQBq4fEUW4I6Ar8blHmo1vHvG+gWWKeZA0n2sxjqGpfnGNZNyd4fkh728F
 reiGd2lWA/vB4m9Oh9auOKIOFdgUlDgSK2TvuALrzUmUbQARAQABwsBfBBgBAgAJBQJSqC7g
 AhsMAAoJEFH2ph/9OT1aC/sH/2JWo3MEK7/gpIfAFgqBsxWAeggbiBnu06NTc7u5G2q2znzN
 MhWlHEr8tOtPwV/6IxoZsHEdyUxBvM90vtmRnYoDL0S/xiwlimUuA+GxPFEN67HjEik3NJQU
 in36Q69hT3HyzG4pyWB2Uk6cx6D+4tMdSCHcO5wxjFPIFHL7/2YLpUfLWHXVdtxT6/2Roo+G
 +Wx2BSEgXqGR2i0HLZUqU0Oz/BHxLTtef+dUAWu0FmByPChoN92+0CLWEm/s5mBaCsMHd76v
 NIofCYEIBFTeTe2hKuBv4D5UtZNCz7MucSzG1tIOWg+vifpLm69WNfXhvpiZ8GDCLeL2Bs09
 msVfFOM=
Message-ID: <18720b32-992b-7665-7df4-6cf8659a7b31@umanovskis.se>
Date:   Tue, 9 Oct 2018 22:21:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaxsbAt7Oa74kNbG0e6vja3H87Za=XZOpPZCv=Oq-03yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback!

On 10/9/18 9:54 PM, Stefan Beller wrote:
> How does it play with worktrees? (I would expect it to just work as expected:
> each worktree would print its current branch, but a test might help?)

I'll see about writing a test for that. I've never used git-worktree so
this is a good chance to learn.

> Git used to have (and still has) the approach of dividing its commands
> into high level ("porcelain") commands and low level ("plumbing") commands,
> with the porcelain facing the user and plumbing being good for scripting.
> 
> This patch proposes a radically different approach, which is convenience
> of use.

Right - a couple of points in response. First, it strikes me that "print
current branch" is one of those things that are both for scripting and
for normal/interactive use. Much like the entirety of git-status, which
is very used by itself, and also in scripts with --porcelain. Current
branch is often used in things like your shell prompt, vim statusline,
etc, as well as scripts.

The amount of upvotes on the stackoverflow question "how to get the
current branch name in git?" illustrates my point :)

Second, it seems arguable whether `git ref-parse` is guaranteed to be
scripting-safe, it's not actually a plumbing command, at least if we
trust the main git manpage, which lists git-rev-parse as porcelain anyway.

> Why do we need to add the shortname to a strbuf?
> (and using _( ) that denotes the string should be translated?)
> I would think we could just
> 
>     puts(shortname)
> 
> here and leave out all the strbuf out ?
> 
Of course, has to be changed for v2. Pitfalls of learning the code from
just its surroundings, didn't realize that the underscores are for i18n.
