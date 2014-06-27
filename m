From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix: wrong offset for CET timezone
Date: Fri, 27 Jun 2014 09:48:10 +0200
Message-ID: <87lhsi23ph.fsf@igel.home>
References: <1403790812-29174-1-git-send-email-mailing@franzoni.eu>
	<166360487.125996.1403820532765.JavaMail.zimbra@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alan Franzoni <mailing@franzoni.eu>, git@vger.kernel.org,
	Alan Franzoni <username@franzoni.eu>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 09:48:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0QtZ-0001zt-42
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 09:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbaF0HsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 03:48:25 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:33105 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbaF0HsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 03:48:25 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3h09FM3wQHz3hhh8;
	Fri, 27 Jun 2014 09:48:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3h09FJ36FRz7S6Vb;
	Fri, 27 Jun 2014 09:48:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id bbNKUWT37P09; Fri, 27 Jun 2014 09:48:10 +0200 (CEST)
X-Auth-Info: GmZDHGBatx7AS1Okfc+wv6EjcUCVhdW+Bs/ZkR7zwrg=
Received: from igel.home (host-188-174-210-37.customer.m-online.net [188.174.210.37])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 27 Jun 2014 09:48:10 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 6EE612C0597; Fri, 27 Jun 2014 09:48:10 +0200 (CEST)
X-Yow: What GOOD is a CARDBOARD suitcase ANYWAY?
In-Reply-To: <166360487.125996.1403820532765.JavaMail.zimbra@dewire.com>
	(Robin Rosenberg's message of "Fri, 27 Jun 2014 00:08:52 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252537>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> $ TZ=CET date
> Fre 27 Jun 2014 00:08:05 CEST

That only works because CET is a special zone name (POSIX time zones
require at least a number to denote the standard offset), similar to
Europe/Berlin but without the history.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
