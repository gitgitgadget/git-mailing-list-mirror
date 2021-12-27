Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF8DC433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 19:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhL0TP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 14:15:58 -0500
Received: from mail-4318.protonmail.ch ([185.70.43.18]:36835 "EHLO
        mail-4318.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhL0TP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 14:15:57 -0500
X-Greylist: delayed 11334 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Dec 2021 14:15:57 EST
Date:   Mon, 27 Dec 2021 19:15:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1640632555;
        bh=JIvvXJXFC1Jez6/h6TOT29h8SadfcEzo7trgy/72NUs=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=nu0F5AF0keO0lmrPmLivOFovHYyGEOqUGNJWsG/ZxY4eZnD+3EdmItoOonyAR5/3x
         FI5n133ThRpjNK1vxw8xOPZBxUSGuNtcLkGSg8k2y4GNcVYmftBbKuUHNWTwLVdOQy
         NDXRDyY/W+KpY5Eg1AZKLdGSkfP6vIdStnJHH+iHzK9MX0fwCqsz5jnQ3l2kqdH0Lf
         Dh6V28oJFpF2OmUQyt8lgm43DKKt4JrMTX2JURUbFsx8XMhveYhKjwuJTcr9xdWPww
         dlfCKKrzYjF+XW1+nEZwOkJeJx7FohxtTlU24GeCSAzRriLtqxRnNl3mwnQbjrfQza
         9YisRV9dLepkQ==
To:     rsbecker@nexbridge.com
From:   zhiyiren2009-subscription 
        <zhiyiren2009-subscription@protonmail.com>
Cc:     zhiyiren2009@protonmail.com, snakamoto1975@protonmail.com,
        git@vger.kernel.org
Reply-To: zhiyiren2009-subscription 
          <zhiyiren2009-subscription@protonmail.com>
Subject: RE: Quick login of git
Message-ID: <FKMNcEoH2PMBw4wcDkxzCDdl41kpWkZyh5SkiRlDi6seiVchbCuBbMmc38SFYR8gAgDhk_vo3xJSCiPSdYRIvhOQ1cB4uoZksClDYey2LXs=@protonmail.com>
In-Reply-To: <000001d7fb3e$7c0e8730$742b9590$@nexbridge.com>
References: <7w7c2MDOBpV9yIlD5yZZb801w-eaz0qhErkCN-De51h892xRFL14N-LCXH0O8wvDp_51A3hC86EMXonBkjNdoTZ-iy8xzoKLVecN6D6Zpq4=@protonmail.com> <004601d7fb3c$c9d359c0$5d7a0d40$@nexbridge.com> <J-VncZqqtXGSpnkopiYEtOET-oeVZX1tk3jBX9c3oSaOrcH1N_ciDdzQFvk50CkibrWFCboQNDeegBNMGZ247duUXwnPFY_0HbFvEWI0hVg=@protonmail.com> <000001d7fb3e$7c0e8730$742b9590$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Visit the url provided by IDE in the browser, and then click "Auth" to logi=
n.  Wait a moment, GitHub will return a token to the program, and you can e=
asily login to GitHub. Popular IDEs have this login method.
This configuration is much faster than the terminal, and it takes less than=
 1 minute.  But it takes 5-10 minutes to configure by terminal for the new =
users.

Zhiyi Ren / Subscription Mail
zhiyiren2009@protonmail.com / zhiyiren2009-subscription@protonmail.com

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Tuesday, December 28th, 2021 at 00:26, <rsbecker@nexbridge.com> wrote:

> On December 27, 2021 11:24 AM, zhiyiren2009-subscription wrote:
>
> > On Tuesday, December 28th, 2021 at 00:14, rsbecker@nexbridge.com
> >
> > wrote:
> >
> > > On December 27, 2021 11:07 AM zhiyiren2009-subscription wrote:
> > >
> > > > Why not add a quick login method like VSCode and CLion in git? Logi=
n to
> > > >
> > > > GitHub/ GitLab with one click, without privete key.
> > >
> > > I am not sure this has anything to do with git itself. One does not "=
login" to
> > >
> > > git. You might want to take this up with the GitHub/GitLab support fo=
rums.
> > >
> > > However, one-click login is being replace with MFA.
>
> > Did you mean Multi-Factor Authentication=EF=BC=9F
>
> Yes. And please place replies at end on this mailing list. Thanks.
>
> --Randall
