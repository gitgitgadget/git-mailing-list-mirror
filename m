From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 20:01:03 +0100
Message-ID: <20130609190103.GG22905@serenity.lan>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
 <20130609171810.GA10858@goldbirke>
 <CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
 <20130609173342.GB2091@goldbirke>
 <20130609173739.GF22905@serenity.lan>
 <CAMP44s1F5O3vjHuL=cGys=p_dbnnE-f-Mv+j5Q1ZbyVAJCjLSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:01:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulkrj-0006Lm-BD
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164Ab3FITBS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 15:01:18 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:45511 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab3FITBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:01:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A5A82CDA5AF;
	Sun,  9 Jun 2013 20:01:16 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RRzM+2QLbYRK; Sun,  9 Jun 2013 20:01:16 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 00D27CDA595;
	Sun,  9 Jun 2013 20:01:05 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMP44s1F5O3vjHuL=cGys=p_dbnnE-f-Mv+j5Q1ZbyVAJCjLSA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227099>

On Sun, Jun 09, 2013 at 12:53:38PM -0500, Felipe Contreras wrote:
> On Sun, Jun 9, 2013 at 12:37 PM, John Keeping <john@keeping.me.uk> wr=
ote:
> > On Sun, Jun 09, 2013 at 07:33:42PM +0200, SZEDER G=E1bor wrote:
> >> On Sun, Jun 09, 2013 at 12:23:01PM -0500, Felipe Contreras wrote:
> >> > On Sun, Jun 9, 2013 at 12:18 PM, SZEDER G=E1bor <szeder@ira.uka.=
de> wrote:
> >> > > On Sun, Jun 09, 2013 at 11:40:22AM -0500, Felipe Contreras wro=
te:
> >> > >> We should free objects before leaving.
> >> > >>
> >> > >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> > >
> >> > > A shortlog-friendlier subject could be: "sequencer: free objec=
ts
> >> > > before leaving".
> >> >
> >> > I already defended my rationale for this succinct commit message=
:
> >> >
> >> > http://thread.gmane.org/gmane.comp.version-control.git/225609/fo=
cus=3D225610
> >>
> >> Your arguments were unconvincing.  The mere fact that I raised thi=
s
> >> issue unbeknownst to the earlier posting clearly shows that there'=
s
> >> demand for descriptive subjects.
> >
> > Not to mention that with your subject no body is needed, making the
> > overall message more succinct.
>=20
> It's not succinct at all, because there's no short and quick
> description of what the patch actually is; a trivial fix.

Is it not equally succinct to say "fix memory leak"?

> > When reading a log, as soon as I see "trivial" I become suspicious =
that
> > someone is trying to cover something up, much like "left as an exer=
cise
> > for the reader".  If the subject says "fix memory leak" then it's
> > obvious what the patch is meant to do, and when there is no subtlet=
y to
> > be explained (as there isn't in this patch) there is no need for a =
body.
>=20
> You are not a rational person then. The commit message has absolutely
> no bearing on the quality of the code. If you are less suspicious of =
a
> commit message that says "fix memory leak", you are being completely
> biased.
>
> Whether the commit message says "fix memory leak", or "trivial fix",
> or "foobar", the code might still be doing something wrong, and you
> can't decide that until you look at the code.

I have a certain level of trust that commit summaries in git.git will b=
e
accurate.  If I want to know what has changed, then "fix memory leak"
implies "no functional change"; if I see "trivial fix" then how do I
know what that is?  It could be a whitespace change, a fix to a memory
leak, a typo correction, a change to a separator in a message shown to
the user, or even a small change to corner case behaviour.

> If you don't care about the code, but still want to know what the
> patch is doing, then you can look at the whole commit message, and "W=
e
> should free objects before leaving." explains that perfectly.

The short message is what appears in "What's Cooking", why should I nee=
d
to break out of my mail client to find out what it means?
