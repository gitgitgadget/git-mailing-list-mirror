From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 14:07:48 +0200
Message-ID: <20091209120748.GI2977@redhat.com>
References: <20091208144740.GA30830@redhat.com> <7vfx7lcj18.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se> <20091209093758.GA2977@redhat.com> <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se> <20091209112237.GA27740@atjola.homenet> <m2pr6ocqrb.fsf@igel.home> <20091209120610.GA29430@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 13:13:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NILO1-0003Iv-7f
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 13:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373AbZLIMLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 07:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755372AbZLIMLF
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 07:11:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42778 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754436AbZLIMLE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 07:11:04 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB9CAXlw012971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 9 Dec 2009 07:10:33 -0500
Received: from redhat.com (vpn2-9-43.ams2.redhat.com [10.36.9.43])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nB9CAUZp012956;
	Wed, 9 Dec 2009 07:10:31 -0500
Content-Disposition: inline
In-Reply-To: <20091209120610.GA29430@atjola.homenet>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134962>

On Wed, Dec 09, 2009 at 01:06:10PM +0100, Bj=F6rn Steinbrink wrote:
> On 2009.12.09 12:48:24 +0100, Andreas Schwab wrote:
> > Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> >=20
> > > Err, no. "git merge --squash foo" merges all changes from the mer=
ge base
> > > of HEAD and foo up to foo. "git cherry-pick foo" takes just the c=
hanges
> > > from foo^ to foo. For example:
> > >
> > > A---B---C (master)
> > >  \
> > >   D---E---F (foo)
> > >
> > > git cherry-pick foo # Tries to create a new commit with the chang=
es from
> > >                     # "git diff D F"
> >=20
> > Did you mean "git diff E F"?
>=20
> Ugh, yes, of course. Thanks.
>=20
> Bj=F6rn

So this will be best written as
git cherry-pick ..foo

--=20
MST
