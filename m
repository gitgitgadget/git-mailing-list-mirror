From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: cvs update vs. git pull
Date: Fri, 28 May 2010 17:58:24 +0200
Message-ID: <201005281758.24183.robin.rosenberg@dewire.com>
References: <d876ae6b75ab8d9debe5b97f84a4386a.squirrel@resmo.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?q?Ren=E9_Moser?= <mail@renemoser.net>
X-From: git-owner@vger.kernel.org Fri May 28 17:58:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OI1xC-0004WQ-Bo
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 17:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758915Ab0E1P63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 11:58:29 -0400
Received: from mail.dewire.com ([83.140.172.130]:17179 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757664Ab0E1P62 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 May 2010 11:58:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8FC2513979B1;
	Fri, 28 May 2010 17:58:26 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qvP-+jCrWF0x; Fri, 28 May 2010 17:58:25 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 4720C13979AD;
	Fri, 28 May 2010 17:58:25 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-22-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <d876ae6b75ab8d9debe5b97f84a4386a.squirrel@resmo.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147929>

fredagen den 28 maj 2010 11.21.12 skrev  Ren=E9 Moser:
> Hi
>=20
> I use git since a while for my own projects (how surprise).
>=20
> The company I work for still uses a CVS(nt), and this sucks, time to
> changed that. We have a use case we often have problems with. If git =
would
> solve this problem, I would really have a good arg for the managers.
>=20
> The codebase managed by CVS is quite huge and therefore we have daily=
 and
> nightly builds.
>=20
> One problem we have is, that if there is a commit to cvs while the cv=
s
> update of the build job is running (and this takes 20 minutes), then =
we
> get some inconsistence, the build will fail.

Perform export/checkout using a timestamp to avoid this. You should als=
o=20
require that no checkins to your branch have happend during a period, s=
ay 10=20
minutes, before starting the build.

> So the question is, if we would use git, this inconsistence would not=
 be
> possible because the git pull will get the state of the sha1. Right?

Yes. It's hard to predict what happens when you have multiple repos inv=
olved,=20
in the build. Requiring no changes (on the build branch) in all repos i=
s one
option.

-- robin
