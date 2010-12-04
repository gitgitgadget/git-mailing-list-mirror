From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Q about git rev-parse {--is-inside-work-tree, --show-cdup}
Date: Sat, 04 Dec 2010 17:52:41 +0100
Message-ID: <m24oatcwfa.fsf@igel.home>
References: <4CF95BDC.60506@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat Dec 04 17:53:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POvMI-0001pD-0M
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 17:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab0LDQwo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Dec 2010 11:52:44 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:43141 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab0LDQwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 11:52:44 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id EF7AB1C0F565;
	Sat,  4 Dec 2010 17:52:41 +0100 (CET)
Received: from igel.home (ppp-88-217-106-50.dynamic.mnet-online.de [88.217.106.50])
	by mail.mnet-online.de (Postfix) with ESMTP id C52131C00240;
	Sat,  4 Dec 2010 17:52:41 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 52CAFCA2A0; Sat,  4 Dec 2010 17:52:41 +0100 (CET)
X-Yow: Talking Pinhead Blues:
 Oh, I LOST my ``HELLO KITTY'' DOLL and I get BAD reception on
  channel TWENTY-SIX!!
 Th'HOSTESS FACTORY is closin' down and I just heard ZASU PITTS
  has been DEAD for YEARS..  (sniff)
 My PLATFORM SHOE collection was CHEWED up by th'dog, ALEXANDER
  HAIG won't let me take a SHOWER 'til Easter.. (snurf)
 So I went to the kitchen, but WALNUT PANELING whup me
  upside mah HAID!! (on no, no, no..  Heh, heh)
In-Reply-To: <4CF95BDC.60506@dirk.my1.cc> ("Dirk =?utf-8?Q?S=C3=BCsserott?=
 =?utf-8?Q?=22's?= message of "Fri,
	03 Dec 2010 22:06:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162896>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> 2. Wouldn't it be useful, if "git rev-parse --show-cdup" (2a) would
> return a dot "." instead of nothing if we are already in the topdir?
> That would make the steps (2a), (2b), (2c) to a simple "cd $(git
> rev-parse --show-cdup)".

The string returned by --show-cdup is to be used as prefix for a
relative path.  If you want to use it standalone just append ".":

cd $(git rev-parse --show-cdup).

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
