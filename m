Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84CED1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 15:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeKIBP0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 20:15:26 -0500
Received: from mout.gmx.net ([212.227.15.18]:47477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbeKIBPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 20:15:25 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3x6-1fp0QJ36VI-00es5E; Thu, 08
 Nov 2018 16:39:15 +0100
Date:   Thu, 8 Nov 2018 16:39:15 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
In-Reply-To: <xmqqr2fv7hp8.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811081637240.39@tvgsbejvaqbjf.bet>
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com> <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com> <xmqqo9b1d6na.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811071217280.39@tvgsbejvaqbjf.bet> <d7a70226-3441-76c4-df6a-e8fb32249f27@ramsayjones.plus.com> <xmqqr2fwa0ew.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811081356350.39@tvgsbejvaqbjf.bet>
 <xmqqr2fv7hp8.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uOencIGJe9HasWtImKbUIojxGUgExfZq6X/Unv2/H8rdcp5SyCT
 4MBr/v1JBQJXrVV326a1b9a4pV72NSZNo9Yu8LkwXl8E5IMFNpY88KSOi+VMZHWsex9D5ml
 4sUPkxGJs7Hi+xODK440ZGKnw2OFarzu9kq0XK8T7FuDUiKp8zhDNVQ/ZmJg8UKKXhuFx+B
 6ksi4w0NaUVFwO4SFyiAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I/cQi44cZPA=:puUehOkVZ/6Hlh2fniXS7G
 hsCmI1RqOsTMaGtc8jQojQmPlAatkF9G/JzSye23mOgELyG6hr+4embRCgT0XDgv2Tf1lWM0e
 w8nhHPNaorNuJaqfNCRV16COw51J/Yyki5PAgv42YWvmX83YWRoY7tctmxQ+ULFTia8Z1xCZ1
 sZxWWnOwPdTEm8ZTtoja2OIxN3axGmpSlCpV9vRHZPY1qh+xvNG7VsJcHq7KANerHfiOxeHJq
 PS5iCKb1j9KXV3ENPx2NzfRa16BCTefi9cenpcJWqcGyMTfFu2NKpt+GebFyJJV4yp3YYc5ts
 3JJYRQy+j1oB6CtzDogzO2niR6J3g4tDz8xZpNtzaxJeyz0v+2I1qtxMXQboWMPokefsD68gT
 KElNiWL9WWpdKi+4/Wd+plhd3q2Wzlu1jlfLwVLGfhQO24SFWd7ztjZ96kGs/U5AQkXhLWpUg
 N05JptQEnI6VVRQoapQBe6LslBCPDs2N8ewr0UU96p1ShX2FnZoW7NTlYuHIYYH0ndnwsY5It
 OzYOmlqelKRALkom0WV9AHI7rc3MAPFS/tErUx9MLzk1Y2+56n9L9KMRs6/umS2sfsOKrv78a
 uLv8VafOz5zw6RQy36Yy58ekv7FA8rfeXVNKUOtBC5lNn+REotirYad0SHlrNFbBEqzgRQngp
 Iysz58vHgyOMQ28FPpgF54pock+IRsDYV3eeLukOJmLqYIJARtDTq39Lnr642cp5kKyMLFoce
 K8/B80np7gDiuRKAaGr9fCEMMo09iNIaL62Euvh8gRgLgDS6fAKn3XLrLITOpv2TYzstkOKHu
 nc3TUoq7Kj7tzfPdG/LFDd4i7sorurXzuKRidTieG9GOWhGDXzKp5qNnI+69GrOhiTSYY+9Dd
 e/18ZH5O7mGoPUbhyrQW0fQGT8vX5Q1VD9bnK20FZVVimEE7bIj3gq0FgjiFeVJE+kdJtuOf/
 fhACrzcO22w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 8 Nov 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 8 Nov 2018, Junio C Hamano wrote:
> >
> >> I am tempted to say "//<token>/<the remainder>" might also be such a
> >> way, even in the POSIX world, but am not brave enough to do so, as I
> >> suspect that may have a fallout in the Windows world X-<.
> >
> > It does. //server/share is the way we refer to UNC paths (AKA network
> > drives).
> 
> Shucks.  That would mean the patch that started this thread would
> not be a good idea, as an end-user could already be writing
> "//server/share/some/path" and the code with the patch would see '/'
> that begins it, and start treating it differently than the code
> before the patch X-<.

Ouch. You're right!

> > Granted, this is a highly unlikely scenario, but I would feel a bit more
> > comfortable with something like
> >
> > 	<RUNTIME_PREFIX>/ssl/certs/ca-bundle.crt
> >
> > Of course, `<RUNTIME_PREFIX>` is *also* a perfectly valid directory name,
> > but I would argue that it is even less likely to exist than
> > `$RUNTIME_PREFIX` because the user would have to escape *two* characters
> > rather than one.
> 
> Yes, and it is naturally extensible by allowing <OTHER_THINGS>
> inside the special bra-ket pair (just like $OTHER_THINGS can be a
> way to extend the system if we used a special variable syntax).

True.

> >> Are there security implications if we started allowing references to
> >> environment varibables in strings we pass expand_user_path()?
> >
> > Probably. But then, the runtime prefix is not even available as
> > environment variable...
> 
> Ah, sorry. I thought it was clear that I would next be suggesting to
> add an environmet variable for it, _if_ the approach to allow env
> references turns out to be viable.

Of course, I should have assumed that. Sorry!

Ciao,
Dscho
