Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1524B1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfD3WHd (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:07:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:55757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfD3WHd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556662043;
        bh=aRcrgbverbT46me9XQK4dCG3SHdf4cVyrYxCtrXnMRQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Kv1qnh5XMevLiBcIcIof8LMV6cXLlBybxGi9nnefJF4qDCmQi513R0325gXgVz8j/
         4/asSaNpDmWsc3G8Ow1DU2K6rnltH3NL5FzB+rq3TmSi7haKed4TojFiuxUwwgyVkD
         2fFXiD8+e6knMtGXp6fsIS3K41tZ8JdQXfI6KUEQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLfLH-1hMPqy0r91-000uGT; Wed, 01
 May 2019 00:07:23 +0200
Date:   Tue, 30 Apr 2019 18:07:15 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Jaros=C5=82aw_Honkis_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jaros=C5=82aw_Honkis?= <yaras6@gmail.com>
Subject: Re: [PATCH 1/1] credential: do not mask the username
In-Reply-To: <20190429234028.GA24069@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1904301753030.45@tvgsbejvaqbjf.bet>
References: <pull.138.git.gitgitgadget@gmail.com> <e459e487d3848ae1b7f37676bd9d2a2f9c967430.1556575570.git.gitgitgadget@gmail.com> <20190429234028.GA24069@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-137367802-1556662043=:45"
X-Provags-ID: V03:K1:6RXKNPTi3FL3N/rYbrlt3PTnueipjTG78b1dUOGWN0nn3u41xRB
 Er1Ls19+NTMp9ts8vIseGBXlRjLyl7G68589H7yjTcKrCI37MTzvoPOgtjiiXCzc0HqMlKV
 FebF8fWW+HAShf8H/aOsASh1hqW5LBzF/dCotVBFPV6npd+0AIxU1OPJySzDUwDTL8m8q5L
 kCV8m+7MIvLdSHHXXbEOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VWG3O62/+kQ=:WaVVMBb+kSnjwIbwg3DaAL
 n5wEdX/t+uft5j/Y/qTSNQKtPxZBjFe1ruKEaRoahw+2J28iFcEEaxghhePaRmaLkWtopTBQF
 hBWyD7e/uvbsGAtSuFOWFakI+pquxKJWcRBCHRYL+6PNiXorHOaw9P2MSwndOFghFE1ZveAmn
 p6HXOJe20fq3MufVTQ+az4/GLBGYQaDKDOiWKLsdQAPwpWi3CuGA5HIalV0QK9cEJj6MjF6S+
 +AuBpYMwfe988wxpVYXZaMjDdJWwg883dRWn4XrJPFGCo+H/YCN1XEIfslIYF/LkF8omGYZ0l
 uCj70ZTNyh4Yqrs8h2Cf2ZLqDconIFNRua/nF024riU6D1WLzvCIiiIQcLMXdQeQWGw+RrRGl
 gDBkqtHLboSSPdJzMrNreGqcMXoteijkiL9S3rEAXO9CwecuySTKh/PS9oYeHhHVLKAS0Aye9
 W7Ab3y1yy8Y/G2rXZYONsRnvGf8/wsFSMHytMCStDc39tyepiWFY514TO3JYlNx8r6NYJDbqb
 WvdcTfyMm1Kif0ihF/IllbHjsmaeijx/YIDk164Zf1NDAKU1CgBLiuxKZmh9Y35nbiWKPDyYE
 UugYd/k/hu6E3l4QkqlL1NEVEdBw0pwLkwSusIwQVMr/fbO4GZL4aXfZAdB9tG69K/wPL0xWK
 ncrZXFX/8mu152qbFPWbz31xySaVMPsOmxLqmWZTrvhl53TuPFl7JGTfF7oz88tLt7vlo1/jN
 8RmL0R7tcdOjk/uzk96qEq74pzE+DBZy9YSPszOFD+Nt9U0ACg9WakrDUPZ36yOkKmUB+Y175
 4WtM7SHG3hfK9xz55Tsilvqo7rqYaWGTjZHXm2seMtY4cDNA7M7SWaMoVkjtlCL3U8VGzxD56
 jGSUuz7Qy6RVK+Tu6PuVqZAiVrEG5N6XMNO2bs/UtUB1pLmMO54tq+4rw0cEHq56yAqTegAID
 oaxALoAlhLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-137367802-1556662043=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Mon, 29 Apr 2019, Jeff King wrote:

> On Mon, Apr 29, 2019 at 03:06:11PM -0700, Jaros=C5=82aw Honkis via GitGi=
tGadget wrote:
>
> > From: =3D?UTF-8?q?Jaros=3DC5=3D82aw=3D20Honkis?=3D <yaras6@gmail.com>
> >
> > When a user is asked for credentials there is no need to mask the
> > username, so the PROMPT_ASKPASS flag on calling credential_ask_one for
> > login is unnecessary.
> >
> > The `credential_ask_one()` function internally uses `git_prompt()` whi=
ch
> > in case it is given the flag PROMPT_ASKPASS uses masked input method
> > instead of git_terminal_prompt, which does not mask user input.
>
> This description (and the patch) doesn't make sense to me. The
> PROMPT_ASKPASS flag is just about whether we would trigger the askpass
> tool (e.g., if the user does not have a terminal).

Thanks for calling this out. It is a bit of a problem and you're right, I
should improve the commit message.

> The PROMPT_ECHO flag is what you want to tell the underlying code that
> the value can be shown to the user. And that's already set.
>
> Now there is a slight issue, which is that the askpass tool has no way
> for us to tell it to show the contents to the user.  There's no way
> around that without disabling askpass entirely, which I guess is the
> strategy this patch is trying to do.

Precisely.

> But in doing so it's going to break anybody who _doesn't_ have a
> terminal, because now we have no way to prompt there for their username!
>
> So I think our options are:
>
>   1. Leave it. If people don't want askpass to prompt them, they should
>      not set up askpass.
>
>   2. Use another tool besides askpass. I don't know of any askpass
>      implementations that take something like our ECHO flag, but there
>      are lots of other tools. I doubt there's any easy portable
>      solution, though. And anyway, credential helpers are a much more
>      advanced version of this anyway, so I'd probably steer people in
>      that direction.
>
>   3. If we really want to try to try to avoid using askpass for
>      usernames we can, but I don't think the logic in this patch is
>      right.
>
>      If we want to avoid regressing existing cases, then we'd have to
>      first check if there's a usable terminal. And only if _that_ fails,
>      try askpass. And then give up if neither work. I.e., invert the
>      order in git_prompt() when both ASKPASS and ECHO are set.
>
>      I think I'd still favor option 1 over this, though. Configuring
>      askpass has always overridden the terminal for usernames, and this
>      would change that. I come back to: if you don't want to use
>      askpass, then why are you configuring it?

How about inventing a new convention: we could set `GIT_ASKPASS_FLAGS`
as an environment variable that contains whitespace-delimited flags, in
the current instance just "echo"?

We could then teach `git-gui--askpass` to heed that.

Mind you, these days, this patch is a lot less necessary because Git for
Windows (which is *the* platform where you'd expect no terminal to be
available when fetching/pushing, right?) defaults to using the Git
Credential Manager [*1*].

> >  		c->username =3D credential_ask_one("Username", c,
> > -						 PROMPT_ASKPASS|PROMPT_ECHO);
> > +						 (getenv("GIT_ASKPASS") ?
> > +						  PROMPT_ASKPASS : 0) |
> > +						 PROMPT_ECHO);
>
> This logic is weird. It still uses askpass if GIT_ASKPASS isn't set. But
> _doesn't_ if it's set elsewhere, e.g. in core.askPass. Which makes
> little sense to me.

