From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] branch: honor core.abbrev
Date: Thu, 30 Jun 2011 20:27:22 +0200
Message-ID: <m2pqlvmayd.fsf@igel.home>
References: <1309449762-10476-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 20:27:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcLxb-0000Cr-Kx
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 20:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab1F3S11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 14:27:27 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38245 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1F3S10 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 14:27:26 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 111C71802428;
	Thu, 30 Jun 2011 20:27:24 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 576291C00058;
	Thu, 30 Jun 2011 20:27:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id qpPk7NJqBxTE; Thu, 30 Jun 2011 20:27:23 +0200 (CEST)
Received: from igel.home (ppp-93-104-151-62.dynamic.mnet-online.de [93.104.151.62])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu, 30 Jun 2011 20:27:23 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id DFC86CA29C; Thu, 30 Jun 2011 20:27:22 +0200 (CEST)
X-Yow: If a person is FAMOUS in this country, they have to go on the ROAD
 for MONTHS at a time and have their name misspelled on the SIDE
 of a GREYHOUND SCENICRUISER!!
In-Reply-To: <1309449762-10476-1-git-send-email-namhyung@gmail.com> (Namhyung
	Kim's message of "Fri, 1 Jul 2011 01:02:42 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176498>

Namhyung Kim <namhyung@gmail.com> writes:

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index c50f189..906cccc 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -114,6 +114,7 @@ OPTIONS
>  --abbrev=<length>::
>  	Alter the sha1's minimum display length in the output listing.
>  	The default value is 7.
> +	(and can be overrided by the `core.abbrev` config option).

overridden

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
