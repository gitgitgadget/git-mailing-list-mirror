From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: FW: Query on git submodules
Date: Tue, 2 Jun 2015 13:17:21 +0200
Message-ID: <20150602111720.GB7442@book.hvoigt.net>
References: <4C328B7D13677A4EAF715D0755A6D7EE25C56C89@irsmsx110.ger.corp.intel.com>
 <4C328B7D13677A4EAF715D0755A6D7EE25C589BF@irsmsx110.ger.corp.intel.com>
 <20150526170125.GC31115@book.hvoigt.net>
 <4C328B7D13677A4EAF715D0755A6D7EE25C5AD9E@irsmsx110.ger.corp.intel.com>
 <loom.20150602T113612-540@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mattias =?iso-8859-1?Q?Vannerg=E5rd?= 
	<mattias.vannergard@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 13:17:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzkC0-0002oR-CZ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 13:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbbFBLRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 07:17:08 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:42788 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbbFBLRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 07:17:06 -0400
Received: from [31.17.191.210] (helo=book.hvoigt.net)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YzkBt-0007KO-3v; Tue, 02 Jun 2015 13:17:05 +0200
Content-Disposition: inline
In-Reply-To: <loom.20150602T113612-540@post.gmane.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270523>

On Tue, Jun 02, 2015 at 09:45:39AM +0000, Mattias Vannerg=E5rd wrote:
> I am planning on using submodules in a way, where I can specify a=20
> configuration of repos with tags, and rebuild the submodule tree, whe=
n=20
> selecting a configuration on the top level.
>=20
> But, yet I have found no easy way to select the tag in a subrepo. I=20
> would like the .gitmodules to accept tag instead of branch. I think=20
> there is very little difference between specifying a branch or a tag,=
=20
> but it is more convenient to have the release version as a tag.
>=20
> So, if a product A, consist of subcomponents a1, a2 and a3, the versi=
on=20
> v1.1 of product A will have a configuration saying: a1, tag=3Dv0.4; a=
2,=20
> tag=3Dv1.0; a3, tag=3Dv2.0
>=20
> Subcomponent can be both a pre-built binary or a shared/common source=
=20
> base, or a complete 3rd party repository.
>=20
> Is this comparable to your situation?
>=20
> I am currently working on editing the git-submodules to add -t (as in=
=20
> tag). I need to find an easy way to switch between tracking a branch =
and=20
> locking to tag, though.

What exactly is the feature of using a tag instead of a commit id like =
it
is currently the default? A tag should be nailed to a commit anyway or
does it change in your situation? In that case I would say it is a
branch.

Cheers Heiko
