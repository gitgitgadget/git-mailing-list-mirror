From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: moving a remote branch?
Date: Thu, 17 Jun 2010 15:02:14 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483CEEB16@xmail3.se.axis.com>
References: <AANLkTikA5jGl1LiU2sNTN1NP_syTfPAeLF7sS6dBozyN@mail.gmail.com>
	<AANLkTimTSU7Db7cMlC0ZxQ47IoBUr4Ee4G-GfgDoYLmK@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC74483CEEA82@xmail3.se.axis.com>
 <AANLkTikeLpvGA-RFBdMGblOnhNKJ6dUrpUZQlENMP51A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Anderson <zelnaga@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 15:02:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPEjk-0002K1-0R
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 15:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab0FQNCX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 09:02:23 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:37394 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab0FQNCX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 09:02:23 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o5HD2Gg8027908;
	Thu, 17 Jun 2010 15:02:16 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 17 Jun 2010 15:02:16 +0200
Thread-Topic: moving a remote branch?
Thread-Index: AcsOFnrrlg+g13UBRh6UlKdFweZs7AABaybw
In-Reply-To: <AANLkTikeLpvGA-RFBdMGblOnhNKJ6dUrpUZQlENMP51A@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149304>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Nazri Ramliy
> Sent: den 17 juni 2010 14:13
> To: Peter Kjellerstedt
> Cc: Thomas Anderson; git@vger.kernel.org
> Subject: Re: moving a remote branch?
>=20
> On Thu, Jun 17, 2010 at 4:28 PM, Peter Kjellerstedt=20
> > Renaming a remote branch is a two step operation. First you push th=
e
> > old branch into its new name, and then you remove the old branch. I=
t
> > can be done with these commands:
> >
> > =A0 =A0 =A0 =A0git push origin origin/featurea:refs/heads/featureb
> > =A0 =A0 =A0 =A0git push origin :featurea
>=20
> I'd like to add (more confusion!:) with this clarification:
>=20
> The two push operation above rename the branch on the remote side.
> It does not affect any of your local branches.

No, it does not affect any local branches, but it _does_ effect=20
the representation of the remote branches in the local repository.

> If you do "git branch -a" then you'd still see the
> "origin/zelnaga/featurea" branch.

No, you will not (at least not with git 1.7.1 that I use).=20

Neither do you need to do the two steps below as the two pushes=20
above are enough to also keep the status of the remote branches=20
in sync in the local repository..

> Doing a "git fetch origin" will get the newly renamed branch from the
> remote repo and create a local version of it on your local repo.
>=20
> At this point you can do "git branch -D origin/featurea".
>=20
> nazri

//Peter
