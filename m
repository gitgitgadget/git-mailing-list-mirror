From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Libification project (SoC)
Date: Sat, 17 Mar 2007 01:22:58 -0400
Message-ID: <20070317052258.GB5731@spearce.org>
References: <20070316042406.7e750ed0@home.brethil> <etfjb1$uof$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, lcapitulino@mandriva.com.br
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 06:24:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSROi-0001YM-Ak
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 06:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045AbXCQFXz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 17 Mar 2007 01:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933342AbXCQFXz
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 01:23:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48409 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933045AbXCQFXy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2007 01:23:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HSRNc-0000dS-H9; Sat, 17 Mar 2007 01:23:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D403C20FBAE; Sat, 17 Mar 2007 01:22:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <etfjb1$uof$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42424>

Jakub Narebski <jnareb@gmail.com> wrote:
> [Cc: git@vger.kernel.org]
>=20
> Luiz Fernando N. Capitulino wrote:
>=20
> > =A0 =A0 o Documentation (eg, doxygen)
>=20
> I wonder if documenting and finishing documentation of git storage st=
ructure
> (format description of: loose objects, packs, pack indices, index, re=
fs and
> symbolic refs, packed refs) and git protocols (git protocol descripti=
on,
> local/ssh fetch/push pipeline description), perhaps using RFC or RFC-=
like
> notation could (and should) be made part of libification effort...

I would consider that out of scope for this project.

It would be nice if someone did this work, or at least dusted
off "A Large Angry SCM"'s document and made that available in the
Documentation/technical folder.  But I don't think it should be part
of the Libification SoC project, or any of our other current ideas.

Users of a public API don't need to know the internal formatting
of an object within a packfile.  They do however need to know that
a commit has a tree, and 0-n parents.  And that's already covered
in our existing docs.


And *please* stop breaking the CC chains Jakub.  We've asked you
to not do that.  I had to go lookup Luiz' email address so I could
get him back onto it.

--=20
Shawn.
