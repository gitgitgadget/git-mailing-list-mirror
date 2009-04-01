From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 08:50:07 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49D32ABF.11569.30BC41@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49CCE520.17260.2586E134@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49CCD90F.6090707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: "Etienne Vallette d'Osia" <dohzya@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 08:52:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LouJA-0000RH-4G
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 08:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758605AbZDAGut convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2009 02:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757023AbZDAGut
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 02:50:49 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([194.94.155.53]:9195 "EHLO
	rrzmta2.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756562AbZDAGus convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 02:50:48 -0400
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id B2DFFC3ACC;
	Wed,  1 Apr 2009 08:50:44 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTP id 9906CC1FCC;
	Wed,  1 Apr 2009 08:50:44 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n316ob0u030778;
	Wed, 1 Apr 2009 08:50:37 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    1 Apr 09 08:50:36 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 1 Apr 09 08:50:14 +0100
In-reply-to: <49CCD90F.6090707@gmail.com>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589357@20090401.064840Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115342>

On 27 Mar 2009 at 14:47, Etienne Vallette d'Osia wrote:

> Ulrich Windl a =E9crit :
> > AFAIK, "committing" in git is "kind of publishing your work" (other=
s may pull it).=20
> > I don't like publishing my mistakes ;-) Even if no-one pulls the co=
mmit, your=20
> > "undo" refers to "committing a fix for the last committed mistake",=
 right? Again,=20
> > I don't really want to document/archive (i.e. commit) my mistake. O=
r did I miss=20
> > something here?
> > I know: Other's opinions are quite different on these issues.
>=20
> commit is local.

I had made the experience that you can "pull" from a local directory (u=
nless=20
permissions forbid it). As I can't control what others are doing, a "co=
mmit" is=20
still more or less making the results public (unless you can convince m=
e that=20
	I'm wrong). OK, I grew up with servers that host hundreds of users, no=
t with=20
having my own laptop...

> The good way is to commit in your local and private repository.
> Then you can do anything, reset commit you have just done, etc
> When all is ok, you push in a public repository.
>=20
> With this workflow, no one see your local work and you can commit ver=
y=20
> often, undo commit, rebase a lot etc.
>=20
> The only result of a such job is a large number of useless objects in=
=20
> your local repository. They will be delete automatically by git, so i=
t's=20
> not a problem.
>=20
> Regard,
> Etienne
