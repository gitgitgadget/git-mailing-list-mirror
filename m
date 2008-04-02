From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can I switch a git-svn clone from a file => http url?
Date: Wed, 2 Apr 2008 15:47:48 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0804021546460.4008@racer.site>
References: <p06240804c41942f6276e@[192.168.1.114]>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 16:49:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh4GB-0002P0-KI
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 16:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779AbYDBOrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 10:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754910AbYDBOrg
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 10:47:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:43970 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754327AbYDBOrf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 10:47:35 -0400
Received: (qmail invoked by alias); 02 Apr 2008 14:47:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 02 Apr 2008 16:47:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+i7u4gnTqi2pRZEjV32lR2c2gTFb82fFPUrfbZbL
	IZg2kRqhpJPObo
X-X-Sender: gene099@racer.site
In-Reply-To: <p06240804c41942f6276e@[192.168.1.114]>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78695>

Hi,

On Wed, 2 Apr 2008, Stephen Bannasch wrote:

> Is there an operation I can now do to switch the base url from:
> 
>   file:///Path/to/svn/repository/projects
> 
> to
> 
>   https://svn.concord.org/svn/projects

Have you tried to edit the .git/config?  The key to look for is 
svn-remote.svn.url.

Hth,
Dscho
