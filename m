From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 11:37:58 +0200
Message-ID: <20091209093758.GA2977@redhat.com>
References: <20091208144740.GA30830@redhat.com> <7vfx7lcj18.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Dec 09 10:41:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIJ2Z-0007qt-CF
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 10:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbZLIJkr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 04:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbZLIJkr
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 04:40:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49180 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552AbZLIJkq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 04:40:46 -0500
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB99eg2N011842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 9 Dec 2009 04:40:43 -0500
Received: from redhat.com (vpn2-9-43.ams2.redhat.com [10.36.9.43])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nB99ee1l001307;
	Wed, 9 Dec 2009 04:40:41 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134952>

On Wed, Dec 09, 2009 at 09:47:56AM +0100, Peter Krefting wrote:
> Junio C Hamano:
>
>> Many people wanted to have "pick many commits onto the current HEAD"=
=20
>> and I think it would be a natural, uncontroversial and welcome addit=
ion=20
>> to allow "git cherry-pick A..B".
>
> Or even "git cherry-pick branch", as I na=EFvely tried doing before I=
 =20
> understood what it did. This is definitely a feature that would help =
me.
>
> The question of where it goes is actually a bit difficult, it is the =
same=20
> mode of operation as "git rebase", only the other way around. It is t=
he=20
> same as "git cherry-pick", but called multiple times. And it is the s=
ame=20
> as "git merge --squash", but without squashing the commits into one.
>
> So does this new mode go into rebase, cherry-pick or merge, or into a=
ll =20
> three? No matter which, proper documentation is needed.
>
>
> Maybe this could also be used to implement a "git merge --squash A..B=
",=20
> a.k.a a "partial merge".

What exactly should it do?

> (And if it could be implemented to allow a "git=20
> merge A..B" and later do a "git merge B" to merge the rest of the=20
> side-branch, that would be interesting).

rebase already tries to detect previously applied commits.
Maybe we can teach it to use more heuristics.

> --=20
> \\// Peter - http://www.softwolves.pp.se/
