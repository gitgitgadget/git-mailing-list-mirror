From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 04 May 2014 23:31:16 +0200
Message-ID: <87ppjt6xjv.fsf@igel.home>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu> <536606AB.1020803@kdbg.org>
	<m2mwexke34.fsf@linux-m68k.org> <5366A09E.6030802@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun May 04 23:31:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh40J-0004Ef-T7
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 23:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbaEDVbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 17:31:20 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:32877 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbaEDVbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 17:31:19 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3gML3n5nJjz4KK7M;
	Sun,  4 May 2014 23:31:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3gML3n5Ys7zbbck;
	Sun,  4 May 2014 23:31:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id yx96Qh2-x1lz; Sun,  4 May 2014 23:31:17 +0200 (CEST)
X-Auth-Info: INFdEe+Q8q3X6bg0RBYG8DMKbIqHjxyqwowexso53mQ=
Received: from igel.home (ppp-93-104-158-29.dynamic.mnet-online.de [93.104.158.29])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun,  4 May 2014 23:31:17 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 06AFA2C423C; Sun,  4 May 2014 23:31:17 +0200 (CEST)
X-Yow: Everybody gets free BORSCHT!
In-Reply-To: <5366A09E.6030802@kdbg.org> (Johannes Sixt's message of "Sun, 04
	May 2014 22:18:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248115>

Johannes Sixt <j6t@kdbg.org> writes:

> Isn't internal padding only allowed between members to achieve correct
> alignment of later members, and at the end only sufficient padding so
> that members are aligned correctly when the struct is part of an array?

The standard allows arbitrary internal padding, it doesn't have to be
minimal.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
