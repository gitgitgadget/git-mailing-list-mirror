From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: Checkout tag?
Date: Sun, 22 Jan 2012 12:31:15 +0100
Message-ID: <20120122113115.GA31545@jpl.local>
References: <1327226753653-7213023.post@n2.nabble.com>
 <20120122101116.GA31022@jpl.local>
 <1327227956026-7213061.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Abscissa <bus_nabble_git@semitwist.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 12:59:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Row4w-00007s-NY
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 12:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139Ab2AVL6y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jan 2012 06:58:54 -0500
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:59422 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab2AVL6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 06:58:53 -0500
X-Greylist: delayed 1654 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jan 2012 06:58:53 EST
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 8DC5CD9F2
	for <git@vger.kernel.org>; Sun, 22 Jan 2012 12:31:18 +0100 (CET)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApZOAPryG09T46eEPGdsb2JhbABDiVCkUBkBAQEBNzKBcgEBBAEyASMjBQsLNBIUGAEMChoTh3wCtz6LQ2MElRiSUA
X-IronPort-AV: E=Sophos;i="4.71,551,1320620400"; 
   d="scan'208";a="1794953604"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb4.telenor.se with ESMTP; 22 Jan 2012 12:31:15 +0100
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 35A43422B3; Sun, 22 Jan 2012 12:31:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1327227956026-7213061.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188963>

On Sunday, January 22, 2012 at 11:25 CET,
     Abscissa <bus_nabble_git@semitwist.com> wrote:

> I saw that, but it seems to imply that it's not a simple:
>=20
> >git checkout tag_name
>=20
> because of the required <pathspec>, whatever that is.

It isn't required. The part of the manual that I quoted (from Git
1.7.2.5) indicated that the pathspec is mandatory, but looking at
the command synopsis at the top of the man page it's actually listed
as optional.

Looking at an up to date Git 1.7.9-rc2 man page, it still seems
slightly inconsistent with itself. The synopsis at the top says

      git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]

while the text in the DESCRIPTION section says

      git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...

The DETACHED HEAD section of the man page contains an example of
checking out a tag, by the way.

If you're doubtful, why don't you just create a tag and try things
out for yourself?

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
