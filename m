From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rerere observations and feature suggestions
Date: Tue, 17 Jun 2008 11:24:35 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806171122130.6439@racer>
References: <20080616110113.GA22945@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Jun 17 12:27:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8YPF-0005CB-JG
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 12:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbYFQK0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 06:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754425AbYFQK0O
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 06:26:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:55986 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754558AbYFQK0N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 06:26:13 -0400
Received: (qmail invoked by alias); 17 Jun 2008 10:26:12 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp050) with SMTP; 17 Jun 2008 12:26:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PxTgi88zPCdui0xdGeZKS8pcKpH9+3qziDm2ZNf
	gERo64a/4OGw2z
X-X-Sender: gene099@racer
In-Reply-To: <20080616110113.GA22945@elte.hu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85286>

Hi,

On Mon, 16 Jun 2008, Ingo Molnar wrote:
>
>  - Sharing .git/rr-cache. It's quite a PITA to share the .git/rr-cache 
>    amongst -tip maintainers right now. It seems to have dependencies on 
>    the index file, so if we want to share the conflict resolution data, 
>    we have to copy our index file (which is dangerous anyway and assumes 
>    very similar repositories).

I was dreaming about having "git rerere infer-from <merge-commit>".  This 
would be

- more versatile, as you do not have to ask the guy to share the cache,

- would avoid transmitting lots of data that can be inferred from the 
  data,

- would avoid relying on the honesty of the person sharing the cache, and

- it would put all license wieners^Wissues at rest.

FWIW this is in my TODO list, but I am unlikely to get to it, least of all 
before 1.5.6 comes out.

Ciao,
Dscho
