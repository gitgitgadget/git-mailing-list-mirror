From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 16:59:58 +0100
Message-ID: <1219766398.7107.87.camel@pmac.infradead.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	 <1219664940.9583.42.camel@pmac.infradead.org>
	 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	 <20080826145719.GB5046@coredump.intra.peff.net>
	 <1219764860.4471.13.camel@gaara.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, users@kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 18:02:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY0yw-0001kd-Fm
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 18:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbYHZQAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2008 12:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbYHZQAR
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 12:00:17 -0400
Received: from casper.infradead.org ([85.118.1.10]:49106 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbYHZQAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 12:00:16 -0400
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KY0xc-0008Sy-9S; Tue, 26 Aug 2008 16:00:00 +0000
In-Reply-To: <1219764860.4471.13.camel@gaara.bos.redhat.com>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93752>

On Tue, 2008-08-26 at 11:34 -0400, Kristian H=C3=B8gsberg wrote:
> It's pretty normal to see opponents of a decision like this complain
> loudly when it lands on their system, whereas the silent majority in
> favour will be happy to see the change finally implemented but reluct=
ant
> to stir up the discussion again.
>=20
> I don't think new arguments are brought to the discussion, just new
> people, who are temporarily inconvened by a change towards sanity.

Nice emotive response, especially the subtle but unsubstantiated 'silen=
t
majority in favour' bit -- but you forgot the part where you were
supposed to actually point out a tangible benefit which is achieved by
breaking compatibility like this.

And no, reducing the size of /usr/bin by a tiny fraction isn't really a
worthwhile benefit -- in reality, the 'silent majority' really couldn't
give a monkey's left testicle about that, and breakage caused by the
gratuitous change _far_ outweighs any minuscule improvement.

It's particularly silly because we could have just made these aliases
optional but present by default, so those few nutters who _really_ spen=
d
their days worrying about such stuff can do without them.

--=20
David Woodhouse                            Open Source Technology Centr=
e
David.Woodhouse@intel.com                              Intel Corporatio=
n
