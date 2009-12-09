From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 09:47:56 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
References: <20091208144740.GA30830@redhat.com> <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 09:48:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIIDi-0006Ap-Gl
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 09:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbZLIIsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 03:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbZLIIsP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 03:48:15 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:33992 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751809AbZLIIsO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 03:48:14 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id nB98lu0H009253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 Dec 2009 09:47:57 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id nB98lux2009249;
	Wed, 9 Dec 2009 09:47:56 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 09 Dec 2009 09:47:57 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134948>

Junio C Hamano:

> Many people wanted to have "pick many commits onto the current HEAD" =
and I=20
> think it would be a natural, uncontroversial and welcome addition to =
allow=20
> "git cherry-pick A..B".

Or even "git cherry-pick branch", as I na=EFvely tried doing before I=20
understood what it did. This is definitely a feature that would help me=
=2E

The question of where it goes is actually a bit difficult, it is the sa=
me=20
mode of operation as "git rebase", only the other way around. It is the=
 same=20
as "git cherry-pick", but called multiple times. And it is the same as =
"git=20
merge --squash", but without squashing the commits into one.

So does this new mode go into rebase, cherry-pick or merge, or into all=
=20
three? No matter which, proper documentation is needed.


Maybe this could also be used to implement a "git merge --squash A..B",=
 a.k.a=20
a "partial merge". (And if it could be implemented to allow a "git merg=
e A..B"=20
and later do a "git merge B" to merge the rest of the side-branch, that=
=20
would be interesting).

--=20
\\// Peter - http://www.softwolves.pp.se/
