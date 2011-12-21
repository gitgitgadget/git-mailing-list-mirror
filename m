From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Specify a precision for the length of a subject string
Date: Wed, 21 Dec 2011 12:26:25 +0100
Message-ID: <m2liq6go7y.fsf@igel.home>
References: <20111220220754.GC21353@llunet.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 12:26:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdKJe-0007Wi-1T
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 12:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825Ab1LUL03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 06:26:29 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51483 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab1LUL02 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 06:26:28 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 53B0E180009D;
	Wed, 21 Dec 2011 12:26:26 +0100 (CET)
X-Auth-Info: 8qhrpPKY1srFavFuWCCYb2Z4JCmsXDuVzVcNjIRPcZA=
Received: from igel.home (ppp-93-104-130-25.dynamic.mnet-online.de [93.104.130.25])
	by mail.mnet-online.de (Postfix) with ESMTPA id 546C21C00155;
	Wed, 21 Dec 2011 12:26:26 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 8E305CA29C; Wed, 21 Dec 2011 12:26:25 +0100 (CET)
X-Yow: UH-OH!!  I think KEN is OVER-DUE on his R.V. PAYMENTS and HE'S
 having a NERVOUS BREAKDOWN too!!  Ha ha.
In-Reply-To: <20111220220754.GC21353@llunet.cs.wisc.edu> (Nathan W. Panike's
	message of "Tue, 20 Dec 2011 16:07:54 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187559>

"Nathan W. Panike" <nathan.panike@gmail.com> writes:

> $ git log --pretty='%h %30s' d165204 -1

In C's formatted output this syntax denotes a minimum field width, not a
precision, so it will probably be surprising to many people.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
