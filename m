From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v3 0/2] Re: user-manual: general improvements
Date: Thu, 21 May 2009 15:18:02 +0200
Message-ID: <20090521131802.GA13840@vidovic>
References: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com> <20090507072326.GA13123@vidovic> <7veiv0cvdt.fsf@alter.siamese.dyndns.org> <20090508042814.GA30031@vidovic> <94a0d4530905131430q2250a43ei692265c3f32b5715@mail.gmail.com> <20090514160609.GA12910@vidovic> <7vvdnvtf2n.fsf@alter.siamese.dyndns.org> <20090521041529.GD8091@sigill.intra.peff.net> <94a0d4530905210017x1ce3e32bk3b1fbf9044377763@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 15:18:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M78A7-0006yu-3i
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 15:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbZEUNSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 09:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbZEUNSJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 09:18:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:6144 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbZEUNSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 09:18:08 -0400
Received: by fg-out-1718.google.com with SMTP id 16so379451fgg.17
        for <git@vger.kernel.org>; Thu, 21 May 2009 06:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8gZrNISSzmM41b8IiIChj7SFVJYgjBp3kXE30hy4W/8=;
        b=XB0bTaYcJ3t/otO0jvyMHGKYjZuS/PjgaPhFcAJmO5mdZDQspivQ/1EEYuNN6d/x9Q
         3mi2B4ysfGgStiqKIvb7fjNEKTsi0443DOmXBpPWE8XKs1RK5DDUTroBBwc2L+vx/H+7
         8iFrsjY3FAFIujLmUvmvodWwprbWFSAsQG86U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LVWS9qimCgfc8ocS9nAtlcDenD0H76aFKOzAf5WIcA0DKXEEipeAKT6VChXaNny3av
         mqdX/s9Kozf8k/lO9uu0QsIbjka68GchCPbY4Ol0ubxitsDzoJ722ccKwxfZSCPCCi4m
         oOeA9n9NGq6uojEb9k9Lbf8V78RiZdPuQpvi4=
Received: by 10.86.86.2 with SMTP id j2mr2188248fgb.50.1242911888273;
        Thu, 21 May 2009 06:18:08 -0700 (PDT)
Received: from @ (91-164-141-247.rev.libertysurf.net [91.164.141.247])
        by mx.google.com with ESMTPS id 3sm1018999fge.9.2009.05.21.06.18.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 06:18:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <94a0d4530905210017x1ce3e32bk3b1fbf9044377763@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119675>

The 21/05/09, Felipe Contreras wrote:
> On Thu, May 21, 2009 at 7:15 AM, Jeff King <peff@peff.net> wrote:
> > On Wed, May 20, 2009 at 06:33:36PM -0700, Junio C Hamano wrote:
> >
> >> >> http://people.freedesktop.org/~felipec/git/user-manual-general-=
improvements/
> >> >
> >> > Thank you very much Felipe to take the time to upload the patche=
s there.
> >> > I already have a copy there and I'll look at it soon.
> >>
> >> Has anybody looked at this? =A0It's a bit large-ish and touches al=
l over the
> >> place, so I am finding it a bit hard to concentrate on it myself r=
eally
> >> nitpicking, but from the cursory look after formatting the result =
looked
> >> Ok.
> >
> > I started to, but the first commit message is lacking something tha=
t I
> > think would make reviewing much simpler: what are the general class=
es of
> > changes that are being made?
> >
> > I see some doublequotes becoming backticks, and some becoming singl=
e
> > quotes. And some becoming tex-quotes (``...''), and even some becom=
ing
> > doublequotes _with_ single quotes. It would be easier to verify tha=
t
> > they are doing the right thing if the commit message briefly descri=
bed
> > the rules it followed for changing each one. I think they are somet=
hing
> > like:
> >
> > =A0- tex-quotes if it was really a prose-style quotation
> >
> > =A0- backticks (causing monospace) for branch names, commands, etc =
in
> > =A0 =A0prose
> >
> > but that leaves me confused. Some things which I thought should be =
in
> > monospace backticks are in single-quotes (causing emphasis). Like
> > 'master' or 'linux-2.6'. And some things are emphasized and in doub=
le
> > quotes in the prose, like '"o"' or '"branch A"'. What is the rule t=
o
> > decide which text should have visible doublequotes but also be
> > emphasized, as opposed to just having double-quotes or just being
> > emphasized?
> >
> > Maybe this was even discussed earlier in the thread (I didn't go ba=
ck to
> > look), but it should definitely be part of the commit message.

Agreed.

> The rule I followed is: change it to whatever looks best.
>=20
> I followed some guidelines such as: make common text monospace, such
> as gitk and master. And emphasize whatever needs emphasizing, such as
> fb47ddb2db. Examples are both monospace *and* emphasized.
>=20
> Sometimes the end result still didn't look good so I just used
> whatever looked best.

IHMO, "what looks best" is not the best way to enhance the user manual
because it may be somewhat confusing.

Without being as strict as in the manpages we should have good rules to
display the commands, branch names, etc to the end-users all over the
manual (think SYNOPSIS). For example, all branch names in the text coul=
d
be "italic, green, without quotes". Now, in the paragraph "Fetching
individual branches" we have

  will create a new branch named '"example-master"' and store in it the
  branch named '"master"' from the repository at the given URL.  If you
  already have a branch named 'example-master', it will attempt to

where the branch name /example-master/ has two different occurences _wi=
th_
and _without_ quotes.


This is for the end user part. For the contributers, the commit could s=
ay:

" - branch names: uses the form 'branch-name' to appear in green,
    italic.
  - file names: uses [...] to appear in [...]
  - refspec: uses [...] to appear in [...]
  - etc.
"

> Have you actually looked at the end result?

Yes, I think it's much better with your patch but "display-types" shoul=
d
follow the same rules all over the text.


I'm missing of time theses days. I think I'll could help you in one or
two weeks I you want. It's an ant work. :-)
AFAICT, some people here want to rewrite the manual, right? Maybe it
could be done with this rewriting?

--=20
Nicolas Sebrecht
