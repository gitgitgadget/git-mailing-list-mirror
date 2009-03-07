From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: fetch and pull
Date: Sat, 7 Mar 2009 03:00:56 -0500
Message-ID: <3e8340490903070000t2780764cocfbf28d538037df5@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A115E0D@EXCHANGE.trad.tradestation.com>
	 <m3iqmmidlf.fsf@localhost.localdomain>
	 <7vd4cus7ez.fsf@gitster.siamese.dyndns.org>
	 <450196A1AAAE4B42A00A8B27A59278E70A115F5D@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 09:05:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfrXe-0004Fc-4j
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 09:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbZCGIBB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 03:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbZCGIBA
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 03:01:00 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:6202 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbZCGIA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 03:00:59 -0500
Received: by yw-out-2324.google.com with SMTP id 5so498661ywh.1
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 00:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LjF1JhswGz9EoX6IO9yIbwYEQy1uzXA+k/xdXtz/B0o=;
        b=daOtgY17A9Hgt4b/7EqRmHtzB8UT1mQEk2vE2ON21Hy/WXmq4Jsg3dMuZi9fT24njr
         BOjfwXFKaoSoIXCOY/ijSvZJqR4UjjoqjM5xYPinbNKP4tpRiboSGQtTbVQFYcOB9zKL
         fCRCgk4oSw4EWqyJemvP0+yf2s0KTm0deUBGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KxB8LCnzvfvcgXB90OR182C2ElzgYcHb5jerVgeq9UIjDzS/6i/ia5TW7gYxXJmr0c
         ZUreCVEev21XLSmDTOKiVK/9EjCVrRVyq1X5PWZki9JEY3LUz9w0qGyUXKlv25WANQoy
         L8od6E4L2WdRNkIltlPGcFs3szPjLCtF6UaHo=
Received: by 10.220.72.200 with SMTP id n8mr1155992vcj.16.1236412857069; Sat, 
	07 Mar 2009 00:00:57 -0800 (PST)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A115F5D@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112517>

On Fri, Mar 6, 2009 at 5:11 PM, John Dlugosz <JDlugosz@tradestation.com=
> wrote:
> =3D=3D=3DRe:=3D=3D=3D
>> There was patch series adding support --ff=3Donly, but I think it di=
dn't
>> made into git... =A0Hmmm...
>
> I do not think it has much to do with the main point of what John wan=
ts
> to
> do which is to muck with local branch without checking it out, which =
is
> only possible when it happens to fast forward to the new tip of the
> corresponding branch obtained from the the remote.
> =3D=3D=3Dend=3D=3D=3D
>
> It occurs to me that maybe my concept is off, if it is being so
> difficult.
>
> Here is what I'm "cooking":
>
> =3D=3D=3D=3D=3D=3Dexcerpt=3D=3D=3D=3D=3D=3D
>
> To keep apprised of other people's work, including updates to the mai=
n
> dev branch, start the day with:
>
> =A0 =A0 =A0 =A0git fetch
>
> This will update your "remote tracking branches", letting you see wha=
t
> everyone else is working on, and letting you see the central
> repository's dev (as remotes/origin/dev) compared to your own local d=
ev,
> so you can see what has been added.
>
> This does not change your local dev, or any other branches you are
> using. =A0As for your own topic branches, you are the only one who ch=
anges
> them. =A0This is a perfectly safe command and can be performed any ti=
me to
> update your view of what's happening throughout the team.
> You will, in particular, see your local dev where you last left it, a=
nd
> the current remotes/origin/dev pointing ahead of it. =A0E.g.
>
> =A0 =A0 =A0 =A0A <=3D=3D dev
> =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0B--C--D <=3D=3D remotes/origin/dev
>
> In this example, you see plain "dev" still pointing to A, and
> "remotes/origin/dev" pointing to D. =A0So, you can tell that B, C, D =
were
> added. =A0Review the nodes B, C, and D, by reading the comments and s=
eeing
> which files were affected, and look deeper if it seems to affect what
> you are doing. =A0Finally, issue the command
>
> =A0 =A0 =A0 =A0???
>
> And this will update your local dev to match the origin.
>
> =3D=3D=3D=3D=3D=3D
>
> Basically, instead of mysterious "can't push" messages, the idea is t=
hat
> people can feel good about 'fetch' as refreshing their view of the
> central repo, so gitk can show them how the central dev (and other
> branches) differs from their own.

If the local "dev" is a topic branch, you'd want to either merge or
rebase with the origin's dev branch. Rebasing is probably best if
you've not published the branch yet (unless you'd prefer proper merge
history on it).

If the local "dev" is meant to just track the remote, you really ought
to avoid doing anything very involved in it (unless you're planning on
merging something into it and pushing the result, that is!). If
there's no local changes, then you can just pull with impunity, and
let it fast-forward - or use git merge or git rebase if you've already
fetched and don't want to spend the few seconds it takes to ask the
server if there's anything new :)

=46inally, if you really, truly, definitely want to blow away the
current branch and replace it with another one, you can use git reset
--hard. This will throw away (irretrievably) local uncommitted
changes, and force the current branch to point to the specified one.

Remember, you can undo most things using the reflog if you mess up,
including unwanted merges, git reset --hard (committed changes only)
etc.
