From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Wed, 18 Nov 2009 00:00:46 +0200
Message-ID: <94a0d4530911171400ub3b093ai668fd2404b12272f@mail.gmail.com>
References: <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
	 <20091025111438.GA11252@progeny.tock>
	 <94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
	 <4AFBF18E.7070906@drmicha.warpmail.net>
	 <20091114060600.6117@nanako3.lavabit.com>
	 <94a0d4530911161452xe82858el322a1985341bf13c@mail.gmail.com>
	 <20091117210625.6117@nanako3.lavabit.com>
	 <20091117172815.GH31767@fieldses.org>
	 <7vocn1dn5d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 23:00:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAW6Y-0004Zh-Pd
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 23:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbZKQWAn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 17:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbZKQWAm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 17:00:42 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:49572 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbZKQWAm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 17:00:42 -0500
Received: by iwn8 with SMTP id 8so396297iwn.33
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 14:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yJ004ZUKX+dt3BCnIQtg4Oh654yIfMM862ILI/G5NXI=;
        b=lhJCu6j0D+7hjmgc8nhCmavWnc7tPgRtOjVuKnhgU2t0NQE5LPLfktJmYcfl+HFvCR
         UWP++nRtyGOzhRpzgL+F4hqdJBtzAtwexLuJk5Dpx1ibpk7BMSrMYWTpEjImvh8+Ykh4
         Ao3loP6z9S037hNiuGae0r6CeZf0U+UaBr3P4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bMZTtkxNoeyEGeHNV1OPQGS0nzhZPJzZ0GEJI/egK2ekZqVpTEfTyg5gJa+oaB70xo
         wmUQrKtyZxXquhsiKLAe/kNW0bWd6WcCpQeU81D6cT3ChPehblaefoXDTYMW1FiPKQVw
         mCa3LaqxFnXQJ5bp5NHXdZtQvbdo0JzHZ0aEc=
Received: by 10.231.182.130 with SMTP id a44mr816119iba.18.1258495247043; Tue, 
	17 Nov 2009 14:00:47 -0800 (PST)
In-Reply-To: <7vocn1dn5d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133103>

On Tue, Nov 17, 2009 at 8:25 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> But we do not have to support commit-ish operations, such as "git log=
".

Right, and actuallly don't have to support WORKTREE/STAGE on all the
commands that work with the stage. For example I think 'git apply'
behaves completely different than 'git diff', since you cannot apply a
patch on top of a commit, therefore it doesn't make sense to stage
stuff as pseudo-refs; it makes sense to keep the --foo options
(although I would prefer something like --stage and --stage-only).

> It is a different story if these pseudo-refs that denote tree-ish are
> useful outside the context of "diff". =C2=A0I do not think of many co=
mmands
> that take arbitrary tree-ish other than the ones I mentioned above. =C2=
=A0Even
> though they take arbitrary tree-ish, people almost always use commit-=
ish
> with them.
>
> Which points to another issue with the approach.
>
> The original intention of these magic tokens are to make things easie=
r,
> but they actually may make things _harder_ to teach, because you have=
 to
> explain why "git log WORKTREE" does not work but "git archive WORKTRE=
E"
> does. =C2=A0Admittedly, you already have to explain your example to p=
eople
> saying "it does not work because v2.6.11 is a tree and a tree by itse=
lf
> does not have a point in history", but the thing is, v2.6.11-tree and
> v2.6.11 are oddballs, and you do not have to give that explanation ve=
ry
> often, simply because the users are not exposed to a raw tree.
>
> But WORKTREE and STAGE tokens are _meant_ to be exposed to them much =
more
> prominently. =C2=A0That's the whole point of the "git diff STAGE WORK=
TREE"
> proposal.
>
> People would become aware that they are very different from ordinary
> commits, and then eventually they will realize that they are not even
> trees [*1*].
>
> At that point, I suspect that these magic tokens become larger UI war=
ts
> themselves; they behave differently from everything else that is spel=
led
> in all caps (e.g. HEAD, ORIG_HEAD, MERGE_HEAD).

That could be easily fixed by making explicit in the syntax that these
are not typical refs: i.e. @stage and @work.

--=20
=46elipe Contreras
