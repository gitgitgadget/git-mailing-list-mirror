From: sean <seanlkml@sympatico.ca>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 13:52:50 -0400
Message-ID: <BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<e2kgga$d7q$1@sea.gmane.org>
	<7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604250811230.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
	<e2lijt$aco$1@sea.gmane.org>
	<Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 19:57:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYRmn-0005ML-LA
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 19:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWDYR5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 13:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWDYR5O
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 13:57:14 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:28568 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932099AbWDYR5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 13:57:14 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Apr 2006 10:58:41 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 1AF1F644C28;
	Tue, 25 Apr 2006 13:57:09 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060425135250.5fd889f4.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 25 Apr 2006 17:58:41.0875 (UTC) FILETIME=[E33F2230:01C66891]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 25 Apr 2006 10:11:13 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Once you start adding data that has no clear semantics, you're screwed. At 
> that point, it's a "track guesses" game, not a "track contents" game.

Then shouldn't Git stop tracking commit comments; they're just developer
guesses. ;o)   Adding a free-form header is no different than adding a 
few more lines of free form text at the bottom of the commit message, in 
neither case does it change the nice clean git semantics.

Sean
