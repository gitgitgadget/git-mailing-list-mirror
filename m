Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97895C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 23:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhKVXdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:33:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:42223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231811AbhKVXdV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 18:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637623809;
        bh=z6ztDMVPW+u5ESqs/lk2BUXrV47E4aXpuOrW9jW/g7w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=blp9BbcEkfZ1dFhVFFCBpe6NaY/+9Slwo7FZvu1zZEpy6tracnzHHQRq1wgugq3h7
         ckT5b6sprj+Yy2+hkOlKdfIIIlc7OIAwoxzFOEZRmsVKAJulU71k3nYxU2yHXXkFVW
         oycVyiAga+Hau3lIoayU3uV4QIy/UqqSMdgw3pOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1mDlYU10ZT-00dYd3; Tue, 23
 Nov 2021 00:30:09 +0100
Date:   Tue, 23 Nov 2021 00:30:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: preparing for 2.34.1
In-Reply-To: <xmqqmtlvbynr.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111230025440.63@tvgsbejvaqbjf.bet>
References: <xmqqr1b8gkhg.fsf@gitster.g>        <CAPUEsphNH9pfQoHqVgJfkQCU-Li45dz4QtGtDjWu5bDV9A3PEg@mail.gmail.com>        <nycvar.QRO.7.76.6.2111222319100.63@tvgsbejvaqbjf.bet> <xmqqmtlvbynr.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tjy0fgNwgYpIqEXBxQIB9Ep66wBmNC6rRuj2/BUOHTItfv+WGvh
 pzsnk+Bz91gd+ZIDiBT02uvzykUT//Y+iPWTFHG/k26O43E6TvPWFOdETNcEntA9pFN7FY9
 hpa42Xvlv3jgMy8m0sblq9jz5tq7irNLVnDKLzanUWQoHBU/EQXGxYDDvNCQxxV+M+2OfjX
 mLQUPJ7t28qRWyHKe5b1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bydhu16iVwY=:pRiM40vH4ZSsLu31EDhy9E
 irRWfaWE41y0D8SIkmOzBzKf2CVq1ay/8GzMCli7EOuV7UySUqMgvXIzFaBczM6T5baRSSgS7
 xenQDis2diqS/Pw3hf4+D/fDTrmKlt8E4yoCnAl6nHU2NDpwB9mm6lnxw8hpzxt5tXatGQo+3
 ZigIzfhMkuS/VLB9JVHK4P25Pr1KKQMnXgwJwFU/uD78L74bN8o9mnaXKUdxQCf+ljrvfd7Ad
 0hUemmvL4iDtV7GBQlVz5KtM34mG/DxX0MEqGxzIYlB67OMfFKs3d1jXhqkFYvQxdKje8rOFU
 dSodky2LzbTJS9leJkxYthdqj18qN2iqVkBmHHg2swK1UOY/4HeawOGGuMoqKHdoJXBMKbx/8
 Q3sRCgCEQniICl8GD5WMn04Cb3ImNEsnByW/Ryirs0ZbfOx8Wnea9mMXkoZnF9eNBCJeLLcwo
 i7dnnOxuPbX8Z0EcbrJiK/mZ8MqLStnwhNR5jvD89LfxAAo6nqmojN0wxL/B2SyJELvwB3OWR
 rTs3lrlXesYFa/Q6a90/OfJqODccZ+zaSfYp0LZ72N4EG8bh3DDW9/ChPvws03nBHj7yyF4eG
 GQiCEsZeHP+GV6HN4EsYa5V9FCdJCcIUzrSnp4NR0lzQyiXn4k4J0LpW9nFDGOT8InhHht5Bw
 DS8RrCZ7DHSBtn5rS1Qx/6U9ncG52MNyBtNE/UhruN/X6voSdtM7rQh7kVCjkmBjNVav7IKqe
 5C+EfLKNm1PG8wIq1BRF52d968noo7JTZ+8UlmvmO4v3JXV0/168us+lf1Y0hC+7VjL/43Jhs
 /8d/PCIb1D0dLIgYceH0DvRkuEyCoiNmCC/rprPMUF+477+YdDXMeB38qZkEieQvjIQwC/wvT
 rLw5fN4/OP6TtzchwQ5zUd/OFSI1IkXZsbG518LJhkWY3JfHo3AjoOeExHVVtY+4E5ZW4EF9J
 ghVPsvWKYmIdwu0FN50RczNU0NvAEXwd07LCDPsalA3dMFJWxkmNWb0PViRgZVR4c9+rF8WpC
 Wtt1Qqw6dNc7DURUd8AXe02NVq8/lb5CVVvB9V7WbBi+WZx9u8yLzn8sgsueHqUmzDqeRsAh3
 zJrymjZVXpg7hk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 22 Nov 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > The quickest workaround for this is probably to special-case the edito=
r
> > `echo`:
>
> "GIT_EDITOR=3D: git cmd" would also be a common trick people would use
> to bypass editor and take whatever is given as an initial template.

GIT_EDITOR=3D: is not a problem because of
https://github.com/git/git/blob/v2.34.0/editor.c#L59:

	if (strcmp(editor, ":")) {
		[...]
		term_fail =3D save_term(1);
		if (start_command(&p) < 0) {
			if (!term_fail)
				restore_term();
			[...]
		}

		[...]
		if (!term_fail)
			restore_term();
		[...]
	}

> > However, I could imagine that other scenarios call for an editor that
> > _also_ does not run in the terminal, and where also no real terminal i=
s
> > available for saving and restoring.
> >
> > I was tempted to suggest an `isatty(2)`, but that probably comes with =
its
> > own problems, too.
>
> I think isatty(2) is pretty much our synonym to "are we talking to
> an end-user sitting in front of the terminal".  Mostly we use it as
> a way to control the progress bars, and use of editor on terminal
> would be in line with these existing uses.

Indeed, I think that isatty(2) is a better indicator than isatty(1). We
sometimes _do_ redirect the output of, say, `git commit`, to capture the
commit hash that was generated. We typically do not redirect stderr,
though, unless calling from an application and capturing everything via
pipes. So isatty(2) strikes me as the best balance we can strike here.

Ciao,
Dscho
