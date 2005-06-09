From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add git-diff-stages command.
Date: Thu, 9 Jun 2005 15:30:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506091529230.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
 <7vis0o30sc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
 <7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net> <7v64woroui.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org> <7vaclzclqd.fsf@assigned-by-dhcp.cox.net>
 <7vekbbb2me.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 00:25:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgVRm-0001AS-Pe
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 00:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVFIW23 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 18:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVFIW23
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 18:28:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262494AbVFIW20 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 18:28:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j59MSBjA010782
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Jun 2005 15:28:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j59MSAm9026127;
	Thu, 9 Jun 2005 15:28:10 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vekbbb2me.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 9 Jun 2005, Junio C Hamano wrote:
>
> The diff-* brothers acquired a sibling, git-diff-stages.  With
> an unmerged index file, you specify two stage numbers and it
> shows the differences between them.

I hate how you do one big "main()" function that does it all.

I'll apply the patch, but really, this is pretty ugly.

		Linus
