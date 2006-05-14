From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 5/5] diff: parse U/u/unified options with an optional
 integer arg
Date: Sun, 14 May 2006 09:33:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605140931410.3866@g5.osdl.org>
References: <11476199631085-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 18:34:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfJXh-0006BB-Mj
	for gcvg-git@gmane.org; Sun, 14 May 2006 18:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWENQdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 12:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWENQdv
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 12:33:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751487AbWENQdu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 12:33:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4EGXntH030438
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 May 2006 09:33:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4EGXmih010218;
	Sun, 14 May 2006 09:33:48 -0700
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11476199631085-git-send-email-normalperson@yhbt.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19969>



On Sun, 14 May 2006, Eric Wong wrote:
> 
> -u (lowercase) now accepts an optional arg, like -U (GNU diff
> -u also has this behavior).

Actually, modern GNU "diff -u5" will say

	diff: `-5' option is obsolete; use `-U 5'
	diff: Try `diff --help' for more information.

and exit.

I'm not entirely sure why, but I think it's because "u" can be mixed (ie 
with something like "-urN"), while "U" cannot. The GNU diff rule seems to 
be that simple arguments can be mixed together, but arguments with 
parameters cannot. Which sounds sane.

		Linus
