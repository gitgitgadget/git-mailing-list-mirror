From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Preserving branches after merging on ancestor
Date: Sat, 7 Nov 2009 14:31:01 +0100
Message-ID: <20091107133101.GB9303@atjola.homenet>
References: <26217077.post@talk.nabble.com>
 <20091105223004.GA3224@progeny.tock>
 <20091105232848.GA1939@atjola.homenet>
 <20091106010947.GB4425@progeny.tock>
 <20091106021038.GA27206@atjola.homenet>
 <20091106050353.GA8824@progeny.tock>
 <1257520877359-3959325.post@n2.nabble.com>
 <c94f8e120911061941l1fb62d84g9a5ba3f1a00d9156@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rhlee <richard@webdezign.co.uk>, git@vger.kernel.org
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 14:31:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6lNp-0001EC-Di
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 14:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbZKGNbA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 08:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbZKGNbA
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 08:31:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:60594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751800AbZKGNa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 08:30:59 -0500
Received: (qmail invoked by alias); 07 Nov 2009 13:31:03 -0000
Received: from i59F55CCF.versanet.de (EHLO atjola.homenet) [89.245.92.207]
  by mail.gmx.net (mp041) with SMTP; 07 Nov 2009 14:31:03 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19iufVGouRiUerZqOsavInSjF+e3j+iKIQtWNH+Ae
	T1SA//3YbBVroo
Content-Disposition: inline
In-Reply-To: <c94f8e120911061941l1fb62d84g9a5ba3f1a00d9156@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132364>

On 2009.11.07 09:11:11 +0530, Dilip M wrote:
> On Fri, Nov 6, 2009 at 8:51 PM, rhlee <richard@webdezign.co.uk> wrote=
:
>=20
> > Hi John, Bj=F6rn and Eric,
> >
> > Thank you very much for your replies from which I gained a lot
> > insight about git merging and different workflows.
> >
> > Yes, I have tried out --no-ff and it does the job for me.
> > (Incidentally, doing that take it look neater in git gui as all the
> > master nodes appear on top of each other. Using empty commits, the
> > merged branches appear on top the master nodes in the graph.)
>=20
> Thanks to Richard, John, Bj=F6rn, and Eric.
>=20
> I had a similar _confusion_ looking looking at graph. I always use
> "log --graph --pretty=3Doneline". Now I have _opted_ to pull/merge wi=
th
> '--no-ff', to keep the graph plain and simple for non-power users :)

Just be careful with that. There are situations in which you clearly
don't want --no-ff, see the "working on a topic branch on multiple
boxes" example I gave in the mail I sent a minute ago. ;-)

Bj=F6rn
