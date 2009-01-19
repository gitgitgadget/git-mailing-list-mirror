From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH/RFC] shortlog: add option to group together different
	names/emails of an author
Date: Mon, 19 Jan 2009 15:11:07 +0100
Message-ID: <20090119141107.GA27992@chistera.yi.org>
References: <1231600589-11811-1-git-send-email-dato@net.com.org.es> <20090119134346.GA27509@chistera.yi.org> <alpine.DEB.1.00.0901191445340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 19 15:13:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOurm-0005rO-Gr
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 15:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbZASOLN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 09:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbZASOLN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 09:11:13 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4531
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbZASOLM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 09:11:12 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 696A4801C0E4;
	Mon, 19 Jan 2009 15:11:08 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LOuqJ-0007Kz-IX; Mon, 19 Jan 2009 15:11:07 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901191445340.3586@pacific.mpi-cbg.de>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106360>

* Johannes Schindelin [Mon, 19 Jan 2009 14:49:39 +0100]:

> > Ping? I realize this may be seen as a big patch dropped out of the =
blue,
> > but I would very much like to hear some comments on at least the fe=
ature
> > itself, which should not take more than reading the commit message.

> This is such a huge change, for something that not many people want. =
=20
> Actually, you seem to be the first.

That's, uhm, sad. (I don't really buy the "not many people want it,
hence we should not include it" argument, unless by people you mean
"people who could do a review". No hard feelings, though.)

> And you could just as well write a script that takes the output of

> 	$ git log --pretty=3Dformat:%an\ %ae --all | sort | uniq

> and constructs a valid .mailmap.  That would also have the advantage =
that=20
> you do not need to perform the analysis each time you call Git.

No, not really. As mentioned in the commit message, .mailmap files don'=
t
help when you invoke shortlog with -e, and different email addresses fo=
r
an author are involved.

> All these reasons make me believe that your patch should not be appli=
ed.

Okay, I'll let go.

Cheers,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
Mankind are very odd creatures: one half censure what they practice, th=
e
other half practice what they censure; the rest always say and do as
they ought.
                -- Michel de Montaigne
