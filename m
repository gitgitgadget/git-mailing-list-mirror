From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Getting rid of "mode change" on cygwin
Date: Fri, 24 Sep 2010 21:36:53 +0200
Message-ID: <m2tylf9bmy.fsf@igel.home>
References: <loom.20100924T205622-57@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Fri Sep 24 21:37:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzE4r-0006Og-SV
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 21:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797Ab0IXTg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 15:36:56 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49466 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab0IXTgz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 15:36:55 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 807F11C15D6F;
	Fri, 24 Sep 2010 21:36:54 +0200 (CEST)
Received: from igel.home (ppp-93-104-152-223.dynamic.mnet-online.de [93.104.152.223])
	by mail.mnet-online.de (Postfix) with ESMTP id 760C81C0027A;
	Fri, 24 Sep 2010 21:36:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id DB470CA2A0; Fri, 24 Sep 2010 21:36:53 +0200 (CEST)
X-Yow: Fold, fold, FOLD!!  FOLDING many items!!
In-Reply-To: <loom.20100924T205622-57@post.gmane.org> (Maaartin's message of
	"Fri, 24 Sep 2010 18:57:59 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157044>

Maaartin <grajcar1@seznam.cz> writes:

> I just switched from svn to git and in my first git commit all files get status 
> modified with
>
> mode change 100644 => 100755
>
> I don't care about the file mode much, the 755 mode makes no sense but is 
> probably some cygwin magic, as it may be hard to emulate the perms, so it simply 
> considers all files as executables. I can't change the mode, since chmod a-x 
> does nothing at all. Actually, I don't care about the perms at all, I'd be happy 
> if git would show "no change" for unchanged files.

$ git config core.filemode false

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
