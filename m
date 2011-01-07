From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: 'git add' option to non-interactively stage working tree changes
Date: Fri, 07 Jan 2011 20:52:53 +0100
Message-ID: <m2aajcbiei.fsf@igel.home>
References: <AANLkTimLKZnVn8Lr-E-8M8T5mXA55XabCT5rC+broeFJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hrvoje =?utf-8?B?TmlrxaFpxIc=?= <hniksic@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 20:53:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbIMw-00017D-O3
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 20:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449Ab1AGTw6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 14:52:58 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45236 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab1AGTw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 14:52:57 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id D185E1C1DA03;
	Fri,  7 Jan 2011 20:52:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id CC5131C00240;
	Fri,  7 Jan 2011 20:52:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id vfpgDV5QroMQ; Fri,  7 Jan 2011 20:52:55 +0100 (CET)
Received: from igel.home (ppp-93-104-131-69.dynamic.mnet-online.de [93.104.131.69])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri,  7 Jan 2011 20:52:55 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 9BB19CA2A0; Fri,  7 Jan 2011 20:52:54 +0100 (CET)
X-Yow: I put aside my copy of ``BOWLING WORLD'' and think
 about GUN CONTROL legislation..
In-Reply-To: <AANLkTimLKZnVn8Lr-E-8M8T5mXA55XabCT5rC+broeFJ@mail.gmail.com>
	("Hrvoje =?utf-8?B?TmlrxaFpxIciJ3M=?= message of "Fri, 7 Jan 2011 19:56:48
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164751>

Hrvoje Nik=C5=A1i=C4=87 <hniksic@gmail.com> writes:

> Specifying the root may seem innocuous, but it is inconsistent with
> "git diff" and "git commit [-a]", which don't care where in the tree
> you are.

You can always use "$(git rev-parse --show-cdup)." as the root.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
