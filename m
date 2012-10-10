From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: rm and add, but not rename, of identical files
Date: Wed, 10 Oct 2012 22:09:47 +0200
Message-ID: <m2wqyyw0l0.fsf@igel.home>
References: <1349894347.32696.10.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Oct 10 22:10:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM2bS-0006U8-1m
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 22:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab2JJUJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 16:09:51 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56755 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab2JJUJv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 16:09:51 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XcRHK3nYNz3hhWD;
	Wed, 10 Oct 2012 22:09:48 +0200 (CEST)
X-Auth-Info: odJfxwBW0adjjGMEmfYFEjlI8s1KSvRPVLInC01aOyg=
Received: from igel.home (ppp-93-104-147-205.dynamic.mnet-online.de [93.104.147.205])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XcRHJ2zTSzbbfb;
	Wed, 10 Oct 2012 22:09:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 0C67ECA2A4; Wed, 10 Oct 2012 22:09:48 +0200 (CEST)
X-Yow: NOW, I'm supposed to SCRAMBLE two, and HOLD th' MAYO!!
In-Reply-To: <1349894347.32696.10.camel@drew-northup.unet.maine.edu> (Drew
	Northup's message of "Wed, 10 Oct 2012 14:39:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207436>

Drew Northup <drew.northup@maine.edu> writes:

> It detects the changes as renames however=E2=80=94which in this case =
isn't
> appropriate:

Why is that a problem?  A rename is just something which is computed on
the fly for display purpose, the repository only stores a snapshot of
the resulting tree.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
