From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: openbsd version?
Date: Mon, 10 Oct 2005 09:41:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510100939320.14597@g5.osdl.org>
References: <8664s5gxl9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 18:44:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP0iK-0001M1-UV
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 18:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVJJQlN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 12:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVJJQlM
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 12:41:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750904AbVJJQlK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 12:41:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9AGf74s022971
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Oct 2005 09:41:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9AGf5wD022472;
	Mon, 10 Oct 2005 09:41:06 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <8664s5gxl9.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9896>



On Mon, 10 Oct 2005, Randal L. Schwartz wrote:
> 
> I noticed "openbsd" in the operating systems detected in Makefile,
> but when I tried this on my openbsd system, I get an abort here:
> 
>     /opt/git/src/git-snapshot-20051010/mailinfo.c:130: undefined reference to `strcasestr'

Either do

	make NO_STRCASESTR=1 ..

or add that explicitly to the makefile in the OpenBSD rules and send Junio 
a tested patch ;)

		Linus
