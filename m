From: Sean <seanlkml@sympatico.ca>
Subject: Re: Current Issues #3
Date: Mon, 22 May 2006 07:19:29 -0400
Message-ID: <BAYC1-PASMTP11A8D53B4DD4B29078F810AE9A0@CEZ.ICE>
References: <7v8xoue9eo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605220216310.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 13:25:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi8XV-0007uB-DN
	for gcvg-git@gmane.org; Mon, 22 May 2006 13:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWEVLZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 07:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWEVLZ1
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 07:25:27 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:43688 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1750754AbWEVLZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 07:25:26 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 22 May 2006 04:30:15 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 8F2E5644C28;
	Mon, 22 May 2006 07:25:22 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060522071929.0be8d026.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605220216310.3697@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 May 2006 11:30:15.0562 (UTC) FILETIME=[18C13EA0:01C67D93]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 22 May 2006 03:18:02 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> [...]
> 
> but maybe this is overdesigned. Comments?


It all looks good, especially your description of the git pull variations
which seem more natural than what exists now.

The only minor comment i'd make is that we shouldn't mix so many different
names for the same thing.  In your example you have  "remote" (singular)
sections with branch sections that contain "source" keys which map to those
remote sections, both corresponding to "refs/remotes" (plural).

There doesn't seem to be any need to stick with "source" as a key, so :

[remote "origin/master"]
	repo = origin
	branch = master

[branch "master"]
	remote = "origin/master"

Sean
