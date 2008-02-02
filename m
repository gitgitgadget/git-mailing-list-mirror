From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Sat, 2 Feb 2008 23:39:46 +0100
Message-ID: <200802022339.47835.robin.rosenberg.lists@dewire.com>
References: <3asc6spe.fsf@blue.sea.net> <20080202161813.GA19797@fieldses.org> <63x73yjr.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 23:40:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLR2A-0000if-Ny
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 23:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763226AbYBBWjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Feb 2008 17:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763183AbYBBWjq
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 17:39:46 -0500
Received: from [83.140.172.130] ([83.140.172.130]:24037 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1763025AbYBBWjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 17:39:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9A089800680;
	Sat,  2 Feb 2008 23:39:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XnU6fCLT7Nmh; Sat,  2 Feb 2008 23:39:43 +0100 (CET)
Received: from [10.9.0.6] (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 1180480019B;
	Sat,  2 Feb 2008 23:39:37 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <63x73yjr.fsf@blue.sea.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72306>

l=F6rdagen den 2 februari 2008 skrev Jari Aalto:
> Yeah let's continue as usual. And every time you need to explain the
> difference, when you could just teach one. The is no doubt that
>=20
>     HEAD~N
>=20
> is superior to
>=20
>     HEAD^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Count that. Optimizing keystrokes is hardly ever a brilliant idea fro=
m
> learning perspective.

You generally do not type HEAD~largeN, defining large as 3 or more. It'=
s=20
typically one or maybe two ^'s only. When the target is farther away yo=
u=20
refer to the SHA-1 (or abbreviated form) tag or branch name instead, ju=
st to=20
make sure you point to the right commit. 'HEAD~N' is useful for scripti=
ng and=20
testing git itself, it's an advanced feature.

UI's that have only one way of accomplishing every task suck. Google th=
is
term "the case against user interface consistency" for reasons why, in =
case
you haven't seen them for yourself.

-- robin