True. I guess this is my fault, as that patch is so old that core.askPass
might not have existed when it was written.

> Maybe the intent was that the original user has SSH_ASKPASS set, and
> that is kicking in (which would also explain why "if you don't like it,
> don't configure it" didn't work). You can get around that by setting
> GIT_ASKPASS (or core.askPass) to the empty string (I don't think that's
> documented anywhere, and I don't recall it being intentional, but it
> does look like that's how the code works).

I agree with your concerns.

What do you think about the `GIT_ASKPASS_FLAGS` thing? It is not perfect,
but it could be used at least in conjunction with `git-gui--askpass` (or
with other helpers that would make use of this side channel to receive
more information about the way they should present the question to the
user)?

Alternatively, I could simply drop that patch from Git for Windows, as it
really only concerns users who override the default, opting out of using
Git Credential Manager.

Ciao,
Dscho

Footnote *1*: The Git Credential Manager for Windows
(https://github.com/Microsoft/Git-Credential-Manager-for-Windows/) is a C#
project that requires .NET Framework, which older Windows versions might
not have, but I think most of Git for Windows' users do. In the interest
of keeping users' privacy intact, we have no way of knowing, of course.

The Git Credential Manager is preferable over the `git-gui--askpass`
method in more ways than just unmasking the username: it also supports
Two-Factor-Authorization, most notably with GitHub, Azure Repos and
BitBucket.

--8323328-137367802-1556662043=:45--
