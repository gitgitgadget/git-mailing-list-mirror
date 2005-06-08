From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-merge-one-file-script cleanups from Cogito
Date: Wed, 8 Jun 2005 16:56:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506081655580.2286@ppc970.osdl.org>
References: <20050608233820.GB9782@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 02:43:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgB80-0003xh-Oq
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 02:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVFIApN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 20:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVFHXzI
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 19:55:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:12166 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261596AbVFHXyc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 19:54:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j58NsTjA004949
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 16:54:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j58NsSh0025957;
	Wed, 8 Jun 2005 16:54:29 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050608233820.GB9782@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 9 Jun 2005, Petr Baudis wrote:
>
> Chain the resolving sequences (e.g. git-cat-file - chmod -
> git-update-cache) through &&s so we stop right away in case one of the
> command fails, and report the error code to the script caller.

Heh. This patch wouldn't apply, so I tried the new merge functionality on 
it. Seems to work. Goodie.

		Linus
