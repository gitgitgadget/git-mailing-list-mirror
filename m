From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/6] bash: Hide diff-stages from completion.
Date: Mon, 5 Feb 2007 16:10:05 -0500
Message-ID: <20070205211005.GB8908@spearce.org>
References: <20070205204424.GB8824@spearce.org> <eq85t5$t2n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 22:10:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEB6d-0002LF-1A
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 22:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933455AbXBEVKL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Feb 2007 16:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933459AbXBEVKK
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 16:10:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37255 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933455AbXBEVKJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Feb 2007 16:10:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEB66-0001fk-Tm; Mon, 05 Feb 2007 16:09:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C854E20FBAE; Mon,  5 Feb 2007 16:10:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <eq85t5$t2n$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38791>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
>=20
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0diff-stages) =A0 =A0 =
=A0: nobody uses it;;
>=20
> I'd rather say: plumbing. (Try not to be cute in the code, please. Th=
at
> results in ent axing ;-)

Did you miss my 'ask gittus' description for applymbox?  ;-)

Its only documentation for why this item is being omitted.
But this table needs to die; its 62 lines long and is updated
by hand independent of the other command lists which ship with
core Git.  The same is true of the config option completion list,
that is ~70 lines.

What's with your mail client anyway?  The leading whitespace in
my patch is showing up here as some horrible non-ASCII character,
but I know those were two tabs indenting that line.

--=20
Shawn.
