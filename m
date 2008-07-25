From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 6/9] builtin-init-db.c: use parse_options()
Date: Fri, 25 Jul 2008 17:20:26 +0200
Message-ID: <4889EF3A.6040605@free.fr>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-7-git-send-email-barra_cuda@katamail.com> <4888AAB2.5050007@free.fr> <alpine.DEB.1.00.0807241801030.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 17:21:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMP6o-0005Va-Ip
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 17:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbYGYPUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 11:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbYGYPU3
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 11:20:29 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:57909 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753407AbYGYPU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 11:20:28 -0400
Received: from smtp5-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 8A4B93F6280;
	Fri, 25 Jul 2008 17:20:26 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 345AD3F627E;
	Fri, 25 Jul 2008 17:20:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <alpine.DEB.1.00.0807241801030.8986@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90057>

Johannes Schindelin a =E9crit :
>>
>>> +		OPT_BOOLEAN(0, "bare", &bare, "set up a bare repo"),
>> s/set up/setup/
>=20
> No.  "setup" is a noun.

Right, sorry.

> We rely on shared_repository =3D=3D 0 for non-shared repositories _al=
most=20
> everywhere_.

I think we rely on the fact that PERM_UMASK =3D=3D 0 and not on the val=
ue
of shared_repository. Not the same thing.

That said, perhaps you are right: it is harmless.

>>> +		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),
>> OPT__QUIET(&quiet),
>>
>> if (quiet)
>> 	flags |=3D INIT_DB_QUIET;
>>
>> to use the same quiet option everywhere?
>=20
> Why?  Doesn't make it more readable, I think.  I'd rather have 3 line=
s=20
> less.

Hum.

Olivier.
