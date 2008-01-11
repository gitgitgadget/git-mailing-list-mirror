From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use commit template when cherry picking
Date: Fri, 11 Jan 2008 12:10:37 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801111208020.31053@racer.site>
References: <20080111074505.GC14022@plexity.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Perry Wagle <pwagle@mvista.com>
To: Deepak Saxena <dsaxena@plexity.net>
X-From: git-owner@vger.kernel.org Fri Jan 11 13:12:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDIkB-0005MC-SP
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 13:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759898AbYAKMKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 07:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759299AbYAKMKq
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 07:10:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:35432 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758662AbYAKMKo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 07:10:44 -0500
Received: (qmail invoked by alias); 11 Jan 2008 12:10:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 11 Jan 2008 13:10:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RxBsvCTWR7KfdaPCGe5KousARAPKHxAHRtXRHp3
	nJWAjSss8STw8u
X-X-Sender: gene099@racer.site
In-Reply-To: <20080111074505.GC14022@plexity.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70150>

Hi,

On Thu, 10 Jan 2008, Deepak Saxena wrote:

> We are using git to manage our kernel tree and we often cherry-pick 
> patches from upstream and while we want to save the original commit 
> message, we also want to apply our default commit header to the log. If 
> this patch is not the ideal solution, please let me know how I should go 
> about this.

I would do a combination of "cherry-pick -n", "cat-file commit <commit> | 
sed '1,/^$/d'" and "commit -F" or "commit -f".

You can make this an alias, too.

Hth,
Dscho
