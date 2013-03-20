From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: git merge <tag> behavior
Date: Wed, 20 Mar 2013 19:04:42 +0100
Organization: OPTEYA
Message-ID: <1363802682.6289.46.camel@test.quest-ce.net>
References: <1363704914.6289.39.camel@test.quest-ce.net>
	 <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:05:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINO2-0003JL-En
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503Ab3CTSEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 14:04:52 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:41947 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757027Ab3CTSEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:04:51 -0400
Received: from [192.168.20.20] (unknown [37.161.174.182])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 0DF369402D0;
	Wed, 20 Mar 2013 19:04:43 +0100 (CET)
In-Reply-To: <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.4 (3.4.4-2.fc17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218633>

Hi,

Le mardi 19 mars 2013 =C3=A0 09:19 -0700, Junio C Hamano a =C3=A9crit :
> Yann Droneaud <ydroneaud@opteya.com> writes:
>=20
> > 1) there's no mention of the git merge <tag> behavior in git-merge.=
1

> Yes; we welcome documentation patches.
>=20

Sent.

> > 2) git merge <tag> VS git merge <object-id>
> >
> > If <tag> is an object (not a lightweight/reference tag), git merge =
<tag>
> > ...
> > But, if you use the tag object-id instead of its name, for example =
using
> > git merge `git parse-rev <tag>`,
[EDIT]
> > signature is not checked. Git still create a merge commit, but does=
n't
> > prepare a commit message with the tag message and the signature:
> >
> > It would be great to have Git using the tag message and check the
> > signature.
>=20
> Perhaps, but if you feed the $(git rev-parse v1.12.2) to merge, your
> subject will not be able to say "Merge tag 'v1.12.2'" in the first
> place, so I do not think you would want to encourage such usage in
> the first place.

I think if someone want to merge the tag object-id instead of the tag,
the commit subject/message should probably not make a reference to the
tag.

The only use case for such tag merging by commit-id would be to get
consistent behavior in case of tag deletion. The named tag could be
recreated to point to another point in time. So when looking at the
merge commit message and searching for the tag (by name) could be
misleading.

PS: and what about my third issue ?

Regards.

--=20
Yann Droneaud
OPTEYA
