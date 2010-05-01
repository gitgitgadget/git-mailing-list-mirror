From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git fast-import crashes importing commits with more than one author
Date: Sat, 01 May 2010 18:36:48 +0200
Message-ID: <m2ocgztw7z.fsf@igel.home>
References: <1272728636.27562.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giedrius Slavinskas <giedrius.slavinskas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 01 18:36:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8FgX-0001gk-Cm
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 18:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab0EAQgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 12:36:52 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59259 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab0EAQgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 12:36:51 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id AF3301C00214;
	Sat,  1 May 2010 18:36:49 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id A905C902C7;
	Sat,  1 May 2010 18:36:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id DvjO6VZcIpxb; Sat,  1 May 2010 18:36:48 +0200 (CEST)
Received: from igel.home (ppp-88-217-103-229.dynamic.mnet-online.de [88.217.103.229])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat,  1 May 2010 18:36:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 6D1FBCA297; Sat,  1 May 2010 18:36:48 +0200 (CEST)
X-Yow: Where's th' DAFFY DUCK EXHIBIT??
In-Reply-To: <1272728636.27562.12.camel@localhost.localdomain> (Giedrius
	Slavinskas's message of "Sat, 01 May 2010 18:43:56 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146088>

Giedrius Slavinskas <giedrius.slavinskas@gmail.com> writes:

> git fast-import does not support commits with more than one author. I
> try to import bzr repository and it crashes.

You can find a patch here:
<http://bazaar.launchpad.net/~schwab-linux-m68k/bzr-fastimport/fastimport.dev/revision/262>

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
