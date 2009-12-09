From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 13:06:10 +0100
Message-ID: <20091209120610.GA29430@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
 <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
 <20091209093758.GA2977@redhat.com>
 <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
 <20091209112237.GA27740@atjola.homenet>
 <m2pr6ocqrb.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Dec 09 13:06:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NILJI-0000ft-3S
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 13:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbZLIMGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 07:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755319AbZLIMGM
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 07:06:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:57593 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755354AbZLIMGL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 07:06:11 -0500
Received: (qmail invoked by alias); 09 Dec 2009 12:06:17 -0000
Received: from i59F5468C.versanet.de (EHLO atjola.homenet) [89.245.70.140]
  by mail.gmx.net (mp029) with SMTP; 09 Dec 2009 13:06:17 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19rkMRzrMBrGGb0EJ8pMJ1Q5uN+E3Lo/cbQL4lCBF
	nBk++OqzssuCW/
Content-Disposition: inline
In-Reply-To: <m2pr6ocqrb.fsf@igel.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134961>

On 2009.12.09 12:48:24 +0100, Andreas Schwab wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > Err, no. "git merge --squash foo" merges all changes from the merge=
 base
> > of HEAD and foo up to foo. "git cherry-pick foo" takes just the cha=
nges
> > from foo^ to foo. For example:
> >
> > A---B---C (master)
> >  \
> >   D---E---F (foo)
> >
> > git cherry-pick foo # Tries to create a new commit with the changes=
 from
> >                     # "git diff D F"
>=20
> Did you mean "git diff E F"?

Ugh, yes, of course. Thanks.

Bj=F6rn
