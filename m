From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: How do I investigate apparently random git clone reports of "error: File ... has bad hash"?
Date: Sun, 11 Sep 2011 22:13:10 +0200
Message-ID: <m2mxeaet2h.fsf@igel.home>
References: <loom.20110911T210035-693@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thorkil Naur <naur@post11.tele.dk>
X-From: git-owner@vger.kernel.org Sun Sep 11 22:13:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2qP4-0005Xa-3k
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 22:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791Ab1IKUNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 16:13:12 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:44752 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab1IKUNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 16:13:12 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 370761C021CE;
	Sun, 11 Sep 2011 22:13:11 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 23B3E1C0013C;
	Sun, 11 Sep 2011 22:13:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id YkKNxiGjx2Of; Sun, 11 Sep 2011 22:13:10 +0200 (CEST)
Received: from igel.home (ppp-88-217-122-177.dynamic.mnet-online.de [88.217.122.177])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sun, 11 Sep 2011 22:13:10 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 5B7C5CA296; Sun, 11 Sep 2011 22:13:10 +0200 (CEST)
X-Yow: Dehydrated EGGS are STREWN across ROULETTE TABLES..
In-Reply-To: <loom.20110911T210035-693@post.gmane.org> (Thorkil Naur's message
	of "Sun, 11 Sep 2011 19:03:03 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181191>

Thorkil Naur <naur@post11.tele.dk> writes:

> I have looked for git options (debug, verbosity) for increasing the amount of
> information reported, but have not managed to find anything that seemed useful
> in this situation.

Try adding -v -v when cloning.  That also shows you that the server does
not support smart-http, which is suboptimal.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
