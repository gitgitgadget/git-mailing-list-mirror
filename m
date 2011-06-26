From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Deleted file is back - how to investigate?
Date: Sun, 26 Jun 2011 22:57:31 +0200
Message-ID: <m2iprsxqdg.fsf@igel.home>
References: <20110626103218.GQ30255@genesis.frugalware.org>
	<1309097423.11860.76.camel@oxylap>
	<20110626202532.GS30255@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christof =?utf-8?Q?Kr=C3=BCger?= <git@christof-krueger.de>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jun 26 23:00:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QawRQ-0004IE-7h
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 23:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328Ab1FZU7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 16:59:04 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:35346 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251Ab1FZU5f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 16:57:35 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id F22E3188B5AB;
	Sun, 26 Jun 2011 22:57:31 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 4355C1C000BF;
	Sun, 26 Jun 2011 22:57:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id hvlZR+XU20Fk; Sun, 26 Jun 2011 22:57:31 +0200 (CEST)
Received: from igel.home (ppp-93-104-154-51.dynamic.mnet-online.de [93.104.154.51])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sun, 26 Jun 2011 22:57:31 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 46213CA29C; Sun, 26 Jun 2011 22:57:31 +0200 (CEST)
X-Yow: How do you explain Wayne Newton's POWER over millions?
 It's th' MOUSTACHE...  Have you ever noticed th' way it radiates
 SINCERITY, HONESTY & WARMTH?  It's a MOUSTACHE you want to take
 HOME and introduce to NANCY SINATRA!
In-Reply-To: <20110626202532.GS30255@genesis.frugalware.org> (Miklos Vajna's
	message of "Sun, 26 Jun 2011 22:25:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176333>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Great, --graph indeed lists two merge commits, and if I check the tree
> objects manually, I can see which one introduced the file. But I still
> don't really understand --name-status why don't show the addition of
> those files, given that I hoped this counts as an "evil merge".

The file is unchanged wrt. to the first parent, so it is
"uninteresting".

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
