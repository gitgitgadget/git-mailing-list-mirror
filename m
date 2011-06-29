From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: importing history
Date: Wed, 29 Jun 2011 18:56:42 +0200
Message-ID: <m2sjqswp85.fsf@igel.home>
References: <20110629164514.58175480.mihamina@bbs.mg>
	<348bd65ad7c7690bcce553fe3c8e0bfb.squirrel@mail.localhost.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Mihamina Rakotomandimby" <mihamina@bbs.mg>, git@vger.kernel.org
To: Christof =?utf-8?Q?Kr=C3=BCger?= <git@christof-krueger.de>
X-From: git-owner@vger.kernel.org Wed Jun 29 18:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qby4L-0002YK-6c
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 18:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371Ab1F2Q4s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jun 2011 12:56:48 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:55872 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab1F2Q4r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 12:56:47 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 606521C01F19;
	Wed, 29 Jun 2011 18:56:44 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 6C45A1C0012A;
	Wed, 29 Jun 2011 18:56:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id r3zhHWZch93s; Wed, 29 Jun 2011 18:56:44 +0200 (CEST)
Received: from igel.home (ppp-88-217-121-230.dynamic.mnet-online.de [88.217.121.230])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 29 Jun 2011 18:56:43 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 74617CA2EC; Wed, 29 Jun 2011 18:56:43 +0200 (CEST)
X-Yow: - if it GLISTENS, gobble it!!
In-Reply-To: <348bd65ad7c7690bcce553fe3c8e0bfb.squirrel@mail.localhost.li>
	("Christof =?utf-8?Q?Kr=C3=BCger=22's?= message of "Wed, 29 Jun 2011
 16:25:50 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176446>

Christof Kr=C3=BCger <git@christof-krueger.de> writes:

> Now that you already have cloned the empty repository you can just lo=
ok at
> the remote configuration in it:
>
>  git config --list|grep remote
>
> You should see something like the following:
>
> remote.origin.url=3Duser@example.com/path/to/repository.git
> remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
>
> Go to your from-svn repository and add the above configuration, then =
"git
> push origin master".

Careful.  git svn uses the remotes namespace in a non-std way.  Better
to locally clone the from-svn repository into a new one, then use "git
remote add origin user@example.com/path/to/repository.git" to add the
remote repository.  Then you can safely push the master branch.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
