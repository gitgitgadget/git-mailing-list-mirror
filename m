From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 2/2] connect.c: replace signal() with sigaction()
Date: Fri, 30 May 2014 23:48:52 +0200
Message-ID: <87sinr5457.fsf@igel.home>
References: <cover.1401482787.git.jmmahler@gmail.com>
	<1d11d5da7ebc3a6e0d4ab64802b601526c19113c.1401482787.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 23:49:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqUfd-0001vq-3p
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 23:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbaE3Vs5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 May 2014 17:48:57 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:43618 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbaE3Vs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 17:48:56 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3ggKD5470cz3hhbJ;
	Fri, 30 May 2014 23:48:53 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3ggKD52B6Czbbp4;
	Fri, 30 May 2014 23:48:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id uDb-yneIBo7c; Fri, 30 May 2014 23:48:52 +0200 (CEST)
X-Auth-Info: 2DbRKzt4U4irvEC47pMDZ7jpjOq6M7gtrccIBf7GGUM=
Received: from igel.home (host-188-174-212-94.customer.m-online.net [188.174.212.94])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 30 May 2014 23:48:52 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 50AF32C421A; Fri, 30 May 2014 23:48:52 +0200 (CEST)
X-Yow: The FALAFEL SANDWICH lands on my HEAD and I become a VEGETARIAN...
In-Reply-To: <1d11d5da7ebc3a6e0d4ab64802b601526c19113c.1401482787.git.jmmahler@gmail.com>
	(Jeremiah Mahler's message of "Fri, 30 May 2014 13:58:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250490>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> From signal(2) man page:
>
>   The behavior of signal() varies across UNIX versions, and has also =
var=E2=80=90
>   ied historically across different versions of Linux.   Avoid  its  =
use:
>   use sigaction(2) instead.

I don't think this matters for SIG_DFL or SIG_IGN.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
