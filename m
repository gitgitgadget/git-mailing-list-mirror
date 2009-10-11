From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: meaning of HEAD in context of filter-branch
Date: Sun, 11 Oct 2009 11:38:16 +0200
Message-ID: <m27hv2s22f.fsf@igel.home>
References: <20091011024357.GA9021@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 11:39:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwuty-0004Pi-7I
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 11:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbZJKJjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 05:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbZJKJjG
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 05:39:06 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52607 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbZJKJjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 05:39:04 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id EDF1E1C156AF;
	Sun, 11 Oct 2009 11:38:17 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id D0FE390168;
	Sun, 11 Oct 2009 11:38:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id VQSTUf+Ops9q; Sun, 11 Oct 2009 11:38:16 +0200 (CEST)
Received: from igel.home (DSL01.83.171.184.49.ip-pool.NEFkom.net [83.171.184.49])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sun, 11 Oct 2009 11:38:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id AB66B10C5C0; Sun, 11 Oct 2009 11:38:16 +0200 (CEST)
X-Yow: I'm ZIPPY!!  Are we having FUN yet??
In-Reply-To: <20091011024357.GA9021@debian.b2j> (bill lam's message of "Sun,
	11 Oct 2009 10:43:57 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129912>

bill lam <cbill.lam@gmail.com> writes:

> how to get the HEAD during filter-branch or other workaround?

>From git-filter-index(1):

   Filters
       The filters are applied in the order as listed below. The <command>
       argument is always evaluated in the shell context using the eval
       command (with the notable exception of the commit filter, for technical
       reasons). Prior to that, the $GIT_COMMIT environment variable will be
                                    ^^^^^^^^^^^
       set to contain the id of the commit being rewritten.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
