From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Last mile for 1.0 again
Date: Mon, 4 Jul 2005 14:59:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507041459030.3570@g5.osdl.org>
References: <Pine.LNX.4.21.0507041635350.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 00:00:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpYz8-0001zv-DP
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 00:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVGDV76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 17:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVGDV76
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 17:59:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261691AbVGDV75 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 17:59:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j64LxmjA023759
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 4 Jul 2005 14:59:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j64LxlE9005433;
	Mon, 4 Jul 2005 14:59:47 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507041635350.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 4 Jul 2005, Daniel Barkalow wrote:
> 
> How about an option to git-rev-list to take a path, and (1) exclude any
> branch where the version at that path ends up ignored in a merge and
> (2) not list any revision where the version at that path is identical to a
> parent?

Hmm. How is that different from "git-whatchanged path", really?

			Linus
