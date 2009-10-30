From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] More precise description of 'git describe --abbrev'
Date: Fri, 30 Oct 2009 21:18:39 +0100
Message-ID: <m2my38fxeo.fsf@igel.home>
References: <b48ea8a00910291438r8b66a0fq9e821393ecfff0bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Gisle Aas <gisle@aas.no>
X-From: git-owner@vger.kernel.org Fri Oct 30 21:18:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xvx-0003oL-Nr
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 21:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbZJ3USj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 16:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbZJ3USj
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 16:18:39 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33896 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbZJ3USi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 16:18:38 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id CC9FA1C00204;
	Fri, 30 Oct 2009 21:18:41 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 9AD0A90174;
	Fri, 30 Oct 2009 21:18:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id DlTrSLI7HCCx; Fri, 30 Oct 2009 21:18:40 +0100 (CET)
Received: from igel.home (DSL01.83.171.185.109.ip-pool.NEFkom.net [83.171.185.109])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 30 Oct 2009 21:18:40 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 2C68C10DB86; Fri, 30 Oct 2009 21:18:39 +0100 (CET)
X-Yow: Everybody gets free BORSCHT!
In-Reply-To: <b48ea8a00910291438r8b66a0fq9e821393ecfff0bf@mail.gmail.com>
	(Gisle Aas's message of "Thu, 29 Oct 2009 22:38:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131748>

Gisle Aas <gisle@aas.no> writes:

> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index b231dbb..743eb95 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -44,7 +44,9 @@ OPTIONS
>
>  --abbrev=<n>::
>  	Instead of using the default 7 hexadecimal digits as the
> -	abbreviated object name, use <n> digits.
> +	abbreviated object name, use <n> digits or as many digits
> +	are needed to form a unique object name.  An <n> of 0

"as many digits as needed"?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
