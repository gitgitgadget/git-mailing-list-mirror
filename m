From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] t2017: redo physical reflog existance check
Date: Tue, 24 Aug 2010 15:57:53 -0300
Message-ID: <AANLkTiki33oaQjnY8oxdAH1NLuTV0epCRz1XSp0irg9f@mail.gmail.com>
References: <1279763190-32757-1-git-send-email-erick.mattos@gmail.com>
 <7vlj93h120.fsf@alter.siamese.dyndns.org> <AANLkTilt5gx3Wj4eANfkIFm869Olns1rsMpCS81hS2BV@mail.gmail.com>
 <7vsk3bey1e.fsf@alter.siamese.dyndns.org> <AANLkTin76s-ONFuP+OWdxB5LJNf2D1Du+hKxB2s_WhTa@mail.gmail.com>
 <20100824040347.GA19817@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 20:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnyhR-00087v-MG
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 20:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891Ab0HXS6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 14:58:16 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55553 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab0HXS6P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 14:58:15 -0400
Received: by gxk23 with SMTP id 23so2659006gxk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=j/oxY6g8EnADXdIfrjQS2QfHrC/KqWLMjhk+4PNUAgY=;
        b=qOo7AesDk5GD89ChqJKIvEcSs+j5PKZKp+IDuAzt6OM4CzuKSVrP/N/+ZP6Tdd8wxn
         KGNh6JRfMdf93/zu2HlkUwVYtVm0Tf0zW8XUA3OVxIkwfB5lQekc4xtRYYOHQtVjMTvd
         bdTtK4HdbdG9efaxrTAPhb1lfJ9wYKiP1t/9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DYO0B7a/J3GbgLE2WX+SpfYWv6rt5chDss98xvXCUsUtpuru/D02NQXCZOSr2E/wS4
         ufXkdGRMc6UHD7Nnp7VbcKvvLeCWmM+DK6uqf40GdD8BgrDQ6KlHxBZ6paKvyjDhsT91
         QwR2H7avf2kICdBLlrTlg5HCiNWn1FOviujn4=
Received: by 10.100.200.18 with SMTP id x18mr7645608anf.214.1282676294328;
 Tue, 24 Aug 2010 11:58:14 -0700 (PDT)
Received: by 10.231.130.210 with HTTP; Tue, 24 Aug 2010 11:57:53 -0700 (PDT)
In-Reply-To: <20100824040347.GA19817@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154333>

Hi,

2010/8/24 Jonathan Nieder <jrnieder@gmail.com>
> Hi Erick,
>
> First, thanks for checkout --orphan. =C2=A0I was a skeptic but now th=
at I
> have seen it being used for things similar to "going open source" (an=
d
> the related "simplifying logs while working privately on a patch
> series") it looks to be a pretty nice tool.

You're welcome! It is my pleasure, really! The reason for me to start
participating is a concern to pay back some of the benefits I have
been having by using free software.

I wish I could help all the excellent programs I use but I intend to
help at least some. Nonetheless I would like to do it to all.

So I am really grateful that you let me know my work was useful to you.

I have been addressing problems I had when dealing with git and
--orphan is important for private branch working. Even that I use
--reset-author more often.

I would eventually add more stuff to git, while it is already quite a
wonderful tool right now though It can be enhanced. However I don't
plan to because I had been facing extreme opposition and I don't like
to disturb. I only want to spend my effort where it helps.

> Erick Mattos wrote:
>
> > I don't see a need for so much reluctance: "test -f" is not a taboo
> > inside a script in t folder and the added tests don't change anythi=
ng
> > about the design and implementation which IMHO is well fit.
>
> The principle (though we do not always adhere to it) is that test
> scripts should pass or fail based only on advertised behavior, not
> implementation details. =C2=A0That way, _later_ any person who wants =
to
> improve the implementation will not be impeded by tests.

Tests won't impede a developer but it will show him that he is
changing something in fact. And they will tell him he needs to adjust
the tests too.

But in general it is a good practice to adhere to that principle
unless implementation is what you are really testing. At this case,
all right behavior had their tests before it and this one is to check
for a bad implementation.

"The problem", test -f, is used 428 times inside 92 scripts and in a
similar way (test -f .git/...) 48 times inside 19 scripts. So I don't
think it is correct that I have to struggle so much to use it too.

And the major fact is that the actual test is testing NOTHING and that
the test lamed IS important!

> The behavior that "test -f .git/logs/refs/heads/eta" checks for is no=
t
> part of the advertised behavior and though it does affect the
> observable behavior, it is not immediately obvious how. =C2=A0Wouldn'=
t it
> be best if the test described that advertised behavior while checking
> for it?

I really haven't got you point. Let's see:

'giving up --orphan not committed when -l and core.logAllRefUpdates =3D
false deletes reflog'

Don't you think reflog deletion is immediately obvious?

> e.g.:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config core.logallrefupdates false &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_when_finished "git config core.logall=
refupdates true" &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout master &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -l --orphan eta &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git rev-parse --verify eta@=
{0} &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_tick &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m "initial commit" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git rev-parse --verify eta@{0}

Your test is not the same and that is already done by zeta: '--orphan
with -l makes reflog when core.logAllRefUpdates =3D false'.

> Happily, I am not the man in charge, so feel free to take my words
> at whatever value you choose. :)

Not quite happily though.

Unfortunately the problem which git does not address for now is that
git have cemented the distributed repository but it really haven't
created a distributed development workflow.

Someone still have to create a workflow where people merge code,
design, give the directions, do quality optimization and more managing
things TOGETHER.

While everybody have the right to access and work separately, there is
no existent tool to integrate the work without a need for a moderator
which is always a flow constriction.

You can see Git and Linux as example: while the widespread use of
distributed repositories, every management is closed to the
maintainers which can possibly ignore good stuff or hasty accept later
proved bad deals.

That dictatorial guidance leads to political problems, inherent of
human being existence, putting code subscribed to who is writing it
and not to how good it is.

I think that is the major reason for so much forks and developer
desertions nowadays and for not merging potential good stuff because
of people animosity.

I believe someone very clever will soon find a way for not depending
so much of one person alone and get a way of making code evolution
happen by itself in a real distributed work flow.

> Regards,
> Jonathan

Your words value much. So I would appreciate to know your following per=
ceptions.

It is always a pleasure to talk to you and to have an opportunity to
get your always objective and balanced point-of-views.

Best regards
