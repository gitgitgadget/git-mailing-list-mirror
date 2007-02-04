From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and file name case on cygwin
Date: Sat, 3 Feb 2007 17:17:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702031716130.8424@woody.linux-foundation.org>
References: <ad8ce5c20702031400h78ddc11o34f98a461339bb55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-87853917-1170551856=:8424"
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Niklas_H=F6glund?= <nhoglund@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 02:17:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDW0l-0001J0-6D
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 02:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbXBDBRl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 20:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbXBDBRl
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 20:17:41 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55403 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbXBDBRk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 20:17:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l141HbQ5006981
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 3 Feb 2007 17:17:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l141Harx019782;
	Sat, 3 Feb 2007 17:17:36 -0800
In-Reply-To: <ad8ce5c20702031400h78ddc11o34f98a461339bb55@mail.gmail.com>
X-Spam-Status: No, hits=-0.393 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.173 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38629>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-87853917-1170551856=:8424
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Sat, 3 Feb 2007, Niklas Höglund wrote:
>
> There's something funny going on with git in cygwin. The following is
> in a clone of linux 2.6, with no local modifications (only the
> occasional pull from upstream).

You are using a filesystem that isn't able to handle the Linux kernel.

Make sure you don't try to maintain kernel source trees on a filesystem 
that isn't case-sensitive. Here's a clue:

	include/linux/netfilter/xt_dscp.h
	include/linux/netfilter/xt_DSCP.h

are both tracked files..

		Linus
---1463790079-87853917-1170551856=:8424--
