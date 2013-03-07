From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Thu, 7 Mar 2013 12:05:51 +0100 (CET)
Message-ID: <1938485067.193912.1362654351290.JavaMail.root@openwide.fr>
References: <CALeLG_=YQDrgMfOoR_GyNRexWxDqQGhFubmaYwM6pqXJuLnO6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 12:06:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDYeR-0005KT-N9
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 12:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278Ab3CGLFy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 06:05:54 -0500
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:48138 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235Ab3CGLFx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Mar 2013 06:05:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 0CA6828068;
	Thu,  7 Mar 2013 12:05:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DmL0U98S9c86; Thu,  7 Mar 2013 12:05:51 +0100 (CET)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 7290528065;
	Thu,  7 Mar 2013 12:05:51 +0100 (CET)
In-Reply-To: <CALeLG_=YQDrgMfOoR_GyNRexWxDqQGhFubmaYwM6pqXJuLnO6A@mail.gmail.com>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC25 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217592>

>=20
> Hi J=C3=A9r=C3=A9my,
>=20
> Git subtree ignores tags from the remote repo.
>=20

is that a design decision or a case of "not implemented yet"

> To follow a project in a subdirectory I would use git-subtree add
> selecting a branch, not a tag, from the other repo. Then use
> git-subtree pull to keep yourself updated.
>=20


well... yes, but releases are marked by tags, not branches so what I re=
ally want is a tag.

I still use git so I have the possibility to update and can traceback w=
hat happened later

> e.g.
>=20
> To add:
>=20
> git subtree add --prefix=3D$subdir $repo $branch
>=20
> Then to update:
>=20
> git subtree pull --prefix=3D$subdir $repo $branch
>=20


ok, that probably works with branches (didn't test)

> If you make any changes on the branch and wanted to push them back
> you
> could do that with:
>=20
> git subtree pull --prefix=3D$subdir $repo2 $branch2
>=20
> $repo2 and $branch2 would be different from $repo and $branch if you
> wanted to push to your own fork before submitting a pull request.
>=20

shouldn't there be a subtree split somewhere ? IIUC pull is only merge =
from the remote to my local repo,
not the other way round


> --
> Paul [W] Campbell
>=20
