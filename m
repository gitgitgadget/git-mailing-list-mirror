From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] bash: support 'git notes' and its subcommands
Date: Thu, 28 Jan 2010 11:02:24 +0100
Message-ID: <201001281102.24195.johan@herland.net>
References: <1264640755-22447-1-git-send-email-szeder@ira.uka.de>
 <201001280223.35625.johan@herland.net> <20100128033039.GB15202@neumann>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?iso-8859-1?q?G=E1bor?= <szeder@fzi.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 11:02:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaRCu-0006zY-RT
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 11:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060Ab0A1KCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 05:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755062Ab0A1KCa
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 05:02:30 -0500
Received: from smtp.getmail.no ([84.208.15.66]:41204 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755036Ab0A1KC1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 05:02:27 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWY0072RBW1XK20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Jan 2010 11:02:25 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWY00BJ9BW0J400@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Jan 2010 11:02:25 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.28.94821
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <20100128033039.GB15202@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138240>

On Thursday 28 January 2010, SZEDER G=E1bor wrote:
> Hi Johan,
>=20
> On Thu, Jan 28, 2010 at 02:23:35AM +0100, Johan Herland wrote:
> > On Thursday 28 January 2010, SZEDER G=E1bor wrote:
> > > ... and it will offer refs unless after -m or -F, because these t=
wo
> > > options require a non-ref argument.
> >
> > Maybe-NAK.
> >
> > The patch is probably good in itself, and the intent is certainly g=
ood,
> > but we're currently discussing deprecating the -m/-F options to "gi=
t
> > notes edit" (see
> > http://article.gmane.org/gmane.comp.version-control.git/138215), an=
d if
> > that's where we go, there's no point "encouraging" their use by add=
ing
> > bash- completions for them...
>=20
> -m and -F are not encouraged, because they are not offered (short
> options in general are never offered by the completion script).
> However, their presence or absence is taken into account to offer
> something sensible: refs after 'git notes edit <TAB>', files after
> 'git notes edit -F <TAB>'.  Note, that I chose 'edit' here, because
> currently it's the only subcommand taking '-F', but it will actually
> work the same way with the upcoming 'add' and 'append' subcommands.

Ah, ok, then. I revoke my NAK.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
