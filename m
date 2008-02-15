From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Rename git-core rpm to just git and rename the meta-pacakge
 to git-all.
Date: Fri, 15 Feb 2008 22:08:39 +0100
Message-ID: <47B5FF57.5080204@op5.se>
References: <1203100163-17509-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 22:09:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ7oH-00077h-1f
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 22:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759730AbYBOVIv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2008 16:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757355AbYBOVIv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 16:08:51 -0500
Received: from mail.op5.se ([193.201.96.20]:58367 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593AbYBOVIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 16:08:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 49BD21F08022;
	Fri, 15 Feb 2008 22:08:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sVIZONvOknpP; Fri, 15 Feb 2008 22:08:47 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id A8F441F08007;
	Fri, 15 Feb 2008 22:08:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <1203100163-17509-1-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73981>

Kristian H=F8gsberg wrote:
> ---
>=20
> So here's change to fix my favorite annoyance with the git rpm
> packaging: don't pull in tla when I say yum install git!  The decisio=
n
> to make 'git' a metapackage is to say the least unconventional and
> continues to surprise people (here's today discussion:
> http://marc.info/?t=3D120309228600004&r=3D1&w=3D2).
>=20
> I know it's late and most people who use the git rpms are used to ins=
talling
> git-core by now, but myself and most of my Red Hat co-workers (who sh=
ould
> know a thing or two about rpm packaging) have been fooled by the 'git=
'
> rpm that pulls in everything.  There's really no precendence for this=
, quite
> the opposite: you wouldn't expect yum install gcc to pull in fortran,=
 right?
>=20
> The patch below only affects people who know that 'git' is a metapack=
age
> and actually use that to pull in everything (but who does?).  The pat=
ch
> renames the 'git-core' rpm to just 'git', but adds a 'Provides: git-c=
ore'
> there so people who have trained themselves to say yum install git-co=
re
> wont get burned.
>=20

Neat, and very nicely done. However, why not add "git-extras" package a=
s
meta-package that does what just plain "git" package used to do, and
mentioning the git-extras rpm in the %description of git's package?

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
