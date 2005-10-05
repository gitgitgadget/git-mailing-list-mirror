From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Tue, 4 Oct 2005 21:56:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510042155090.31407@g5.osdl.org>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 06:58:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EN1Lw-0000XV-Oc
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 06:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbVJEE5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 00:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVJEE5G
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 00:57:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965084AbVJEE5F (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 00:57:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j954ux4s020319
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 4 Oct 2005 21:57:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j954uwQi029720;
	Tue, 4 Oct 2005 21:56:58 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.119 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9699>



On Tue, 4 Oct 2005, Junio C Hamano wrote:
> 
>  * I will be placing this in the proposed updates branch.
>    Hopefully this would alleviate the complaints from people who
>    find the "no fuzz" policy of git-apply is too strict.

This should definitely be enabled by a switch only. 

For example, I use git-applypatch _only_ through git-applymbox. Ie 
non-interactively. I definitely do _not_ want it to try random other trees 
unless I tell it to, especially when applying a series of 175 patches in 
one go.

		Linus
