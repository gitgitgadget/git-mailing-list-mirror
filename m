From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2011, #02; Sun, 6)
Date: Sun, 06 Nov 2011 12:52:58 -0800 (PST)
Message-ID: <m3sjm12cty.fsf@localhost.localdomain>
References: <7vehxl57lt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 21:54:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN9k1-0004kG-EO
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 21:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab1KFUxA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 15:53:00 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46230 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab1KFUxA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 15:53:00 -0500
Received: by faao14 with SMTP id o14so4508344faa.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 12:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=EBIsFpygQhTFxlcqTTISdWvxfAfBxXUn7zRjh+k/VFA=;
        b=RLDEdLdVgvutNhnUBpPjONnL40PtIVkP1AEI5vz1jirXmFv8zbkmpoEt6ud4zrfG3d
         y9Cl2e6noY71uWmFrIn/QuVVBjYwVl7Y0rt8ywKj+eQ76WQhc0mv0rY1QHem0jB/t4/W
         iMiTHAQNqbpnpVEVOz0xsYGj7dfM95lWJ/Nv0=
Received: by 10.223.76.217 with SMTP id d25mr41586375fak.31.1320612778883;
        Sun, 06 Nov 2011 12:52:58 -0800 (PST)
Received: from localhost.localdomain (aehn151.neoplus.adsl.tpnet.pl. [79.186.195.151])
        by mx.google.com with ESMTPS id a8sm28308766faa.11.2011.11.06.12.52.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 12:52:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pA6Kqfc7001212;
	Sun, 6 Nov 2011 21:52:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pA6KqPZb001205;
	Sun, 6 Nov 2011 21:52:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vehxl57lt.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184934>

Junio C Hamano <gitster@pobox.com> writes:

> With maint, master, next, pu, todo:
>=20
>         git://git.kernel.org/pub/scm/git/git.git
>         git://repo.or.cz/alt-git.git
>         https://code.google.com/p/git-core/
>         https://github.com/git/git
>=20
> With only maint and master:
>=20
>         git://git.sourceforge.jp/gitroot/git-core/git.git
>         git://git-core.git.sourceforge.net/gitroot/git-core/git-core
>=20
> With all the topics and integration branches but not todo, html or ma=
n:
>=20
>         https://github.com/gitster/git
>=20
> I will stop pushing the generated documentation branches to the above
> repositories, as they are not sources. The only reason the source
> repository at k.org has hosted these branches was because it was the =
only
> repository over there that was writable by me; it was an ugly histori=
cal
> and administrative workaround and not a demonstration of the best
> practice.

Errr... haven't you *actually stopped* pusing generated documentation
to 'html' and 'man' branches to above repositories?  They are not
present anymore (I had to update my pre-separate-remotes config).
=20
> These branches are pushed to their own separate repositories instead:
>=20
>         git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
>         git://repo.or.cz/git-{htmldocs,manpages}.git/
>         https://code.google.com/p/git-{htmldocs,manpages}.git/
>         https://github.com/gitster/git-{htmldocs,manpages}.git/

You can always put the fommowing in .git/config:

  [remote "git-manpages"]
  	url =3D git://git.kernel.org/pub/scm/git/git-manpages.git
  	fetch =3D +refs/heads/master:refs/remotes/origin/man
 =20
  [remote "git-htmldocs"]
  	url =3D git://git.kernel.org/pub/scm/git/git-htmldocs.git
  	fetch =3D +refs/heads/master:refs/remotes/origin/html


> --------------------------------------------------
[...]
> * jn/gitweb-side-by-side-diff (2011-10-31) 8 commits
>  - gitweb: Add navigation to select side-by-side diff
>  - gitweb: Use href(-replay=3D>1,...) for formats links in "commitdif=
f"
>  - t9500: Add basic sanity tests for side-by-side diff in gitweb
>  - t9500: Add test for handling incomplete lines in diff by gitweb
>  - gitweb: Give side-by-side diff extra CSS styling
>  - gitweb: Add a feature to show side-by-side diff
>  - gitweb: Extract formatting of diff chunk header
>  - gitweb: Refactor diff body line classification
>=20
> Replaces a series from Kato Kazuyoshi on the same topic.

Thanks.


Sidenote : is there need for wupport for word-diff in gitweb?
If yes, then navigation as in above series i.e.

    inline | _side-by-side_

where current style is not linked would be better than alternative,
i.e. just

   _side-by-side_

or

   _inline_
=20
depending on what style you use.

--=20
Jakub Nar=EAbski
