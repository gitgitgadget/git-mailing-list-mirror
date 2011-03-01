From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 01 Mar 2011 11:46:03 -0500
Message-ID: <1298997963.5247.30.camel@drew-northup.unet.maine.edu>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	 <20110214231920.GA24814@elie>
	 <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	 <20110227084317.GB3356@sigill.intra.peff.net>
	 <1298820840.19827.69.camel@drew-northup.unet.maine.edu>
	 <20110228230311.GA7533@sigill.intra.peff.net>
	 <AANLkTi=LPqu9zDiAJpxqC=ZCLig+aCv5ztXw668ERtH7@mail.gmail.com>
	 <op.vrnq8gk856e9f9@xman.eng.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David <bouncingcats@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	Miles Bader <miles@gnu.org>
To: Alexey Feldgendler <alexeyf@opera.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 17:53:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuSoX-0006L3-C5
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 17:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453Ab1CAQwk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 11:52:40 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:48030 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab1CAQwj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 11:52:39 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p21Gk7cU019584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 1 Mar 2011 11:46:08 -0500
In-Reply-To: <op.vrnq8gk856e9f9@xman.eng.oslo.osa>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=11
	Fuz1=11 Fuz2=11
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p21Gk7cU019584
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299602787.48322@KxQzABmMy2X2A7A0EKR8Gw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168229>


On Tue, 2011-03-01 at 10:27 +0100, Alexey Feldgendler wrote:
> On Tue, 01 Mar 2011 10:11:11 +0100, David <bouncingcats@gmail.com> wr=
ote:
>=20
> > A suggestion: could your conceptual bucket be named as "the precomm=
it".
> >
> > Motives for this suggestion are:
> > 1)  I imagine this word will be readily translatable;
>=20
> Less so than =E2=80=9Cstaging area=E2=80=9D, at least into Russian.
>=20
> Just my two cents.

I was starting to think about "commit preparation area" this morning,
but it sounds horribly long. Would "Prep area" work provided that the
longer version has already been introduced into the discussion? This
provides a similar language metaphor to "staging area" hopefully withou=
t
the translation problem.

Also, I still think that it is important to note somewhere that the way
that git handles commits is not the way that most users are likely to
imagine (the Index doesn't contain the blob objects itself; a finalized
commit is not just a bundled collection of everything as somebody might
expect; etc) so this "Prep area" is a logical space not completely
analogous to stuff found in the ".git" directory. Pretending that
complexity does not exist will not help; letting the users know that
they don't need to grok all of the details to get started is, on the
other hand, quite important.

(Reconstructing the CC list... let me know if I left you out, spammed
you, etc...)

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
