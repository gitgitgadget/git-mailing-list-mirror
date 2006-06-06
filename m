From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] builtin-grep: pass ignore case option to external grep
Date: Tue, 6 Jun 2006 16:27:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606061625430.5498@g5.osdl.org>
References: <20060606231516.GA18405@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 01:27:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnkxJ-0005Yl-5F
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 01:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWFFX1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 19:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWFFX1W
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 19:27:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751351AbWFFX1W (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 19:27:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k56NR82g024138
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Jun 2006 16:27:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k56NR3kS006011;
	Tue, 6 Jun 2006 16:27:06 -0700
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <20060606231516.GA18405@localhost>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21414>



On Tue, 6 Jun 2006, Robert Fitzsimons wrote:
>
> Don't just read the --ignore-case/-i option, pass the flag on to the
> external grep program.

Oops. How did we miss that one ;)

Embarrassing.

		Linus
