From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] git-clone.txt: document that pushing from a shallow
	clone may work
Date: Tue, 3 Mar 2009 13:08:56 +0100
Message-ID: <20090303120856.GB15003@chistera.yi.org>
References: <237967ef0902160200r2320687ai71e62047c3ead9ad@mail.gmail.com> <1236080017-13987-1-git-send-email-dato@net.com.org.es> <49AD1B22.6050201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mikael Magnusson <mikachu@gmail.com>,
	Joey Hess <joey@kitenet.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 13:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeTS9-0005dw-BU
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 13:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbZCCMJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 07:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbZCCMI7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 07:08:59 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4595
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbZCCMI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 07:08:59 -0500
Received: from justin (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id C2F25801C02E;
	Tue,  3 Mar 2009 13:08:56 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LeTQe-00043j-FE; Tue, 03 Mar 2009 13:08:56 +0100
Content-Disposition: inline
In-Reply-To: <49AD1B22.6050201@viscovery.net>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112064>

* Johannes Sixt [Tue, 03 Mar 2009 12:57:22 +0100]:

> Adeodato Sim=C3=B3 schrieb:
> > @@ -133,8 +133,10 @@ then the cloned repository will become corrupt=
=2E
> >  --depth <depth>::
> >  	Create a 'shallow' clone with a history truncated to the
> >  	specified number of revisions.  A shallow repository has a
> > -	number of limitations (you cannot clone or fetch from
> > -	it, nor push from nor into it), but is adequate if you
> > +	number of limitations: you cannot clone or fetch from it,
> > +	nor push into it; pushing from it into a regular repository
> > +	may work correctly in some cases, but it is not guaranteed to
> > +	always work.  However, a shallow repository is adequate if you

> Consider a reader who wants to decide whether --depth should or can b=
e
> used in a git clone invocation. Is the new wording helpful? If you do=
n't
> describe those "some cases" in more detail, then we better keep the
> current wording.

Well, I don't know if the set of cases where it'll work can be defined
in detail to a point where it is useful. If it is, then sure, let's do
it.

My point is that if it will work in some cases, then the documentation
should *acknowledge that fact*, because else people will assume the
documentation is wrong, and believe it is intended to work, which is no=
t
the case.

I think doing that is very important, and I hope I'm explaining myself
clearly.

Thanks,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
=C2=ABAra que ets la meva dona, te la fotr=C3=A9 fins a la melsa, bacon=
a!=C2=BB
                -- Terenci Moix, =E2=80=9CChulas y famosas=E2=80=9D
