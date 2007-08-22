From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: splitting large patch files into smaller ones
Date: Wed, 22 Aug 2007 23:54:04 +0200
Message-ID: <46CCB07C.9010200@lsrfire.ath.cx>
References: <200708221929.l7MJTgiL012452@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erez Zadok <ezk@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INy9J-0005rR-4a
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 23:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbXHVVx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 17:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbXHVVx5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 17:53:57 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:53009
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932080AbXHVVx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 17:53:56 -0400
Received: from [10.0.1.201] (p508ED4CF.dip.t-dialin.net [80.142.212.207])
	by neapel230.server4you.de (Postfix) with ESMTP id 47D5D8B008;
	Wed, 22 Aug 2007 23:53:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200708221929.l7MJTgiL012452@agora.fsl.cs.sunysb.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56425>

Erez Zadok schrieb:
> I recently had an occasion to take a rather large git-diff patch, and=
 split
> it into smaller chunks.  This was so I can more easily import the pat=
ches
> into guilt, then reorder, rename, shuffle, and join individual patch
> snippets into logical patches (i.e., one patch per topic).
>=20
> I was looking around for a tool that would allow me to split a large =
patch
> file into individual snippets and couldn't find one.  So I wrote one =
in
> perl.  It takes a patch file and creates individual small files, one =
for
> each combination of a filename listed in the patch, and a patch snipp=
et
> (starting with an '@@' line).  Each '@@' snippet gets an index number=
 and a
> new filename, prefixed with the appropriate header ("diff ...", ---, =
and +++
> lines) so it's a valid patch file on its own.
>=20
> Questions:
>=20
> 1. Does anyone know of such a tool, perhaps written in C for better s=
peed?

The patchutils collection[1] contains a tool called splitdiff, which
does something slightly different[2].  It might be a good starting
point, though.

Ren=E9


[1] http://cyberelk.net/tim/software/patchutils/?page_id=3D10
[2] http://cyberelk.net/tim/patchutils/man/splitdiff.html
