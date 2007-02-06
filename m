From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 04:39:07 -0500
Message-ID: <20070206093907.GD10508@spearce.org>
References: <20070206023111.GB9222@spearce.org> <eq9hvs$l9m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 10:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEMnL-0007X9-Tq
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 10:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbXBFJjR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 6 Feb 2007 04:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbXBFJjR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 04:39:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55689 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbXBFJjQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Feb 2007 04:39:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEMnA-0006ND-9V; Tue, 06 Feb 2007 04:39:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3B80C20FBAE; Tue,  6 Feb 2007 04:39:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <eq9hvs$l9m$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38826>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
>=20
> > --depth=3D<n>::
> > =A0=A0=A0=A0=A0=A0=A0=A0Maximum delta depth, for blob and tree delt=
ification.
> > =A0=A0=A0=A0=A0=A0=A0=A0Default is 10.
>=20
> Does it support --window=3D<n> option?

No.  It probably never will.  I don't see a reason to add it.
Heck, --depth is probably not a great knob to have either.  At
least not in gfi.

--=20
Shawn.
