From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Is there a way to add a default `--squash` flag for all merges into a head?
Date: Mon, 07 Mar 2011 22:10:02 +0100
Message-ID: <m2r5aibpsl.fsf@igel.home>
References: <9f02bed0-fa18-46b1-a3d3-346e1cc7dc01@k15g2000prk.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 22:10:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwhh1-0006Uo-C9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 22:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033Ab1CGVKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 16:10:08 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:35312 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab1CGVKH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 16:10:07 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 5C96C188B5B9;
	Mon,  7 Mar 2011 22:10:03 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id CE52C1C000FD;
	Mon,  7 Mar 2011 22:10:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id AtrIHcja9NiF; Mon,  7 Mar 2011 22:10:03 +0100 (CET)
Received: from igel.home (ppp-93-104-143-51.dynamic.mnet-online.de [93.104.143.51])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon,  7 Mar 2011 22:10:03 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id D513CCA2A0; Mon,  7 Mar 2011 22:10:02 +0100 (CET)
X-Yow: Are we THERE yet?
In-Reply-To: <9f02bed0-fa18-46b1-a3d3-346e1cc7dc01@k15g2000prk.googlegroups.com>
	(Dun Peal's message of "Mon, 7 Mar 2011 11:28:09 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168611>

Dun Peal <dunpealer@gmail.com> writes:

> There's a configuration feaute `branch.<name>.rebase` for specifying
> that all merges into a branch (master in this case) would be done by
> rebase

That's not what it means.  It means that a "git pull" is implicitly "git
pull --rebase".  But if you do an explict merge it will not look at that
config setting.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
