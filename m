From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Fri, 14 Nov 2014 16:06:18 +0100
Message-ID: <8761ehom8l.fsf@igel.home>
References: <20141113111444.GA15503@aepfle.de>
	<20141113154457.GA31624@aepfle.de>
	<20141113160325.GA24351@paksenarrion.iveqy.com>
	<20141114112428.GA12702@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Fri Nov 14 16:06:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpISN-0003XS-Ce
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 16:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935321AbaKNPGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 10:06:23 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:58180 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935211AbaKNPGV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 10:06:21 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jfNL33sRHz3hjMm;
	Fri, 14 Nov 2014 16:06:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jfNL33D9FzvjMt;
	Fri, 14 Nov 2014 16:06:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 5Ow6yNOu2jMA; Fri, 14 Nov 2014 16:06:18 +0100 (CET)
X-Auth-Info: BpYpqvgjyC2324KHUosrUGgbkF8AoWF6zuhp7LsUsMR6/XI19pgydEoTUCCzyBMc
Received: from igel.home (ppp-93-104-156-1.dynamic.mnet-online.de [93.104.156.1])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 14 Nov 2014 16:06:18 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 637962C16E8; Fri, 14 Nov 2014 16:06:18 +0100 (CET)
X-Yow: This PORCUPINE knows his ZIPCODE..  And he has ``VISA''!!
In-Reply-To: <20141114112428.GA12702@aepfle.de> (Olaf Hering's message of
	"Fri, 14 Nov 2014 12:24:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> Even if I do a fresh clone with --bare, the result can not be updated
> anymore with git fetch. What I'm doing wrong?

A --bare clone has no connection to its origin (there are no remotes).
You want a --mirror.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
