From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Allow dot files in ls-files as well.
Date: Tue, 24 May 2005 17:54:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241753300.2307@ppc970.osdl.org>
References: <7vhdgstb7x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505241723060.2307@ppc970.osdl.org> <7v8y24taai.fsf@assigned-by-dhcp.cox.net>
 <7v1x7wt9qm.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 02:51:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dak6q-0005gn-6f
	for gcvg-git@gmane.org; Wed, 25 May 2005 02:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVEYAwg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 20:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVEYAwg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 20:52:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:8630 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262218AbVEYAwd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 20:52:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4P0qSjA007117
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 17:52:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4P0qRXr028135;
	Tue, 24 May 2005 17:52:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x7wt9qm.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Junio C Hamano wrote:
> 
> No matter what you end up doing, you would need something like
> this as well (I am not screening .git here but that should be
> easy for you to add).

Ehh, this will do bad things for "git-show-files --others", no?

You really _do_ want to strip out the ".git" file.

		Linus
