Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3C31FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 11:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbcLLLuf (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 06:50:35 -0500
Received: from tschil.ethgen.ch ([5.9.7.51]:45289 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbcLLLue (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 06:50:34 -0500
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <klaus@ethgen.de>)
        id 1cGP7n-0002lB-Kr
        for git@vger.kernel.org; Mon, 12 Dec 2016 12:50:31 +0100
Received: from klaus by ikki.ket with local (Exim 4.88)
        (envelope-from <klaus@ikki.ethgen.ch>)
        id 1cGP7m-0008Aa-VD
        for git@vger.kernel.org; Mon, 12 Dec 2016 12:50:30 +0100
Date:   Mon, 12 Dec 2016 12:50:30 +0100
From:   Klaus Ethgen <Klaus@Ethgen.ch>
To:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
Message-ID: <20161212115030.qx2y276bxnzbtxkj@ikki.ethgen.ch>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org>
 <20161210093230.26q7fxcrs2cpll6g@ikki.ethgen.ch>
 <alpine.DEB.2.20.1612101918040.23160@virtualbox>
 <20161211110208.642unp7c2i653sav@ikki.ethgen.ch>
 <alpine.DEB.2.20.1612121133220.23160@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
In-Reply-To: <alpine.DEB.2.20.1612121133220.23160@virtualbox>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi,

Am Mo den 12. Dez 2016 um 12:03 schrieb Johannes Schindelin:
> On Sun, 11 Dec 2016, Klaus Ethgen wrote:
> > Am Sa den 10. Dez 2016 um 19:18 schrieb Johannes Schindelin:
> > > On Sat, 10 Dec 2016, Klaus Ethgen wrote:
> > > > Am Fr den  9. Dez 2016 um 22:32 schrieb Johannes Sixt:
> > > > > There are too many systems out there that use a backslash in path names. I
> > > > > don't think it is wise to use it also as the quoting character.
> > > > Well, the minority, I believe. And only the minority where the command
> > > > line git is used anywhere.
> > > Please provide evidence for such bold assumptions.
> > How is it "bold" to see that the majority of widows users does not use
> > or even like command line tools.
> 
> First of all, it is "Windows users", not "widows users", unless, of
> course, you want to discuss things that are completely inappropriate for
> this list.

Sorry to have a typo in my response.

> Second, you still did not back up your claim with anything resembling
> evidence, instead just reiterating your beliefs. That is not good enough.

Well, my evidence is what I seen with many windows users in the past. I
have no link or something like that. I just shared that observation.

> Third, my experience contradicts your beliefs rather violently.

So we have two different observations. Good. Have no problem with that.

[...]
> Now let's look at your claim that Windows users do not use the
> command-line. The mere existence of posh-git (Powershell bindings for Git)
> is already a contradiction to that claim.

Is that the same git tools or is it a separate implementation?

[Proof of many downloads and other]

Proofs accepted. They do not match my observations but ok.

> Fourth, even if Windows users were the minority, and even if Windows users
> were not using the command-line, which are claims soundly refuted by the
> evidence I presented above, the fact alone that you are talking about
> putting a group of people at a disadvantage based merely on your belief
> that they are in a minority should not inform us, the Git developers, on
> any kind of policy decision.
> 
> We will not intentionally break Git usage, or make Git usage hard, for
> a specific group of Git users, unless there are technical reasons to
> do that. Demographic reasons do not count.

Sorry, but I was posting my answer to the comment of preferring not to
allow ":" in prefer of using "\" for quoting. I never wanted to attack
you. It was just a response... And I do not remember attacking you
personally to style me "bold".

Currently the source of that all was, that push to pathes with ":" did
break in the current version. I did not ask for implementing something
instead of something different. I just ask for fixing of a regression.

Moreover, as you might know, windows users are more affected by that bug
as they have a colon in every absolute path. Nevertheless I had that
problem on linux but with a map to a windows share.

For more, I have to agree with Philip, that this is a bit off topic. So
please stop taking single words on the personal level. Please stay on
the technical level. My english is to bad to go to personal level
discussions. And I don't want to spend time to personal or (as you
tried) feminism discussions.

Regards
   Klaus
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlhOjvwACgkQpnwKsYAZ
9qyb2wwAuUFTRrOQcJ6mDLx5bHPNrQy6e4ify4qWcfcp3VJhOLpA56CdJwwA2bcl
gcllUwOn+SSjjYaRmuFQ6aY0/oKDEtF98Zh01pXLnAgY+Dabg9gfBCMWyWv8LxUf
NWHADPpSkY2eongvm6aXOGTqNvU73wriuQKM6BwG49bJUpdR1q8Fe+DjtufrS8eW
ALeGoEFrbm0aIbd121AvWw53hCz3j9ssDpGdFefkhjeJnRcSSDmzTID5KcuWME9P
L67BjGJb3swYIpw3Sdg7LjWnMK0o9GpzfZVNuJFMsRHBQUaWAQvVG79AHe/5QI9w
pq0K5C6frllP5CgcoD2/H+8F8sMD7BrhyN1MxFRdaa4eCEh/hFxZV2nIfbZnx0SS
5/SNMKcCdly+yodZCgohU4uJuqDBkRIEbr6+OCffsupQMCYkh/Ew/RRa8tMN26bN
45/ferqMK1KEenpllXGNHi3/a9dT5CaqEvLjErdatChhQR6i7QbA5B3KhXKRSsRz
YPbYc7rc
=e8K5
-----END PGP SIGNATURE-----
