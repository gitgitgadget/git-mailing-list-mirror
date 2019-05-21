Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082EF1F462
	for <e@80x24.org>; Tue, 21 May 2019 22:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfEUW2X (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 18:28:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:56899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfEUW2X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 18:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558477696;
        bh=Y9LDpEtqCoQkuFFm2LH54xnNuSFdoRwbF7tZpvWlaHs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=So6L33gfznPag03u4j/2Cv5TGKn4ZAldMxOuWDK2qBX2HBPB4TcUIAewIF4mu1iDP
         bA7Chtj4kIYQePaf8lHoZ1VsGgMI+RhUZZ/I9VgZp6vOnxCWczGabHCGYouqjVo9Z3
         xeJ5kGYh4ktkU7GbUvGv/jHHjRqeCIrPoY1uWVx0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1gWOFJ4AzS-012Zcl; Wed, 22
 May 2019 00:28:16 +0200
Date:   Wed, 22 May 2019 00:28:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: js/difftool-no-index, was Re: What's cooking in git.git (May
 2019, #02; Tue, 14)
In-Reply-To: <xmqqsgtb1am1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905220025440.46@tvgsbejvaqbjf.bet>
References: <xmqqa7fqbahj.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905141153150.44@tvgsbejvaqbjf.bet> <xmqqef508q0y.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905151015540.44@tvgsbejvaqbjf.bet> <xmqqsgtg5cff.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1905172025450.46@tvgsbejvaqbjf.bet> <xmqqsgtb1am1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UtSaY8VJ3lmm2OKNJuQhvWf6/DJQ2JaWj5mxslnc9AHk72xRT77
 4E5bWKOP7/Y52IwaRkLm9jIGcskufvfbHodFswe9zeY9+nkeobnE65uXACw5nuS9n4pXy2k
 pcBnh6u/yipzLb3lAH0xGw1H8UgdfHmTnLRQvHRElBe99VA4gb6JvomxwLy0kcAwbv8T9Do
 j7Q+jrU2LS2sBV2PYhdlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ganeYlDCuyA=:C8EzJkE021NW2t1i5eoERS
 iXqqyXBw8TKNHKNJ1Naj4DmSvLhdVXSCOh93xmigkgoClkIQAGUF2+bt6EHjFvHvf5vom+esO
 5znQvVJR+ioMJ3JP5BbzqH4FzM8AFBUJmDtQF67K8L9YjtvbI3wQVM0IO7e9Idp7oGsymWGdg
 JXhkAoVTqlf3G7/hc6iDZAkrlnsWhF6T3pH9CKCtiR6uAjRPdBlJXXo52YCYmPqemPu4fu6rY
 Jel7ACxP/sYNwbkkAwWWoLv6B0BtsKoUAk6Nh2uUqXtpFGQu0pyx4uCWQTBWvq3gMLN9HdL1z
 ClO7Nh1hubuppIeuU2JUWc9/nQ9FGiQ1ijL7KwHtBpnY7FnUEVgr3EnfimdWjS41DO5LLWkCV
 x5Vcbao9VUE9h7bYaFuWsqSGa+p97vGrV5bz4i/cr5FlrpQB91WCoYhIfhH/Mzmv2UvF4KRyX
 QcYUOX5z69TDx5yTdZ4NBRsACPmH4nOCsaj+0FRC7bzqzD8ZNG+qW8QnEh3g0GWPSHfqCarip
 in9YuL1Xl7rrXyYCO08WWeNIaSW0cUiu62e3O+LZmuneAqFZzpIWb8DhsjKjAJpHGIkuL6PBa
 r6kSzL7YvDhWYMLxQ6W0hGwQ42wgEM1WeUgKCi31NBbV4YptyUCU18feT93gIuB8x7M7UezbI
 /0ZxzCF4twWy2XdIlUHiN8FNKbA9mJa1XrVUUIHCavsG4875QH/XcnR74XrM9NF5zFW2jGrd1
 1hSYSrj1M/AaTi10LEygLRoq7MyAv+AINKZOINhcwJ4T+M3o1rxWaPJTV/1sNE6Wwoqwjvkpc
 GIZ36XZFPl2IAWyj0xwVf/2aTOyugsteKK3MWTjG1D0ZERJYfyJbWAdUUlLTkthGG/a8d0dhC
 R0wRNwI/Qe6LHwfy1wqyW+x9n149taHqCY8IzVBaLqMjyclLjt9OuGoPeWW/NWDfYQAZoWVc7
 jHXLISHf2PpYeIn4+pWTvfRVi9eHDoqgWvAop7emHTJ1ejf07AD9Q
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 19 May 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Wed, 15 May 2019, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> I was imagining what would happen if we treat _everything_ in the two
> >> directories being compared by "difftool --dir-diff --no-index" as if =
it
> >> is tracked.
> >
> > Isn't this exactly what `git difftool --no-index` *without* `--dir-dif=
f`
> > does already (although without copying or hardlinking or symlinking an=
y
> > files)?
>
> If that is the case, then I would imagine that running that command
> for the user, instead of refusing to work, would give a more
> pleasant end-user experience.  No?

The elephant in the room is that a user might think that --dir-diff makes
copies (as promised) and lets their difftool clobber them files happily,
only to find out that they clobbered the original files. And since they
asked for `--no-index`, chances are that those files really are not
tracked, so now they do not even have a way to revert that clobbering.

Seriously, I'd rather not DWIM `--no-index --dir-diff` to essentially do
`--no-index --no-dir-diff`.

Ciao,
Dscho

> Unless we anticipate that we might dwim incorrectly and mistake a
> request to compare two things, to which the distinction between
> tracked and untracked matters, as a request to compare two
> directories that are not under Git control, that is.  If such an
> incorrect dwim were a possibility, then it is helpful to refuse with
> "when comparing two non-git-controlled directories, you cannot use
> the '--dir-diff' mode", as that would not silently give an incorrect
> output to the users.
>
> In any case, all of the above can be left for future improvements.
> Getting close to the final, I think it is preferrable to have a
> "refuse to stop early" (i.e. the patch that is already in 'next')
> instead of "do what the user meant" whose implementation may become
> more involved (and error prone).
>
> Thanks.
>
>
