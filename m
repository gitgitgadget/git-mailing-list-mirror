From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC][PATCH] Cogito support for simple subprojects
Date: Sun, 15 Jan 2006 09:38:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601150937500.13339@g5.osdl.org>
References: <43C52B1F.8020706@hogyros.de> <20060115150721.GE28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Simon Richter <Simon.Richter@hogyros.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 18:38:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyBpl-0001Er-Va
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 18:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWAORi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 12:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWAORi1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 12:38:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932105AbWAORi0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2006 12:38:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0FHcGDZ010763
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Jan 2006 09:38:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0FHcEIn017275;
	Sun, 15 Jan 2006 09:38:15 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060115150721.GE28365@pasky.or.cz>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14699>



On Sun, 15 Jan 2006, Petr Baudis wrote:
> 
>   I've tried to take a different approach - KISS and don't make the
> subprojects part of the git-tracked tree but a thing purely local to
> your particular checkout. Subprojects are simply listed in
> .git/subprojects and various commands are called recursively on them.

This seems very sane. Goodie.

		Linus
