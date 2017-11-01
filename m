Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9593202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 17:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754845AbdKARHe (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 13:07:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:55059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752395AbdKARHd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 13:07:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeRKD-1dLy5b3Od3-00q8ps; Wed, 01
 Nov 2017 18:07:26 +0100
Date:   Wed, 1 Nov 2017 18:07:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] mingw: introduce a way to avoid std handle
 inheritance
In-Reply-To: <20171031180933.styinoik4npmd53b@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711011737460.6482@virtualbox>
References: <cover.1509382976.git.johannes.schindelin@gmx.de> <20171030205522.hur26cumwusk7wwa@aiede.mtv.corp.google.com> <alpine.DEB.2.21.1.1710311809570.6482@virtualbox> <20171031180933.styinoik4npmd53b@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gyE+CmpErLv9eM/vLCRqWXbMLsCeRqzfzon+Ig4+zGxvtckFukb
 9Ls00+fcTHT7SLoVn3fqkLkNGhlX+xTaNbLQYgVMP328Cfpsh3T6WiLHqc0mRM2iP5T9kXC
 SEcb8h52m0mCM5F4jgkzy3SeKc5TTmn4Y/IkVjr46iJyYN5iTkAU058ROWZX1gctw309+aZ
 Bcs0jUfceNyPP0eRwJ4GA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SvvqUf1VsGE=:3YgUFAONWky43sYxYoD6x0
 ZhoCYJk4KW4AGoeheI0abG4foMef8kPrWMpI/E6f0n8x5sCjc7oD3akGpD/3rjvI/6c6k0RCT
 UFd0s2lSl6QnNUJSB/nJYxTLA27kmIqHDLf4abRav7FQCfX0XGxlvqIB7L6ZG1+zhl2wiNLh7
 H5qzWU6W/1JtE7WQZuPNhUFkHr3PYT/hcoNEtR4Iv+sOOivPN8VtrzarG5iAMWYMZ+XzeVz0V
 i4iu1q8wrVuRLhoHLuuUEQkGDGNE8TAua9brsaGuQBFuODt0Iwb/pndZ/3i5KB1riH2v2PEBA
 vtyb73rozX3xsYif5NlzGUNllF5dmsIDjEUxuDe8Co5ab+nIel6pEralX03tW6W19Ukqdr+BG
 GJobL9DH93g/5vIejOIu3rcSmj2gDZX6DsQMRlOq8+t/7N7f8REXmeP7kVAd7sYyl4YNaxuwx
 RuhMO/gqj0T90RQOUZwYsHXxdOaOAefMOotPhvOPdK/kmse2wj4kALzbigF3JC09Qfh/26ZIZ
 CgoZHBnMWI+xIc2EpeIFbFBiwagQjqMv1KVpH3Vk3EN4dDDPSfDGPeDTCb+NkNuaheL1CzaS5
 +xY3MkwsaG1lg/oDsSsfmmMLWMMqwAOYM5SMdrlpnNc/h9wGQYTWmvkrceqdIWAZurQ7pzKxR
 ZHpNpTm40uNdJyAV/lbb6cwHT8Mq9J/GU27hHpoXKcbFtblx5AovjrH/uhhnKoojcpRw38S7G
 AMmYiiqrBRsNRFNatV2QIVrFDgXAcaDw97Bo0a1u72x0dMGEjg3RFS+q/S+ICHeATK/p6Ri0t
 9W1J+QI5cGSpx1QUWBgokywG6Lr4AYNoJilI3OIMWFJj4EnRKxgnpLiGDh/dfElo7srHA6l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonahtan,

On Tue, 31 Oct 2017, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> > On Mon, 30 Oct 2017, Jonathan Nieder wrote:
> 
> >> Can this rationale go in the commit messages?
> >
> > I thought I had done exactly that in 1/3...
> 
> Okay, I'll be more specific.  This cover letter includes some
> information about the rationale and motivation for the series.  That's
> great: it makes reading the patches easier.  But TBH I'd rather that
> it hadn't included that information at all, since if it said "see
> patch 1/3 for rationale" then I could save the trouble of reading the
> same information twice.

Alas, I am the exact opposite. You see, I am seriously short on time, and
if the cover letter of a patch series leaves everything about the changes
unclear, I throw my laptop out the window (actually, I suppress the urge
and just delete the mail thread in my mail reader) and move to the next
mail.

It sounds a bit stupid to cater to myself in patches *I* submit, but I
refuse to believe that there are many people with more time on their hands
than myself (last time I tried to research this, it looked as everybody
has the same 86,400 seconds per day available, give or take the occasional
leap second).

> And unfortunately much of the relevant information is not repeated
> there.  The cover letter mentions:
> 
> - that Visual Studio is a motivating example

That was actually on purpose. Personally, I want to read the motivation in
the cover letter, and not get distracted by it when reading the commit
logs.

To make you happy, I added this, though.

> - that this is conceptually similar to Unix sockets

To make you happy, I added this, too.

> - that those do not need to be marked as inheritable, as the process
>   can simply open the named pipe. No global flags. No problems.

I just added "(and therefore no inherited handles need to be closed)" to
the last sentence of 1/3's commit message that already mentioned this.

> - that this has already seem some testing in Git for Windows (i.e.
>   analagous information to what a Tested-by footer would say)

I mentioned this twice, in 1/3's and in 3/3's commit message.

> It is also just more readable than patch 1/3's commit message.  That's
> to be expected, since it was written later.  My second draft of
> something is often clearer than the first draft.

I took your cue and simply replaced the first paragraph of 1/3's commit
message by the first paragraph of the cover letter.

Ciao,
Dscho
