From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 18:11:50 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801111752360.13593@iabervon.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 00:12:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDT30-0000VF-PC
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 00:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761821AbYAKXLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 18:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762079AbYAKXLw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 18:11:52 -0500
Received: from iabervon.org ([66.92.72.58]:38471 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758179AbYAKXLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 18:11:52 -0500
Received: (qmail 26082 invoked by uid 1000); 11 Jan 2008 23:11:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2008 23:11:50 -0000
In-Reply-To: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70220>

I'm not sure if this is actually relevant to your situation, but I've got 
a patch (which I'll probably send post-1.5.4) to allow configuration of 
aliases for URLs, such that git will rewrite (for example) 
master.kernel.org:/pub/... to git://git.kernel.org/pub/...; if you're 
reading a discussion between kernel.org users on the linux-kernel mailing 
list and you don't have a kernel.org account, and you want to try things, 
this patch makes it a lot easier (cut-and-paste the URL you can't actually 
use, and it uses the variant you prefer without making you deal with it 
for each URL).

If, for each person, there's a single best access method to the data, but 
there's no single access method that works for all of the participants, 
they could use this patch, and use per-user configuration to replace all 
of the other possible names with the one they have to use.

	-Daniel
*This .sig left intentionally blank*
