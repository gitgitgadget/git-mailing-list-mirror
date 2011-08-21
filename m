From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Sun, 21 Aug 2011 14:37:47 -0700
Message-ID: <CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
	<CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
	<7vvctvdf5r.fsf@alter.siamese.dyndns.org>
	<CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
	<CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
	<CAE1pOi2r9DT3Y-GxivTZRaNVi=qLOy5=QpQ-_YysOkgqy3iGRQ@mail.gmail.com>
	<CAMOZ1BvpnP_729YOHrrPW3B8wa5c4cLyD_qAQ5rTuy0JqNiiXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 23:37:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvFiL-0006Qk-Sq
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 23:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab1HUVht convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 17:37:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51252 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab1HUVhs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 17:37:48 -0400
Received: by gwaa12 with SMTP id a12so2631381gwa.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 14:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XwPCGm4/A0Lu3tmFyN1Qr9r9jOAV3IRkyi1hg5xqcNc=;
        b=nyxGfTxDUJbRgdUZnfrfm/XaSjlrtGcIrwyLW40aI8EhHUC0uaT3Pd0JF1nGwWBCY8
         gacRE2h5h46Rm1BU3xKq1EpAkLfqppD92LEdEu5UUOO4lAz7a89Vjeb8lPmETMtYv2PV
         UxhS//pFrOrqXsG0uYPGtnujKWstrUBLZKEwA=
Received: by 10.236.136.167 with SMTP id w27mr9770304yhi.102.1313962667367;
 Sun, 21 Aug 2011 14:37:47 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Sun, 21 Aug 2011 14:37:47 -0700 (PDT)
In-Reply-To: <CAMOZ1BvpnP_729YOHrrPW3B8wa5c4cLyD_qAQ5rTuy0JqNiiXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179817>

On 21 August 2011 13:53, Michael Witten <mfwitten@gmail.com> wrote:
> On Sun, Aug 21, 2011 at 13:42 -0700, Hilco Wijbenga
> <hilco.wijbenga@gmail.com> wrote:
>> Isn't a branch simply a way to track changes separately?
>
> Well, what does that mean, really? You can certainly use branches to
> help you achieve that goal.

It means my commits are chained together separate from, say, master.

> In git usage, a `branch' is just a human-readable name for any given
> commit object; it points to a commit object, and you can change to
> which commit it points. Furthermore, to help you work with commit
> lineages, some of the git machinery updates these branches (or
> `pointers', if you like) automatically (for instance, when you make a
> new commit object with `git commit', then the `current branch' is
> updated to point to the newly created commit object).
>
> Of course, 2 different branches may be used to point to the same comm=
it object.
>
> You should really think of your repository as a giant web of commit
> objects (or, more technically, as a directed acyclic graph where each
> node is a commit object); a commit object can point 'backwards'
> towards its parent commit objects. A branch (like `master') just
> points to one of these commit objects at any given time (that is, a
> branch just gives a nice human-readable label by which to reference
> one of these commit objects at any given time).

Yes, I agree with all of that (especially the last sentence). I don't
see how it changes the concept of a branch is, though. You are, I
think, simply listing the technical implementation.

> See here too:
>
> =C2=A0http://slashdot.org/comments.pl?sid=3D2350536&cid=3D36903136

Because of the revision number you have to go "the wrong way". Any
single commit can have many children but a branch only points to a
single, unique commit (or at least that's how I understand it).

I feel like we're talking in circles. I get (and even agree with) what
you're saying but I don't see how it changes the concept of a branch.

In any case, what I'm more interested in is knowing whether we can
(optionally) add state (i.e. untracked/ignored files and unstaged
changes) to a branch.
