From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 04/14] msvc: Fix macro redefinition warnings
Date: Wed, 8 Dec 2010 20:51:46 +0100
Message-ID: <201012082051.46644.j6t@kdbg.org>
References: <4CFA8FE3.1050009@ramsay1.demon.co.uk> <4CFECBB8.2070900@ramsay1.demon.co.uk> <AANLkTimpj31CSzaxH4ZuYdADvtV4KSwfk04eGSRYSLFH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	"GIT Mailing-list" <git@vger.kernel.org>, patthoyts@gmail.com,
	pharris@opentext.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 20:51:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQQ3O-0007JM-AT
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 20:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812Ab0LHTvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 14:51:49 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:29220 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753910Ab0LHTvs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 14:51:48 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DA80FCDF86;
	Wed,  8 Dec 2010 20:51:46 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B9AFD19F831;
	Wed,  8 Dec 2010 20:51:46 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTimpj31CSzaxH4ZuYdADvtV4KSwfk04eGSRYSLFH@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163217>

On Mittwoch, 8. Dezember 2010, Sebastian Schuberth wrote:
> Indeed, I remember that back then my
> msysgit working tree did not compile with MSVC if I didn't have these
> defines (and I vaguely remember that this was caused by MSVC using
> different a header file than MinGW, or in a different order, or
> something similar).
...
> After defining LF_FACESIZE and TMPF_TRUETYPE in winansi.c, and
> INTMAX_MAX in git-compat-util.h, I was also able to compile the
> v1.7.3.2.msysgit.0 tag with MSVC. If I revert 4091bfc on top of it, it
> still compiles fine for me.
>
> > So, once again, I see no reason to keep them ... Unless you know
> > otherwise.
>
> I agree to remove the lines and vote in favor of Ramsay's patch. Feel
> free to add me as Signed-off-by or Acked-by.

Under these circumstances, I agree as well with Ramsay's patch.

-- Hannes
