From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 01/10] refs: add "for_each_bisect_ref" function
Date: Fri, 27 Mar 2009 01:41:57 +0100
Message-ID: <200903270141.57426.chriscool@tuxfamily.org>
References: <20090326055509.1bc16b28.chriscool@tuxfamily.org> <49CBA42D.3000404@drmicha.warpmail.net> <alpine.DEB.1.00.0903261748280.12753@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 01:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln0Bi-0003PL-3L
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 01:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762673AbZC0AnD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 20:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762100AbZC0AnB
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 20:43:01 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:40689 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932590AbZC0AnA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 20:43:00 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id C0F0A4C8038;
	Fri, 27 Mar 2009 01:42:50 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 516484C8072;
	Fri, 27 Mar 2009 01:42:47 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0903261748280.12753@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114835>

Le jeudi 26 mars 2009, Johannes Schindelin a =E9crit :
> Hi,
>
> On Thu, 26 Mar 2009, Michael J Gruber wrote:
> > Christian Couder venit, vidit, dixit 26.03.2009 08:48:
> > > Le jeudi 26 mars 2009, Sverre Rabbelier a =E9crit :
> > >> A 10 patches series with no cover letter?
> > >
> > > I am not a big fan of cover letters. Usually I prefer adding comm=
ents
> > > in the patches.
> >
> > I'm sorry I have to say that, but your individual preferences don't
> > matter. Many of us would do things differently, each in their own w=
ay,
> > but people adjust to the list's preferences. It's a matter of attit=
ude.
> > So, please...
>
> Actually, a better way to ask for a cover letter would have been to
> convince Christian.  So I'll try that.

Thanks.

As you know, I have been sending patches since nearly 3 years ago to th=
is=20
list. And it's only since a few weeks ago that I am asked to send cover=
=20
letters...

> From the patch series' titles (especially when they are cropped due t=
o
> the text window being too small to fit the indented thread), it is no=
t
> all that obvious what you want to achieve with those 10 patches.
>
> From recent discussions, I seem to remember that you wanted to have s=
ome
> cute way to mark commits as non-testable during a bisect, and I furth=
er
> seem to remember that Junio said that very method should be usable
> outside of bisect, too.

Well, we want to move "git bisect skip" code from shell (in "git-bisect=
=2Esh")=20
to C. So this patch series does that by creating a new "git bisect--hel=
per"=20
command in C that contains the new code and using that new command=20
in "git-bisect.sh".

> Unfortunately, that does not reveal to me, quickly, what is the curre=
nt
> state of affairs, and what you changed since the last time.

Yeah, I should have at least put something in the comment section of my=
=20
first patch in this series.

And I try to improve, you know, I even tried to use "git send-email" ag=
ain=20
this morning to see if perhaps I could use it to send my patch series.

I did:

$ git send-email --compose --dry-run bh15/*
Can't call method "repo_path" on an undefined value=20
at /home/christian/libexec/git-core//git-send-email line 160.

and then I gave up, because I don't like spending a lot of my free time=
 to=20
fight with tools I don't like.

If someone knows some other tools that can easily send a threaded patch=
=20
series, I will try to see if I can use them...

Thanks in advance,
Christian.
