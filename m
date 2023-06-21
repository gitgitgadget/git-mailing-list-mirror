Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4898EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 18:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjFUS4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFUS4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 14:56:38 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835399B
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687373794; x=1687978594; i=tboegi@web.de;
 bh=qEhKQPmHwV0CB4Ew0h2hWYqvdQAv2QAHF9LU/pLeQUA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HP6Zs5u3GZFBQbIqLe6phxa+qKmaBFs8RG63SCtXVsHBzg//GieGfFgjsmGWybR1z1R8FJa
 usUQjX2gke/xk0LlRT2Shd3yg+xnO2KWgVW2M0Oo6Wbf2xwizjs8CZYP5siXK8+QfSJXoB0vS
 C5d7quiirspWOSFi/HD4yuNr/BtXhoUXsYm9j30WT8exU5CQGmNqK7ak82OYPyjSUtx3QLcUm
 Y3rTnuhMj+Q1JmD4UrY9s/+ZdwPMeQI80xgUMl8dDAz5kO7ABoLzk6CF84PrNqa7hrmjqA2q7
 3RtMGVQI3EmwGMorUDe0lBZtSm63LQzTBm4AJad9xyJKEXgbShuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALeR-1qMGGw4BXX-00BzCC; Wed, 21
 Jun 2023 20:56:34 +0200
Date:   Wed, 21 Jun 2023 20:56:33 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     paul <pl.gruener@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: commit messages are silently re-encoded to UTF-8 despite docs
 implying otherwise
Message-ID: <20230621185633.rwzopwolf7un3gjm@tb-raspi4>
References: <c6950001-ced5-448d-8f0e-22f597c68b9b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c6950001-ced5-448d-8f0e-22f597c68b9b@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:r+UV75GB5zuFepAZ7tM3eb6koYEFfqY7K///3Ve1b4L6AIGrb5g
 gJ555Kuwv/wLCF+nnSE9FVHCcYDEKemfGL9TBh6Hvib4DUQmwljuXu5NmBZJLdga2E68pvq
 pkWCs/5fsAVJa60hcVyRPFCHd7+4z6D7UneEcRPWXjGJ0qGJTP4vzLqdLscJcXIFoCEU5QU
 sXPXmbxKYm7jxXpKy/hUA==
UI-OutboundReport: notjunk:1;M01:P0:dOGgtSCRJgg=;fAB2yKLOFE9vvW2WvlCQwher7G5
 uG0fZSnGYOFsDrItQVg6kbFiYUfXPtAnAXqsw0ZkcSH9dZkeSOROml2xH2p3yHpOW/K1wxsxR
 mWH7z2ln5oYlgY1RO5iZzt0L1Cr49bsyLU31e5wVR+lVRxmPVmKgrn57si5HOnG8IF0EBUcH3
 JYfWhLQEvPVbtPGEv/T92MUMQ9nV9yt2wB5RyJjHkEqF8lWAvXCD9G3/kV+lqAzXiRvJm0iGH
 ouzXZE80z9hN8CaUpM5++C/Oq8M5Ss9sOM3sr52wAlXnZ+HdudAf3g+ITWV0JpHVzpaRvez5W
 oeWTTYcT0gjEmFXfJ1/b+/nwzuDSoBlxjBxXN9h7X88dzF+DsL2OGf4f0vumRhl37g9qjgkf7
 W6nT90H9Sgbgwpx7PUZlx4bp6JZ8Dy6gOaa4LxIERH1EUomM0X7aAkfb/Buke+psqlVz5Wx5R
 9gcllZ9EkpLZCu6993eCxZhQ2/oZ0YwQ6YoP9wriTDckaFlBVuyFQ/kog+5nM244YwKo686jP
 vpkEImDudGIsDGUU2HhHLotQhkB9N0K0dPSFOoc6vxxghapG5VJrXEVVuve2I2NrtJwKzja0m
 oLE0hEt5mUrH/jnO+y+i8l5LkxBSOyyVCAKPeXFHq3MmhhnEeuPikvq8vtsMiJni8Zynj+2tu
 WMCpUAOGtpzqg0P5wF3PjCXZkwXGevqF1wx90LrpL2dppf0ChgKGXUned+32vh+Y3khKs6K7H
 qYBPhODyrYq6YmkCKXN29foNkQr7O3mjZFhOqsPoFI8Ty9y20+E7+PdpTky6645p/eknY1On3
 VMm48GQ8i5JJX53q9augYJbk8EO+foksZ6eP2q74k478DJtWEERDwHMcbVYKz6lBRAZXtVTB0
 au3fVdcXT43Bpo0c38y01uHzV21MX4dqZCKKYpP+z9hi90z/ZGtwg9DmMTRBPRyRQgw8rZcM9
 zbPeVQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


