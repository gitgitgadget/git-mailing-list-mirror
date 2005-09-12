From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add "git grep" helper
Date: Mon, 12 Sep 2005 14:37:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121434410.3266@g5.osdl.org>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
 <118833cc0509121357698005fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 12 23:39:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEvzh-0008Tt-5m
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 23:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVILVhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 17:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVILVhh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 17:37:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932275AbVILVhg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 17:37:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CLbUBo022918
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 14:37:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CLbTfr021575;
	Mon, 12 Sep 2005 14:37:29 -0700
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0509121357698005fe@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8437>



On Mon, 12 Sep 2005, Morten Welinder wrote:
>
> Cute, but what about grep flags like "-w", "-n", and "-c"?

Hey, add them to the flags list. Or just pass in all flags to grep, I
dunno (I was kind of expecting some flags to go to git-ls-files, but that
may or may not make any sense, and my script obviously didn't end up doing
that).

		Linus
