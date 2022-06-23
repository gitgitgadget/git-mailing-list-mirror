Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93701C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiFWP4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiFWP4I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:56:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C0E424A5
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655999748;
        bh=4uv2XiZ1Qos6QN0/S1bMjfQIwgePMFYmQi0du3oUf2A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=At6LwObaJcGqs+R/UEGnfty4+xMkr/kooltZoW26YMQhVkQItrblETgUH6G69c4Y/
         SMyKtlRn7yw00Kx8SxEgRHwh4JuxrZVXljSAxADSmYMGaZAeNgHDKnGqUFB9jU4rIN
         oxyfshDO+ZNlJWIaP7Ybs2f2YdP+w+R2eTIDk0+4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.215.93] ([213.196.213.23]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My32F-1nkGjr1OAR-00zXOM; Thu, 23
 Jun 2022 17:55:48 +0200
Date:   Thu, 23 Jun 2022 17:55:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH] t3701: two subtests are fixed
In-Reply-To: <xmqq8rpqja0v.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2206231747220.349@tvgsbejvaqbjf.bet>
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu> <nycvar.QRO.7.76.6.2206151649030.349@tvgsbejvaqbjf.bet> <165537087609.19905.821171947957640468.git@grubix.eu> <nycvar.QRO.7.76.6.2206181342200.349@tvgsbejvaqbjf.bet>
 <xmqq8rpqja0v.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1103821359-1655999748=:349"
X-Provags-ID: V03:K1:aIcqjWwgGLJE4UW7RLC+tA4vGcU+YFl9zIsfhK0ivURTnM/lsB4
 Bif+6hlvL8n84jeLJNTE6ZGZ6HT+pNZoFtDUPL409e1yHmrSJWmklIHn9nWTHDNiYsqNBzT
 T6+6UxjqdvPLbujk/USsWIN0BLKkJ72S3Szh8HCzm6qt1JmOo8JtH4sjJnQr4pq9bruLqdy
 eBvEfVtRDSe9Li+MIKaEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xViqrkD06pw=:LhpwCxnZVx6c4ANi07GyNN
 2J180OYhbjK2GcOYk6mWrWGWdh3qTuUJ1NqcdZtMZGMgJMjFAx9xxdvQ+0XGdNOW5Dv7VmgWF
 Mk+AiDrdwWDj2jp5oIv/xxIA4dEIxaJzhCT2+iX9HL+5oseHp54uXYKGtVOuuEMYl5fnkihl+
 5ZQASGlJi3BPL0MkOMKAwwZupkkP2Tw8q7BYs1awEsTFDN3clCjPRVwYmQvNttiK0X8QZMZv2
 Dii3wYEwo4cb3jjkvEP7rgmCirjmwUpyjSUSYNVKBUTuwX2c4Yor2mwAXbQ9lJYUnRIIWitvX
 GsJqzsdkUR5cW8NZmlqIiFlEBz2u43yn3BDaJM0AePmXVY9OP7lIR9Okwfl1Qblb1wKJ75Isd
 LFjOmw2I3u326k60wbU83m48j6kxRSbSseKnJXtSOWzpCtuVc2SV4D8IjQogwswy4x326sF8J
 mFG7ju8KtgGgzfIfH+ETw/2kMSetihXZapGzWtjJNCcQemaFWfeplBzPybAMGJjlACiVDkVQw
 TGYiBKe8iGeBhVzUHya3QNv2L+qgTB6UCB0jru3XukjSn43gI7YDTJJHnrqHYxZwca1Vj4UdS
 53SArgQ3U+YqFHuY9VlpJhEn5I0KCjOsfXVMDTigFIy11D+E/B0H8csMWG8EhPyI8aAPgTWDM
 5Zl5cI7LnxrkzfQRRwLTTAZqnV4cVmqpM0gLKT9zLbkWstvT8C4POp6oBGw9JWz8jb2NiMuhu
 +YrIEbnPAQ/DxiSWdvXF4IDV3rRYD6V+Kn/OyuhBAGdWgDQ+7pEnjK7vWUuUBQZYM9beMppK2
 8axX7FBrf8nRg5XgAD2bsG0DAHX96BVjYy+B6jC4CA1U2rm0QJqyCtQxaH2mWjvJhgB86q97t
 +Iadyf7T/51g9jUb9r2Gc7LP3VOujJpn5tRsiw0vVZ5uYZs83VhH/1nePBinClxW0ezv448Ah
 Si/ArJXOLEWcBthQvw0x+gYtQhcqe3pjipySuiHLPUQmHvpQtEg3nBsBoj1CpUzC2gxzLQCiB
 VV+6T3bVbDUh8ZdEvgqG6sH1fHMDPu3X/xewowtlR1q1ac4TDgP7FYjy1erQ6yBeIu7w3JR6Z
 TuVbrKaLFJrKyFgXcx4TgvzB9O66rzg1/xmMhds4cFDzwG9jRnENP2L8A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1103821359-1655999748=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

I did not want to spend more brain cycles about this, but since you left a
few questions hanging...

On Tue, 21 Jun 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> in config.mak. Nothing else strikes me as potentially relevant.
> >>
> >> =C3=86var noticed this and has a better version of my patch, I think.
> >
> > So you did not find it utterly rude and presumptuous that somebody sen=
t a
> > new iteration of your patch without even so much as consulting with yo=
u
> > whether you're okay with this? I salute your forbearance, then.
>
> I had an impression that these (wasn't there another one) were
> independent discoveries and patching that happened at the same time.

If this was the first time an unsolicited iteration was sent on another
contributor's behalf, I would be able to give the benefit of the doubt.
Even if it was the second or third time. It's been many more times,
though. And it is not leaving the impression of an inviting, welcoming
culture I would like to see on the Git mailing list. But it's your
project to lead, not mine, therefore I have no say in this.

> > -- snip --
> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > index 94537a6b40a..6d1032fe8ae 100755
> > --- a/t/t3701-add-interactive.sh
> > +++ b/t/t3701-add-interactive.sh
> > @@ -538,7 +538,9 @@ test_expect_success 'split hunk "add -p (edit)"' '
> >  	! grep "^+15" actual
> >  '
> >
> > -test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
> > +test_lazy_prereq BUILTIN_ADD_I 'test_bool_env GIT_TEST_ADD_I_USE_BUIL=
TIN true'
> > +
> > +test_expect_success BUILTIN_ADD_I 'split hunk "add -p (no, yes, edit)=
"' '
> >  	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
> >  	git reset &&
> >  	# test sequence is s(plit), n(o), y(es), e(dit)
>
> Prerequisite lets you skip.

Yes. It lets you skip a test for a known breakage in code we're never
going to fix because we're going to delete it instead, for example. Saving
some electricity, too, by avoiding to run said test case.

> > @@ -562,7 +564,7 @@ test_expect_success 'split hunk with incomplete li=
ne at end' '
> >  	test_must_fail git grep --cached before
> >  '
> >
> > -test_expect_failure 'edit, adding lines to the first hunk' '
> > +test_expect_failure BUILTIN_ADD_I 'edit, adding lines to the first hu=
nk' '
>
> I am not sure if this is a good change, quite honestly.  With
> s/failure/success/, perhaps, but not in the posted form.

Indeed, this was an oversight on my part, as you might have guessed from
the `failure` being replaced with `success` in the previous hunk. I simply
forgot it here.

But a more complicated solution for the same problem was applied directly
to the main branch, so I'd like to shift my attention to problems where my
input has a chance of mattering.

Ciao,
Dscho

--8323328-1103821359-1655999748=:349--
