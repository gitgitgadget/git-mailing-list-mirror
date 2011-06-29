From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: importing history
Date: Wed, 29 Jun 2011 23:35:22 +0200
Message-ID: <m262nofhid.fsf@igel.home>
References: <20110629164514.58175480.mihamina@bbs.mg>
	<348bd65ad7c7690bcce553fe3c8e0bfb.squirrel@mail.localhost.li>
	<m2sjqswp85.fsf@igel.home> <1309366960.2417.55.camel@oxylap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mihamina Rakotomandimby <mihamina@bbs.mg>, git@vger.kernel.org
To: Christof =?utf-8?Q?Kr=C3=BCger?= <git@christof-krueger.de>
X-From: git-owner@vger.kernel.org Wed Jun 29 23:36:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc2RI-0002QL-78
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 23:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144Ab1F2Vgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jun 2011 17:36:46 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45276 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757989Ab1F2Vf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 17:35:29 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 158421C1D9F0;
	Wed, 29 Jun 2011 23:35:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id EA6721C0009D;
	Wed, 29 Jun 2011 23:35:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id vp3QG7yNfqIQ; Wed, 29 Jun 2011 23:35:24 +0200 (CEST)
Received: from igel.home (ppp-88-217-121-230.dynamic.mnet-online.de [88.217.121.230])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 29 Jun 2011 23:35:24 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 97799CA29C; Wed, 29 Jun 2011 23:35:23 +0200 (CEST)
X-Yow: Now I'm concentrating on a specific tank battle toward
 the end of World War II!
In-Reply-To: <1309366960.2417.55.camel@oxylap> ("Christof =?utf-8?Q?Kr?=
 =?utf-8?Q?=C3=BCger=22's?= message of
	"Wed, 29 Jun 2011 19:02:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176460>

Christof Kr=C3=BCger <git@christof-krueger.de> writes:

> On Mi, 2011-06-29 at 18:56 +0200, Andreas Schwab wrote:
>> Careful.  git svn uses the remotes namespace in a non-std way.  Bett=
er
>> to locally clone the from-svn repository into a new one, then use "g=
it
>> remote add origin user@example.com/path/to/repository.git" to add th=
e
>> remote repository.  Then you can safely push the master branch.
> Doesn't git svn use svn-remove.svn.* and not remote.*?

I'm not talking about the config options, but of the ref namespace.  If
your svn repository would have a branch named origin it would be stored
as refs/remotes/origin by git svn, which would conflict with "git remot=
e
add origin ..."

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
