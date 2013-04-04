From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: RFC: Very useful script to SVG graph the git commits from a
 file orientated view
Date: Thu, 4 Apr 2013 14:46:57 +0200 (CEST)
Message-ID: <759444160.1179815.1365079617652.JavaMail.root@openwide.fr>
References: <CAHQ6N+qLbrBKWhq8OGKco+JxiiLVOQvW09j3rLeZw265POZuMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 14:47:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNjZh-0004Up-L1
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 14:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760213Ab3DDMq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Apr 2013 08:46:59 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:48708 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759889Ab3DDMq7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Apr 2013 08:46:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 4E343280AA;
	Thu,  4 Apr 2013 14:46:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yR9onZ0ygJFf; Thu,  4 Apr 2013 14:46:57 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id C05E728001;
	Thu,  4 Apr 2013 14:46:57 +0200 (CEST)
In-Reply-To: <CAHQ6N+qLbrBKWhq8OGKco+JxiiLVOQvW09j3rLeZw265POZuMw@mail.gmail.com>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC26 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219998>

very usefull indeed, where can I find it ? I have a big rebase/merge/re=
organise work that is comming soon and that is going to be tremendously=
 usefull...

    Cordialement

    J=C3=A9r=C3=A9my Rosen

fight key loggers : write some perl using vim

----- Mail original -----
> Hi,
>   I made this script to help me see the logical connections between
> commits.  It produces a .svg graph showing the commits that affected
> a
> file.
>=20
> For example, say you have the commits:
>=20
> commit1 - modify hello.c
> commit2 - modify goodbye.c
> commit3 - modify hello.c and goodbye.c
>=20
> It will draw a graph showing the first two commits as siblings, and
> commit3 as a child of commit1 and commit2.
>=20
> I have found this very useful when squashing and rebasing development
> branches that have got a lot of "fix typo" and "fix"  type commit
> messages.  From the graph you can quickly see which commit they were
> fixing (the parent, in the graph).
>=20
> Here is an example output, running it on kwin for the last 100
> commits:
>=20
> $ graph_git.pl --nofiles -100
>=20
> http://imagebin.org/252754
>=20
> And again with files for the last 10 commits:
>=20
> $ graph_git.pl -10
>=20
> http://imagebin.org/252756
>=20
> (Note that it has tooltips)
>=20
> JohnFlux
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
