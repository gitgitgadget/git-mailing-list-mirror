From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 03 Dec 2009 13:03:24 +0100
Message-ID: <m2hbs85koj.fsf@igel.home>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 13:03:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGAPH-0004Og-1q
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 13:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbZLCMDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 07:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbZLCMDV
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 07:03:21 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:51050 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbZLCMDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 07:03:20 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 4A2BC1C15E3E;
	Thu,  3 Dec 2009 13:03:26 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 027DF902DD;
	Thu,  3 Dec 2009 13:03:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id M3Ar2IYoAxiZ; Thu,  3 Dec 2009 13:03:24 +0100 (CET)
Received: from igel.home (DSL01.83.171.171.98.ip-pool.NEFkom.net [83.171.171.98])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu,  3 Dec 2009 13:03:24 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 6FE6ECA28C; Thu,  3 Dec 2009 13:03:24 +0100 (CET)
X-Yow: Where do your SOCKS go when you lose them in th' WASHER?
In-Reply-To: <7v638o76ra.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 03 Dec 2009 01:21:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134449>

Junio C Hamano <gitster@pobox.com> writes:

>       Unconditionally set man.base.url.for.relative.links

rm -f git-add.1 && \
        xmlto -m manpage-normal.xsl  --stringparam man.base.url.for.relative.links= man git-add.xml
xmlto: unrecognized option '--stringparam'
make[1]: *** [git-add.1] Error 1

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
