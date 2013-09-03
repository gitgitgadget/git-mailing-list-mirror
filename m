From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git fetch --reference
Date: Tue, 03 Sep 2013 19:19:46 +0200
Message-ID: <m2ppspkekt.fsf@linux-m68k.org>
References: <ae657fa74373b58feba41615d335504e@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:19:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGuGl-0001wy-23
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab3ICRTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:19:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56253 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332Ab3ICRTy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:19:54 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cTvzr1CNwz3hhXN;
	Tue,  3 Sep 2013 19:19:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cTvzq6zWLzbbkn;
	Tue,  3 Sep 2013 19:19:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id bp4yMMCLj376; Tue,  3 Sep 2013 19:19:50 +0200 (CEST)
X-Auth-Info: dGefm2MATUEJeXcFmhzJFa1sRhbgAvz0z/6t3V2RM44=
Received: from linux.local (pC19F5FE6.dip0.t-ipconnect.de [193.159.95.230])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue,  3 Sep 2013 19:19:50 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id E12C41E579A; Tue,  3 Sep 2013 19:19:46 +0200 (CEST)
X-Yow: MERYL STREEP is my obstetrician!
In-Reply-To: <ae657fa74373b58feba41615d335504e@meuh.org> (Yann Droneaud's
	message of "Tue, 03 Sep 2013 18:55:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233744>

Yann Droneaud <ydroneaud@opteya.com> writes:

> So what's the best way to do a git fetch <remote>, copying objects from
> another local repository
> to resolve delta ?

IMHO the best way is to add a remote for the local repository, fetch
from it, then fetch from <remote>.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
