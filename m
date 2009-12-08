From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: delete remote branches
Date: Tue, 08 Dec 2009 23:06:21 +0100
Message-ID: <m27hsxazoi.fsf@igel.home>
References: <9cdb17250912081235m2b061ca5x70fe42749b49670f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Grimard <pgrimard@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 23:09:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI8Ca-0001ZP-4Z
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 23:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966579AbZLHWGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 17:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966568AbZLHWGV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 17:06:21 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:38659 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966533AbZLHWGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 17:06:20 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 4C0DA1C00048;
	Tue,  8 Dec 2009 23:06:23 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 45844902FC;
	Tue,  8 Dec 2009 23:06:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id z+-GUEJKEiPL; Tue,  8 Dec 2009 23:06:22 +0100 (CET)
Received: from igel.home (DSL01.83.171.188.240.ip-pool.NEFkom.net [83.171.188.240])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue,  8 Dec 2009 23:06:22 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id DB03CCA28C; Tue,  8 Dec 2009 23:06:21 +0100 (CET)
X-Yow: I didn't order any WOO-WOO...  Maybe a YUBBA..  But no WOO-WOO!
In-Reply-To: <9cdb17250912081235m2b061ca5x70fe42749b49670f@mail.gmail.com>
	(Patrick Grimard's message of "Tue, 8 Dec 2009 15:35:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134915>

Patrick Grimard <pgrimard@gmail.com> writes:

> However from DIR1 if I do "git branch -r" I still see the remote
> branch and can't seem to delete it using the above method.

Try "git remote prune origin".

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
