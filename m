From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Sun, 21 Aug 2011 12:48:32 -0700
Message-ID: <CAE1pOi3F8SxJLhg5bzWNoH_3Bg4vHh7BEoJWW6Em9GvPaoxTVw@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
	<CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
	<7vvctvdf5r.fsf@alter.siamese.dyndns.org>
	<CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
	<20110818044555.GA20752@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 21:54:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvE5p-0003Mt-35
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 21:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab1HUTse convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 15:48:34 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45841 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab1HUTsd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 15:48:33 -0400
Received: by gya6 with SMTP id 6so3176051gya.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 12:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fYn1U1HC0QkHJgWGoWzHmEeRqkZQ4vpYH0PFQiQttY0=;
        b=FcZjwSkCwBSmrFrTem1ZO41vLR+mI4/DCi3o8LUJ1tbPidf4O+naGZ/EznvaoFZaHZ
         t6O3GSGRL7FYFfSnWvSlGrUcofnS8O+HyKr707J5fJxRqUdiQHYHpFnkDW8c5BKXzl20
         ytJwntkIFPJjQBWf31Gz2JNhIh9G5FyOLr1AU=
Received: by 10.236.181.135 with SMTP id l7mr9485188yhm.85.1313956112738; Sun,
 21 Aug 2011 12:48:32 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Sun, 21 Aug 2011 12:48:32 -0700 (PDT)
In-Reply-To: <20110818044555.GA20752@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179809>

Hi Jonathan,

On 17 August 2011 21:45, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Hilco,
>
> Hilco Wijbenga wrote:
>
>> It would be really nice, though, if Git could somehow
>> "stash" such files when checking out a different branch. In general,=
 I
>> would prefer if uncommitted changes and untracked and/or ignored fil=
es
>> stuck to the branch where they were created.
>
> This is just a random guess, but: wouldn't it be convenient in this
> workflow to have a separate worktree for each branch you are working
> on? =C2=A0That way, switching branches would not carry over unwanted =
state
> or throw away valuable state, clobber timestamps that "make" pays
> attention to, etc.
>
> If I am understanding correctly, then the git-new-workdir script
> from contrib/workdir might help. =C2=A0(Note, though, that it comes w=
ith
> some caveats. =C2=A0A quick mailing list search should find them.)

Yes, both a separate clone and git-new-workdir (which I've just
started using) would work.

I'm not entirely happy with this solution, though. It means having to
create an Eclipse workspace per branch, this is a *lot* of work. (This
is mostly Eclipse's fault but still.) One of the exceedingly
attractive features of Git is the easy branching and merging.
Branching is now no longer easy. :-(

I assume it would be possible for Git to move untracked/ignored files
out of the way when checking out a different branch? (And moving them
back in when going back to that branch.) Are there any objections to
doing this? I.e. would it be a bad idea for some reason?

So, in essence, would it be possible (and desirable) to associate
untracked/ignored files with a particular branch? And only show them
when that branch is checked out?
