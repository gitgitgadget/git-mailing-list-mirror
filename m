From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 20:52:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507112050300.17536@g5.osdl.org>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
 <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
 <7voe98g3ws.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507112010120.17536@g5.osdl.org>
 <7v8y0cg07c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marc Singer <elf@buici.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 05:52:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsBon-0004i6-86
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 05:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVGLDwS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 23:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVGLDwS
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 23:52:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262313AbVGLDwR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 23:52:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C3qBjA019157
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 20:52:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C3q56k020121;
	Mon, 11 Jul 2005 20:52:07 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y0cg07c.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Junio C Hamano wrote:
> 
> I do not quite follow your objections.  I do not think I am
> forcing anybody to name an old thing.

Sure you are. You're forcing them to make a choice, where both choices 
are bad. Either:

 - name an old thing (that you may not even have worked on - "master" from 
   a newly cloned repo)

 - throw the old master state away ("--force")

Either choice is bad.

		Linus
