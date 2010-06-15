From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: No working tree repository
Date: Tue, 15 Jun 2010 21:39:14 +0200
Message-ID: <m2ocfcw0f1.fsf@igel.home>
References: <4C17BEB7.90403@cfl.rr.com> <vpqy6egi2va.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 21:39:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OObyj-0007FM-R8
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 21:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab0FOTjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 15:39:17 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45648 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab0FOTjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 15:39:16 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 16B421C1598C;
	Tue, 15 Jun 2010 21:39:14 +0200 (CEST)
Received: from igel.home (ppp-88-217-126-207.dynamic.mnet-online.de [88.217.126.207])
	by mail.mnet-online.de (Postfix) with ESMTP id E69B91C00141;
	Tue, 15 Jun 2010 21:39:14 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id BFFA4CA297; Tue, 15 Jun 2010 21:39:14 +0200 (CEST)
X-Yow: ALFRED JARRY!  Say something about th' DEATH of DISCO!!
In-Reply-To: <vpqy6egi2va.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue,
	15 Jun 2010 20:10:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149219>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> You can do something like
>
> mv linux-repo linux-tree
> cd linux-tree
> mv .git ../linux-repo
> cd ../linux-repo
> git config core.bare true

Or shorter:

$ git clone --bare linux-repo

(which creates linux-repo.git and uses hardlinks, so it won't waste
space)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
