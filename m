From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Thu, 2 Feb 2012 14:43:01 +0800
Message-ID: <CANYiYbEG+QqBQi6Xagk-bmRoz3So_f0HVtZRb8+T0f9hXcuq4w@mail.gmail.com>
References: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
	<7vr4ye15kr.fsf@alter.siamese.dyndns.org>
	<201202020111.33772.schwarzerf@gmail.com>
	<7vmx91ygst.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frederik Schwarzer <schwarzerf@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 07:43:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsqO6-0005o9-Ab
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 07:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab2BBGnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 01:43:04 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41473 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab2BBGnD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 01:43:03 -0500
Received: by ggnh1 with SMTP id h1so1028966ggn.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 22:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fsHMe2ZjWVccsLsrSa9Z4S0STWYndE1g05zQRVZVBUo=;
        b=LiDREDTqo7Yry4oP8mMrpXi0TNzMa/2GfyoDa5P5BLX45qIS3VvXdvIwGgwEF6lbfZ
         00dKqpZANcc7HCK7sIPxPctBCv1199pvET03wwSgvQuEzVvfbc6taKA/DqwfJ8GdlrT2
         lahP+eNFjqvgo2xhd3CJVTeL7x82UL4/Ub6r8=
Received: by 10.236.197.41 with SMTP id s29mr190927yhn.7.1328164981435; Wed,
 01 Feb 2012 22:43:01 -0800 (PST)
Received: by 10.236.153.195 with HTTP; Wed, 1 Feb 2012 22:43:01 -0800 (PST)
In-Reply-To: <7vmx91ygst.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189587>

2012/2/2 Junio C Hamano <gitster@pobox.com>:
> Frederik Schwarzer <schwarzerf@gmail.com> writes:
>> l10n if translations are sent, i18n if patches to improve translatio=
n
>> support in the sources are sent.
>
> Yes, that was what I was getting at.

I just sent a updated patch with the correct commit log. ;-)

>> But maybe a separate mailing list
>> might be a good idea. So people interested could be subscribed there
>> without being overwhelmed by the amount of mails in here.
>
> I personally do not think git-l10n warrants a full mailing list dedic=
ated
> to it (but see (4) below).
>

Nobody knows all languages, so a git-l10n mailing list for all translat=
ors may
lead chaos. But a mailing list for l10n coordinator to notify l10n team=
s
and for new l10n team setup maybe useful. Because this git list is some=
 busy,
may lost notifications.

> I would envision that the workflow would go like this:
>
> =A0(1) The l10n coordinator makes a fork of "git.git", and start his =
history
> =A0 =A0 at v1.7.9. =A0Let's call this the "git-po" repository.
>
> =A0(2) The l10n coordinator prepares po/git.pot and makes a commit in
> =A0 =A0 "git-po" repository. It is l10n coordinator's responsibility =
to
> =A0 =A0 maintain this file.

Yes, really needs a po/git.pot.

>
> =A0(3) There will be one l10n team for each supported locale. Jiang m=
ight
> =A0 =A0 volunteer to be the team leader for zh_CN. =A0Each team leade=
r forks
> =A0 =A0 the git-po repository. =A0Let's call this the "git-po-zh_CN" =
repository
> =A0 =A0 (there will hopefully be more, like "git-po-is", "git-po-pt_B=
R",
> =A0 =A0 etc.)

It's my honor. Last three days I setup a one file repo for l10n of zh_C=
N,
and use one wiki page (https://github.com/gotgit/git-l10n-zh-cn/wiki/Ta=
skList)
for translators to fetch/coordinate translation tasks.
Now it's time to start with a new repo with full history and files, may=
be
git-po-zh_CN for Chinese language.

>
> =A0(4) Members of each locale team work to advance their "git-po-$loc=
ale"
> =A0 =A0 history. They make changes ONLY to po/$locale.po file and NOT=
HING
> =A0 =A0 ELSE. Specifically, locale teams are NOT expected to touch po=
/git.pot
> =A0 =A0 or any source files in their "git-po-$locale" repository.

Also care about not writing commit log in native language.

>
> =A0 =A0 How the members in a locale team coordinate their work is up =
to the
> =A0 =A0 team. A large team might want to have their own mailing list,=
 and I
> =A0 =A0 wouldn't stop it.
>
> =A0(5) From time to time, each locale team asks the l10n coordinator =
to pull
> =A0 =A0 from their history, and the l10n coordinator will pull update=
d
> =A0 =A0 translations. Optionally, the locale team may want to clean u=
p their
> =A0 =A0 history before asking the l10n coordinator to pull their work=
=2E
>
> =A0(6) From time to time, the l10n coordinator will pull from "git.gi=
t" when
> =A0 =A0 meaningful number of changes are made to the translatable str=
ings. =A0I
> =A0 =A0 hope this would happen much less often than once per week, pr=
eferably
> =A0 =A0 much less frequently. The l10n coordinator updates po/git.pot=
 and
> =A0 =A0 makes a commit, and notifies the l10n teams.

notifies the l10n teams using another mailing list maybe.

> =A0(7) The l10n teams will pull from "git-po" to get the updated po/g=
it.pot
> =A0 =A0 file and will work on updating their "git-po-$locale" reposit=
ory (go
> =A0 =A0 back to step (4) above).
>
> =A0(8) From time to time, the l10n coordinator will ask me to pull fr=
om
> =A0 =A0 "git-po" repository.
>
> One possible mechanism to use might be to host all of these at GitHub=
, to
> leverage their service for all the "forking" and "requesting pull" ab=
ove,
> as well as intra-team communication.

Use GitHub organization account is highly recommended.
I wrote a open e-book (in Chinese) on this:
http://www.worldhello.net/gotgithub/04-work-with-others/030-organizatio=
n.html

> And i18n patches that modify the _() markings in the source code, wil=
l
> only go through "git.git" tree in the normal channel, IOW, this maili=
ng
> list.

Yeah,  works on the codes but not the po files still send to this list.

--=20
Jiang Xin
