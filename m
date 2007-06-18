From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: how to move with history?
Date: Mon, 18 Jun 2007 22:43:26 +0200
Message-ID: <200706182243.27068.robin.rosenberg.lists@dewire.com>
References: <20070618191607.GK3037@cs-wsok.swansea.ac.uk> <20070618194907.GA12445@steel.home> <20070618202918.GM3037@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Mon Jun 18 22:42:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0O3d-0004RF-6Q
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 22:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763705AbXFRUmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 18 Jun 2007 16:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764093AbXFRUmj
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 16:42:39 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29775 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1760382AbXFRUmi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 16:42:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AC8368030D6;
	Mon, 18 Jun 2007 22:35:54 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04286-07; Mon, 18 Jun 2007 22:35:54 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 598E2802AA8;
	Mon, 18 Jun 2007 22:35:54 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070618202918.GM3037@cs-wsok.swansea.ac.uk>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50409>

m=E5ndag 18 juni 2007 skrev Oliver Kullmann:
> > Git does not keep "renaming history". It does not have to, as it ke=
eps
> > how your project looked at each commit (point in history).
>=20
> For my purposes, that is a bad thing, since I want to get rid off som=
e parts
> of the history (specifically I want to eliminate some files from hist=
ory),
> as explained in that last paragraph in my e-mail (with the motivation=
):
>=20
> Is this possible in git?
>
> And is it possible to add the history of some file to the history
> of another file (in the above application this would be the renamed
> file) ?

Git does not keep file histories at all. As a consequence it does not t=
rack renames
either.

The history in Git is the history of the *whole* tree as a chunk, not a=
 sum of file histories.=20
It takes snapshots of your project, that's all. Then there are tools to=
 do magic on top of=20
that (e.g. git-blame).

There are tools to rewrite histories, but then you are violating of=20
the key principles of git, that history is immutable so git may not be =
nice to=20
you after history rewriting. Cogito has a powerful command.

-- robin
