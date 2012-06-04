From: =?ISO-8859-2?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Case insensitive when file mv
Date: Mon, 04 Jun 2012 18:35:55 +0200
Message-ID: <4FCCE3EB.4070607@web.de>
References: <D62ABB09-AB7B-474E-8CDE-579AD30C58AE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jarek <wodka.jaroslaw@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:42:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbaMC-00046c-Hy
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 18:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab2FDQmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 12:42:11 -0400
Received: from smtp-out11.han.skanova.net ([195.67.226.200]:34538 "EHLO
	smtp-out11.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752131Ab2FDQmK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 12:42:10 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2012 12:42:09 EDT
Received: from birne.lan (194.22.188.61) by smtp-out11.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4FA80EAF00A08A12; Mon, 4 Jun 2012 18:35:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <D62ABB09-AB7B-474E-8CDE-579AD30C58AE@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199147>

On 04.06.12 12:36, Jarek wrote:
> Hope it covers everything:
>=20
> $ git mv solJW.R solRandom.r
> $ git mv solRandom.r solRandom.R
> fatal: destination exists, source=3DsolRandom.r, destination=3DsolRan=
dom.R
> $ ls
> mouse_evaluator.R mouse_world.R     scenariusze.R     sol1.R         =
   sol2.R            sol3.R            solRandom.r
> $ git mv solRandom.r solRandom.R
> fatal: destination exists, source=3DsolRandom.r, destination=3DsolRan=
dom.R
> $?
> -bash: 128: command not found
> $ git mv solRandom.r solRandom.X
> $ git mv solRandom.X solRandom.R
> $ man git
> $ git --version
> git version 1.7.5.4
> $ touch abc
> $ touch Abc
> $ git add abc
> $ git add Abc
> $=20
>=20
>=20
> Didn't have time to check whether is it a known bug or already solved=
 in the latest version.
>=20
> Kind regards,
> Jaros=B3aw W=F3dka.--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hej Jarek,
That's a known limitation on case insensitve file system under Windows =
or Mac OS.
We had a diskussion about this some time ago:

<http://git.661346.n2.nabble.com/PATCH-v2-Allow-git-mv-FileA-fILEa-on-c=
ase-ignore-file-systems-td6187510.html>

/Torsten