(please no top-posting, see my reply at the end)
On Mon, Jun 19, 2023 at 03:22:27PM +0200, paul wrote:
> When supplying a commit message that is not UTF-8, Git assumes it is enc=
oded in latin1/ISO-8859-1, and silently does a latin1 -> UTF-8 re-encoding=
. That assumption is sensible, but the problem is the docs imply such a co=
nversion does not happen.
>
> Documentation/i18n.txt explicitly says (emphasis mine):
> > Although we encourage that the commit log messages are encoded
> > in UTF-8, both the core and Git Porcelain are designed **not to
> > force UTF-8** on projects.  If all participants of a particular
> > project find it more convenient to use legacy encodings, Git
> > does not forbid it.  However, there are a few things to keep in
> > mind.
> > . 'git commit' and 'git commit-tree' issues
> >   a warning if the commit log message given to it does not look
> >   like a valid UTF-8 string, unless you explicitly say your
> >   project uses a legacy encoding.  The way to say this is to
> >   have `i18n.commitEncoding` in `.git/config` file, like this:
> > [=E2=80=A6]
> > Note that **we deliberately chose not to re-code the commit log
> > message when a commit is made to force UTF-8** at the commit
> > object level, because re-coding to UTF-8 is not necessarily a
> > reversible operation.
>
> Said warning reads:
> > # Warning: commit message did not conform to UTF-8.
> > # You may want to amend it after fixing the message, or set the config
> > # variable i18n.commitEncoding to the encoding your project uses.
>
> I interpret this as: that config variable is only used to silence the wa=
rning (and as courtesy to the future reader), not to control some behind-t=
he-scenes conversion, especially because the note above says a re-coding d=
oesn't happen.
>
> But we can easily verify that a non-UTF-8 commit message produces the sa=
me commit:
> ---
> #!/usr/bin/env bash
>
> export {GIT_AUTHOR_NAME,GIT_AUTHOR_EMAIL,GIT_COMMITTER_EMAIL,GIT_COMMITT=
ER_NAME}=3Dme
> export {GIT_AUTHOR_DATE,GIT_COMMITTER_DATE}=3D2005-04-07T22:13:13
> # symbol '=C3=84' is 0xc384 in utf-8 but 0xc4 in iso-8859-1
>
> git commit-tree -m $(printf '\xc3\x84\n') $(git hash-object -t tree /dev=
/null)
> # 4df6ed26ffd0b02c8b5c1d85ba184b02fbcaa2db
>
> git commit-tree -m $(printf '\xc4\n') $(git hash-object -t tree /dev/nul=
l)
> # Warning: commit message did not conform to UTF-8.
> # You may want to amend it after fixing the message, or set the config
> # variable i18n.commitEncoding to the encoding your project uses.
> # 4df6ed26ffd0b02c8b5c1d85ba184b02fbcaa2db
> ---
>
> It's debatable whether Git should even attempt to do an encoding convers=
ion =E2=80=93 I think it's fine if properly communicated, so at the very l=
east the warning message should be changed to something like
>
> > # Warning: commit message did not conform to UTF-8 and was automatical=
ly
> > # converted. You possibly need to fix and amend it.
> > # To use a different encoding than UTF-8, set the config variable
> > # i18n.commitEncoding to the encoding your project uses.
>
> and the documentation adapted similarly.
>
> regards,
> paul
>
>
> PS: the code responsible for the conversion is in
> commit.c +1654
> > /* And check the encoding */
> > if (encoding_is_utf8 && !verify_utf8(&buffer))
> >     fprintf(stderr, _(commit_utf8_warn));
>
> and
> > /*
> >  * This verifies that the buffer is in proper utf8 format.
> >  *
> >  * If it isn't, it assumes any non-utf8 characters are Latin1,
> >  * and does the conversion.
> >  */
> > static int verify_utf8(struct strbuf *buf)

Thanks for the well written report.
I haven't had time to dig into the details with the same depth as you did,
to find out what the best solution is.
Fixing the documentation to reflect the reality is always good.
In the beginning Git was not aware about encodings, kind of.
Then Windows came, using local code pages, and all Linux distros switched
to use UTF-8 everywhere.
Having said that:

Do you want to send a patch (or 2) to improve the situation ?

And out of interest:
How did you find that problem, on which OS, system ?
