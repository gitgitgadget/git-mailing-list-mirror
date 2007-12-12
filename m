From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-bisect run make -j64 kernel/ (was Re: git-bisect feature
	suggestion: "git-bisect diff")
Date: Wed, 12 Dec 2007 10:43:26 +0100
Message-ID: <20071212094326.GF18018@elte.hu>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org> <20071208152922.GB30270@elte.hu> <200712090633.36086.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 10:44:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2O8M-0005Wy-Td
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 10:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbXLLJno convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 04:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754903AbXLLJno
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 04:43:44 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:40389 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781AbXLLJnn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 04:43:43 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1J2O7q-0001we-7I
	from <mingo@elte.hu>; Wed, 12 Dec 2007 10:43:41 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 933E63E2193; Wed, 12 Dec 2007 10:43:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200712090633.36086.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68024>


* Christian Couder <chriscool@tuxfamily.org> wrote:

> Le samedi 8 d=E9cembre 2007, Ingo Molnar a =E9crit :
> > Currently, in the Linux kernel, if i do this:
> >
> >  $ git-bisect run make -j64 kernel/
> >
> > it fails with:
> >
> >  running make -j64 kernel/
> >    CHK     include/linux/version.h
> >    CHK     include/linux/utsrelease.h
> >    CALL    scripts/checksyscalls.sh
> >  bisect run failed:
> >  bisect_good exited with error code 1
> >
> > although the command "make -j64 kernel/" returns with 0.
> >
> > i have to write a script around "make -j64 kernel/" to get this to =
work
> > - it would be nice to have this "out of box".
>=20
> It seems to work for me. After creating a .config, I did:
>=20
> $ git bisect good v2.6.23
> $ git bisect bad HEAD
> $ git bisect run make -j64 kernel/
>=20
> Then I had to answer some configuration questions (I hit <enter>  eve=
rytime)=20
> but it run fine.
>=20
> My git version is:
>=20
> git version 1.5.3.7.2200.g9275-dirty

i've got: git-core-1.5.3.6-1.fc8, so it's fairly recent. I'll try this=20
later and come back to you if there's still a problem.

	Ingo
