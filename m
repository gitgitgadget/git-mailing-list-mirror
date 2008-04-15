From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Tue, 15 Apr 2008 11:18:39 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804151115250.2879@woody.linux-foundation.org>
References: <20080415172333.GA29489@linux-sh.org> <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mundt <lethal@linux-sh.org>
X-From: linux-sh-owner@vger.kernel.org Tue Apr 15 20:30:54 2008
connect(): Connection refused
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlplb-0001KA-O3
	for glps-linuxsh-dev@gmane.org; Tue, 15 Apr 2008 20:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYDOSTr (ORCPT <rfc822;glps-linuxsh-dev@m.gmane.org>);
	Tue, 15 Apr 2008 14:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbYDOSTr
	(ORCPT <rfc822;linux-sh-outgoing>); Tue, 15 Apr 2008 14:19:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59432 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752101AbYDOSTq (ORCPT
	<rfc822;linux-sh@vger.kernel.org>); Tue, 15 Apr 2008 14:19:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3FIIeRP014236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Apr 2008 11:18:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3FIIde4008493;
	Tue, 15 Apr 2008 11:18:39 -0700
In-Reply-To: <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.983 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79615>



On Tue, 15 Apr 2008, Linus Torvalds wrote:
> 
> Paul, your git tree is odd. Not quite corrupt, but it doesn't really 
> follow the rules either.

Anyway, I pulled the result (with my version of git that removes empty 
space at the beginning for the merge summary), and pushed it out. So it's 
merged, but I'd still like to know what tool actually created those extra 
spaces in the commit..

A regular "git commit" or "git am" should always strip whitespace. I 
assume it's something like stgit or other?

				Linus
