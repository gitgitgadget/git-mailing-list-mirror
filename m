From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Find out on which branch a commit was originally made
Date: Sun, 19 Sep 2010 20:30:21 +0200
Message-ID: <201009192030.21659.robin.rosenberg@dewire.com>
References: <1jp0xnn.1gyr9a31jn4r7cM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?iso-8859-1?q?=C6var_Arnfj=F6r=3F?= Bjarmason" <avarab@gmail.com>,
	git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sun Sep 19 20:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxOen-0002Ox-Nk
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 20:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145Ab0ISSa0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 14:30:26 -0400
Received: from mail.dewire.com ([83.140.172.130]:14404 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753923Ab0ISSa0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 14:30:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E00A61396D8F;
	Sun, 19 Sep 2010 20:30:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8uReqYzFoZfu; Sun, 19 Sep 2010 20:30:24 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 69CB1800353;
	Sun, 19 Sep 2010 20:30:24 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-25-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <1jp0xnn.1gyr9a31jn4r7cM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156506>

l=F6rdagen den 18 september 2010 17.26.08 skrev  Stefan Haller:
> =C6var Arnfj=F6r? Bjarmason <avarab@gmail.com> wrote:
> >     You want to do X, and you think Y is the best way of doing so.
> >=20
> > Instead of asking about X, you ask about Y.
>=20
> Erm, not really; I explicitly mentioned Y as "a possible workaround"
> only.  Anyway...
>=20
> > Why do your co-workers think this is essential to the point that th=
ey
> > can't get by without it? What problem are they trying to solve?
>=20
> It's a common situation that you want to know why a certain piece of
> code is written the way it is.  So you blame it, you eventually end u=
p
> at a certain interesting changeset, and hopefully the commit message
> tells you enough about why the change was made.  If it doesn't, then =
it
> can help a lot to know a bit more about the context of the change, i.=
e.
> what topic it was part of.

What most people do (I think) is to include a reference to a ticket in =
a issue=20
tracker. JGit/EGit adds Bug:-line in the footer. Others add the ticket =
number=20
in the Subject. This much informative than a branch name.  It also allo=
ws
you to fix unrelated bugs on your branch.=20

-- robin
