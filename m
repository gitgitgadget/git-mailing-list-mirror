From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Following renames
Date: Sat, 25 Mar 2006 19:19:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
References: <20060326014946.GB18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 05:20:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNLnY-000466-8I
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 05:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWCZDTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 22:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWCZDTz
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 22:19:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751506AbWCZDTz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 22:19:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2Q3JpDZ013812
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Mar 2006 19:19:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2Q3Jo25022693;
	Sat, 25 Mar 2006 19:19:51 -0800
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20060326014946.GB18185@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18024>



On Sun, 26 Mar 2006, Petr Baudis wrote:
> 
>   In [1], Linus suggests a non-core solution. Unfortunately, it doesn't
> fly - it requires at least two git-ls-tree calls per revision which
> would bog things down awfully (to roughly half of the original speed).

No it doesn't. It requires one git-ls-tree WHEN SOMETHING IS RENAMED.

In other words, basically never.

		Linus
