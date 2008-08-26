From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 19:20:39 +0200
Message-ID: <20080826192039.5ffa6eec@hyperion.delvare>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	<1219664940.9583.42.camel@pmac.infradead.org>
	<alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	<20080826145719.GB5046@coredump.intra.peff.net>
	<1219764860.4471.13.camel@gaara.bos.redhat.com>
	<1219766398.7107.87.camel@pmac.infradead.org>
	<20080826182349.0a1a75e2@hyperion.delvare>
	<s5hvdxnlnzi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Woodhouse <dwmw2@infradead.org>,
	Kristian =?ISO-8859-1?B?SPhn?= =?ISO-8859-1?B?c2Jlcmc=?= 
	<krh@redhat.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:22:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2FF-0001Zn-PZ
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920AbYHZRVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2008 13:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756903AbYHZRVN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:21:13 -0400
Received: from zone0.gcu-squad.org ([212.85.147.21]:45907 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857AbYHZRVM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Aug 2008 13:21:12 -0400
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1KY3Cq-0008WH-9N
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Tue, 26 Aug 2008 20:23:52 +0200
In-Reply-To: <s5hvdxnlnzi.wl%tiwai@suse.de>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93771>

On Tue, 26 Aug 2008 18:50:25 +0200, Takashi Iwai wrote:
> At Tue, 26 Aug 2008 18:23:49 +0200,
> Jean Delvare wrote:
> >=20
> > On Tue, 26 Aug 2008 16:59:58 +0100, David Woodhouse wrote:
> > > On Tue, 2008-08-26 at 11:34 -0400, Kristian H=F8gsberg wrote:
> > > > It's pretty normal to see opponents of a decision like this com=
plain
> > > > loudly when it lands on their system, whereas the silent majori=
ty in
> > > > favour will be happy to see the change finally implemented but =
reluctant
> > > > to stir up the discussion again.
> > > >=20
> > > > I don't think new arguments are brought to the discussion, just=
 new
> > > > people, who are temporarily inconvened by a change towards sani=
ty.
> > >=20
> > > Nice emotive response, especially the subtle but unsubstantiated =
'silent
> > > majority in favour' bit -- but you forgot the part where you were
> > > supposed to actually point out a tangible benefit which is achiev=
ed by
> > > breaking compatibility like this.
> > >=20
> > > And no, reducing the size of /usr/bin by a tiny fraction isn't re=
ally a
> > > worthwhile benefit -- in reality, the 'silent majority' really co=
uldn't
> > > give a monkey's left testicle about that, and breakage caused by =
the
> > > gratuitous change _far_ outweighs any minuscule improvement.
> >=20
> > Reducing /usr/bin in size was totally worthwhile. Maybe not to you,=
 but
> > to the silent majority I am a proud member of, it was. (I'm not say=
ing
> > that the path that was taken to get there was optimal, just that th=
e
> > goal was sound.)
> >=20
> > I just can't think of any other tool which installs over 100 binari=
es
> > (or scripts, that's the same) in /usr/bin. Can you?
>=20
> netpbm has almost 300 in /usr/bin.

Ouch. (I guess I shouldn't have asked.)

Does netpbm do anything convert (ImageMagick) doesn't? I'd be happy to
get rid of netpbm.

(Sorry for getting off-topic.)

--=20
Jean Delvare
