From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Wed, 11 Oct 2006 00:40:20 +0200
Message-ID: <200610110040.21235.jnareb@gmail.com>
References: <20061010221458.85789.qmail@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 00:42:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXQIm-0003WI-3D
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 00:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbWJJWkv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Oct 2006 18:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030622AbWJJWkh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 18:40:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:10538 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030617AbWJJWjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 18:39:16 -0400
Received: by ug-out-1314.google.com with SMTP id o38so10503ugd
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 15:39:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PVKQa3FafaSg9DK+DZAjJmo9pPh1NVjJ5unfxaD4GqEcsFYJ+kBQFvIza5gNKjumoEfuANs5/mP0WDk7PVQpJyKIU4A49BivAkG07RIsvQYAtdNxgl629+Wo5NTCPYIgl7Zs5FXLNvKlSfiiW5Dq90sGjbPu/B282ZsxKKmzHkI=
Received: by 10.66.240.12 with SMTP id n12mr71711ugh;
        Tue, 10 Oct 2006 15:39:14 -0700 (PDT)
Received: from host-81-190-20-194.torun.mm.pl ( [81.190.20.194])
        by mx.google.com with ESMTP id j3sm48916ugd.2006.10.10.15.39.14;
        Tue, 10 Oct 2006 15:39:14 -0700 (PDT)
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <20061010221458.85789.qmail@web31804.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28683>

Dnia =B6roda 11. pa=BCdziernika 2006 00:14, Luben Tuikov napisa=B3:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
> > Luben Tuikov wrote:
> > > P.S. Notice how there is a "snapshot" link on each line of
> > > shortlog, but there is no "snapshot" link in the nav bar
> > > of a=3Dcommit. The "snapshot" link is next to "tree" down
> > > in the commit data. There is also a "tree" link which is also
> > > in the navbar, but "shortlog" is missing.
> >=20
> > The problem with snapshot is that we can have snapshot of a commit
> > (and all links in the top part of navigation bar till now deals wit=
h=20
> > current commit), and snapshot of a tree, which can be subdirectory
> > (and all links in the bottom part of navigation bar deals with=20
> > the views/presentations of a current object).
>=20
> Oh, yes, that's exactly what we need: two links of the same name
> ("snapshot") in the top row of navbar and in the bottom row of navbar=
=2E

I'm mentioning the problem, that "snapshot" has two meaning for a tree.
I personally think that we should have commit snapshot links (with=20
commit sha in the extended tar header if we use tgz snapshots) for=20
"heads", "tags" and "project list" views, and perhaps in the "commit"=20
and optionally "commitdiff" view; perhaps but not necessary for each=20
commit-list view like log, shortlog, search, history. But the snapshot=20
link should be as a view of a (sub)directory only in the bottom part of=
=20
navigation bar.

--=20
Jakub Narebski
Poland
