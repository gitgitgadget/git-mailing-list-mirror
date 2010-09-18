From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Find out on which branch a commit was originally made
Date: Sat, 18 Sep 2010 17:26:08 +0200
Message-ID: <1jp0xnn.1gyr9a31jn4r7cM%lists@haller-berlin.de>
References: <AANLkTiknoBS7x2za3qzghfS0TD6UUL83eoZz7LFBPUuc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: avarab@gmail.com (=?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?=)
X-From: git-owner@vger.kernel.org Sat Sep 18 17:26:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwzJ9-0001rk-72
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 17:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab0IRP0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 11:26:13 -0400
Received: from mail.ableton.net ([62.96.12.115]:45181 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab0IRP0N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 11:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=CBwe1XaebBsH7XBRvhQXoKQmzzTdCGnu/HdTQoEHSYs=;
	b=UZwKvP3u/Sl3TeDjKTgVI2+EaT+n1lSnpKgBQFrLYGUAk2m21w0mvixwu9q/y4aM66xbhdtzxtWPqxgMGGDGhm965DeVl97YeHUu1tddoO0cdp262uu67/9sXcLWB5oaUgkGrEr/VKTlNJ1CGxfvyRyRN0Lh3Khf5YtyLM2liG4=;
Received: from [10.1.15.231]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OwzHd-0001ms-8w; Sat, 18 Sep 2010 17:24:57 +0200
In-Reply-To: <AANLkTiknoBS7x2za3qzghfS0TD6UUL83eoZz7LFBPUuc@mail.gmail.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156461>

=C6var Arnfj=F6r? Bjarmason <avarab@gmail.com> wrote:

>     You want to do X, and you think Y is the best way of doing so.
> Instead of asking about X, you ask about Y.

Erm, not really; I explicitly mentioned Y as "a possible workaround"
only.  Anyway...

> Why do your co-workers think this is essential to the point that they
> can't get by without it? What problem are they trying to solve?

It's a common situation that you want to know why a certain piece of
code is written the way it is.  So you blame it, you eventually end up
at a certain interesting changeset, and hopefully the commit message
tells you enough about why the change was made.  If it doesn't, then it
can help a lot to know a bit more about the context of the change, i.e.
what topic it was part of.

> What Git *does* track however when you do `git merge topic` is the
> name of the `topic` branch you're merging into some other branch,
> e.g. here (from git-merge(1)):
>=20
>                      A---B---C topic
>                     /         \
>                D---E---F---G---H master
>=20
> Even though A B and C might have been commited on branches called
> `blah`, `bluh` and `blarghl` you'll never know. You'll just know that
> someone put them all together on a branch called `topic` and that
> someone later merged that into master in the main repository. E.g.:
>=20
>     Merge: A G
>     Author: Some Guy <some-guy@example.com>
>     Date:   <....>
>=20
>         Merge branch 'topic'
>=20
> From there you can *infer* that A-B-C came from the topic branch,

OK, that's pretty much the same as what I had in mind.  (We're
simple-minded, so for us "original branch" and topic branch is the same
most of the time.)

The question is the same though: if I hit commit B while blaming, how d=
o
I know what topic it was a part of?  For that, I need to find commit H
which will tell me, right?  How do I do that?

-Stefan


--=20
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
