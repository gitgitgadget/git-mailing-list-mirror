From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Fwd: am fails to apply patches for files with CRLF lineendings
Date: Wed, 16 Dec 2009 00:18:27 +0100
Message-ID: <m2vdg7u8qk.fsf@igel.home>
References: <20091214183337.GA25462@atjola.homenet>
	<7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
	<tCQlJn153g8Oa6Z9HKe6xOUQJdcf2PCIVthlTrLgYE-wJ5jFyXVXWw@cipher.nrlssc.navy.mil>
	<7vhbrtdtth.fsf@alter.siamese.dyndns.org>
	<ee63ef30912141650ie05baf4kab8505adf160c62e@mail.gmail.com>
	<ee63ef30912141809k27bc73edp20abddd5e9c7c063@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 00:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKgfD-00054Z-N3
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 00:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933891AbZLOXSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2009 18:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933878AbZLOXSd
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 18:18:33 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:56725 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761915AbZLOXSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 18:18:30 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 071701C000FA;
	Wed, 16 Dec 2009 00:18:29 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 01D5A90615;
	Wed, 16 Dec 2009 00:18:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id lqFy6e-LdnqV; Wed, 16 Dec 2009 00:18:27 +0100 (CET)
Received: from igel.home (DSL01.83.171.165.132.ip-pool.NEFkom.net [83.171.165.132])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 16 Dec 2009 00:18:27 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 9F87CCA28C; Wed, 16 Dec 2009 00:18:27 +0100 (CET)
X-Yow: I used to be a FUNDAMENTALIST, but then I heard about the
 HIGH RADIATION LEVELS and bought an ENCYCLOPEDIA!!
In-Reply-To: <ee63ef30912141809k27bc73edp20abddd5e9c7c063@mail.gmail.com>
	(Brandon Casey's message of "Mon, 14 Dec 2009 20:09:46 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135308>

Brandon Casey <drafnel@gmail.com> writes:

> But isn't each email in the mbox file supposed to be RFC-2822
> formatted anyway?=C2=A0 If so, then my reading of RFC-2822 says that =
there
> should only be CRLF everywhere and no bare CR or bare LF.=C2=A0 But m=
aybe
> everyone has just been ignoring that part of RFC-2822?=C2=A0 I'm not =
an
> email expert, so I really don't know.

RFC 2822 specifies a *transport* format, where each text lines is
represented by terminating it with CRLF.  Any other use is outside the
scope of that RFC.  The mbox format normally uses the native format for
text files, which means LF terminated lines when used under Unix.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
