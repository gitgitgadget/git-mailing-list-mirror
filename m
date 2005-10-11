From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] cg-tag - add support for longer commit messages
Date: Tue, 11 Oct 2005 07:57:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510110754110.14597@g5.osdl.org>
References: <11289987493327-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 17:00:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPLZN-0001Pb-RG
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 16:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVJKO5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 10:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVJKO5a
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 10:57:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46779 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932117AbVJKO53 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 10:57:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9BEvH4s016130
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Oct 2005 07:57:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9BEvG9w010278;
	Tue, 11 Oct 2005 07:57:16 -0700
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11289987493327-git-send-email-martin@catalyst.net.nz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.123 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9968>



On Tue, 11 Oct 2005, Martin Langhoff wrote:
>
> Added an -m switch that points to a filename which contains a (potentially
> long) tag message.

At least core git has "-m 'message'" and "-F 'file'" (with long versions 
being "--message" and "--file" respectively) for this kind of thing in 
"git commit". Maybe it would be good to make that the standard interface.

When scripting, using a separate file is often inconvenient, and giving 
the message as an argument much nicer. So you do often want both.

		Linus
