From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 'dotest' script broken
Date: Sun, 26 Jun 2005 14:51:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506261450000.19755@ppc970.osdl.org>
References: <42BF2167.9030404@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 26 23:46:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmewz-0005Ms-Kf
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 23:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVFZVwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 17:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVFZVww
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 17:52:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261610AbVFZVwv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 17:52:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5QLnZjA020447
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Jun 2005 14:49:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5QLnZte022007;
	Sun, 26 Jun 2005 14:49:35 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BF2167.9030404@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 26 Jun 2005, Jeff Garzik wrote:
> 
> When I run 'dotest /g/tmp/mbox' I receive an error message
> 
> 	[jgarzik@pretzel netdev-2.6]$ dotest /g/tmp/mbox
> 	mailinfo msg-file path-file filelist-file < email
> 
> and if you look at the dotest script, it only passes 2 args to mailinfo, 
> not the 3 args that the above usage message appears to require:
> 
> for i in .dotest/*
> do
>          mailinfo .dotest/msg .dotest/patch < $i > .dotest/info || exit 1

Looks like you updated "dotest", but didn't update "mailinfo"? Why? 
Especially as they come in the same package..

The new mailinfo wants just two arguments to match the new dotest.

			Linus
