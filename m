From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 09/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Sun, 24 Oct 2010 16:32:01 -0700 (PDT)
Message-ID: <m3bp6jjhhm.fsf@localhost.localdomain>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287851481-27952-10-git-send-email-Matthieu.Moy@imag.fr>
	<9A09AA7C-BAE2-4571-8453-17CB3F3256D4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com, Jonathan Nieder <jrnieder@gmail.com>
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 01:32:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAA2s-0007Bh-Pv
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 01:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab0JXXcF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 19:32:05 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55347 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0JXXcD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Oct 2010 19:32:03 -0400
Received: by ewy7 with SMTP id 7so3714771ewy.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 16:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=fTzXYn2QzxYJ76EddoO83sP1uPpB+JwRFHSjDrjNCyE=;
        b=a/NAdSXy75gOK+gJEPL0sEHjZDZ3tUGNwhJuUmLWyDMB/0OkiLM+lvWPImvbWVfuzx
         Tz9h5BwCHKVkPXn+uMr0fTdBwoOErshL6c6E5c8b7tWxQX2bkWHNPk28HpPBq5jfclJ6
         OT1vrMnq8h8vqtRlXvGv4bR65rZI1B9WlYiWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=L7mW27ElnvHk4RMo7GvG73Y081fHW/x2OLDFspmfwQK9sIZ38gPGHk6j5o/TgyHFIE
         2vmWjSNh0ruQZQjlWs2FzIb0FMwpZBa5z9snhJm4rwOorExtww/m/HbzxsiGefvrF4Ev
         g0BDBJastN6wa1qUrxUFRgR+DVlBoWp/QuVo4=
Received: by 10.213.113.144 with SMTP id a16mr569915ebq.32.1287963122449;
        Sun, 24 Oct 2010 16:32:02 -0700 (PDT)
Received: from localhost.localdomain (abvu207.neoplus.adsl.tpnet.pl [83.8.218.207])
        by mx.google.com with ESMTPS id q58sm6668053eeh.3.2010.10.24.16.32.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 16:32:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9ONVPf9013293;
	Mon, 25 Oct 2010 01:31:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9ONV1uH013282;
	Mon, 25 Oct 2010 01:31:01 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <9A09AA7C-BAE2-4571-8453-17CB3F3256D4@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159894>

Thore Husfeldt <thore.husfeldt@gmail.com> writes:
> On 23 Oct 2010, at 18:31, Matthieu Moy wrote:

> > Documentation/user-manual.txt |    9 +++++++++
> > 1 files changed, 9 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/Documentation/user-manual.txt b/Documentation/user-man=
ual.txt
> > index d70f3e0..02126f1 100644
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> > @@ -359,6 +359,11 @@ $ git branch -r
> >   origin/todo
> > ------------------------------------------------
> >=20
> > +In this case, "origin" is called a remote repository, or "remote" =
for
> > +short. The branches of this repository are called "remote branches=
"
> > +from our point of view, and Git will maintain a copy of these
> > +branches, called "remote-tracking branches" in the local repositor=
y.
>=20
> No. Git does not "maintain a copy of [the remote]
> branches". It=92s exactly one of the pitfalls I fell into: that
> Git, automagically, puts the *current* state of the remote branch
> into remote/branchname, or at least updates it behind my back
> whenever it gets the chance.

So you don't like the word "maintain" here, is it?  Perhaps "keep"
instead of "maintain" would be a better word?

I guess that we can also add the following explanation:

  Those "remote-tracking branches" would be updated to the state of tra=
cked
  branches in remote repository on fetch.

> The Pro Git book goes as far as saying "they=92re moved
> automatically whenever you do any network communication," which
> is extremely misleading. (And then it goes on: "Remote branches
> act as bookmarks to remind you where the branches on your remote
> repositories were the last time you connected to them." This is a
> good way of saying it, except that "remote branches" should be
> "remote-tracking branches,"

Right

> and "connected to them" could be more concrete.)

I guess that the word 'connected' is used here to avoid repetition.
But it is a bit unprecise: "git remote show <remote>" connects to remot=
e
repository but does not update remote-tracking branches.

> Also note that the two following lines in user-manual.txt are plain
> wrong ("You cannot check out these remote-tracking branches, but you
> can examine them on a branch of your own, just as you would a tag").

This is simply outdated information, predating invention of detached
HEAD (also known as anonymous / unnamed branch).  They are not _that_
wrong, as you don't checkout a remote-tracking branch: you checkout
_state_ of remote tracking branch, creating unnamed branch for that
(state marked in git-branch output as "(no branch)").  But I guess it
is too fine distinction (splitting hairs).

>=20
> I realise that it would be more constructive for me to suggest a
> concrete improvement, but I=92m not quite there yet. I would really
> like to see a good conceptualisation, with strong, versatile verbs,
> of the relationships between bobsstuff bob/master and Bob=92s master

Nevertheless your contributions, even those in the form of pointing
errors and inconsistences, are very welcome.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
