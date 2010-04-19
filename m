From: Petr Baudis <pasky@suse.cz>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 11:07:34 +0200
Message-ID: <20100419090734.GA10939@machine.or.cz>
References: <201004180246.18263.jnareb@gmail.com>
 <20100418005917.GO10939@machine.or.cz>
 <201004180324.54722.jnareb@gmail.com>
 <20100418021223.GP10939@machine.or.cz>
 <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
 <20100418223120.GB3563@machine.or.cz>
 <u2ve72faaa81004182346zdf4bd0b3m3341717b1555c0a9@mail.gmail.com>
 <vpqeiicey0d.fsf@bauges.imag.fr>
 <7vfx2rsy6y.fsf@alter.siamese.dyndns.org>
 <v2me72faaa81004190038y4aeefa80g9f60bb3b1e795e4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 11:07:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3mxH-0007e6-KD
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 11:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab0DSJHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 05:07:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45978 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863Ab0DSJHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 05:07:39 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 974DD86208E; Mon, 19 Apr 2010 11:07:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <v2me72faaa81004190038y4aeefa80g9f60bb3b1e795e4b@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145285>

On Mon, Apr 19, 2010 at 01:08:26PM +0530, Pavan Kumar Sunkara wrote:
> On Mon, Apr 19, 2010 at 12:53 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
> > On the other hand, a proposal about giving multiple clients access =
to
> > their own individual server-side checkouts (ala "workspace" in DELT=
A-V)
> > would require some mechanism to maintain the state on the server en=
d, and
> > session management would be one ingredient necessary to achieve tha=
t.

But what if I will want to give a link to my "workspace" to someone
else? You can embed workspace id in the URL, in fact you would probably
just use it instead of project name completely naturally. I still don't
see any need for sessions.

> So, why don't we do like this,
> There will be no need of session management when gitweb is installed
> in some site like repo.or.cz which needs copy'n'paste URLs
> but there will be session management when the write modules are
> enabled and when gitweb is installed locally or on intranet (basicall=
y
> when it is used to work on a repo).
>=20
> What do you say ?

I think it will be best to discuss session support (and work on
implementing it) when actual features where it is essential will
come up. So far, I'm unable to foresee them, but if we discuss it
later in conjunction with some concrete features, perhaps it will
be clearer.

> > When I heard that somebody wants to do a "write support" in gitweb,=
 I
> > naturally thought the proposal was about implementing RFC3253 using=
 git as
> > a backend. =A0I think it would be a reasonable thing to do (as oppo=
sed to
> > coming up with an ad-hoc "write support" mechanism that is not comp=
atible
> > with anybody else), but on the other hand it might be a bit too amb=
itious
> > for a one-student summer project.

I think that would be something entirely different, and IMO even
much less interesting. ;-)

--=20
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
