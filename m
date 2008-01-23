From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-clean buglet
Date: Wed, 23 Jan 2008 15:29:36 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801231528520.5731@racer.site>
References: <479759EC.4010002@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 23 16:30:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHhYM-0003JF-Mu
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 16:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbYAWP3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 10:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752667AbYAWP3o
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 10:29:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:48132 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751700AbYAWP3o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 10:29:44 -0500
Received: (qmail invoked by alias); 23 Jan 2008 15:29:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 23 Jan 2008 16:29:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wK1wwSFzwh4VxDS/ZWB1zlGeiA/2Q/AIJAods2D
	VzJKpBovJowUNY
X-X-Sender: gene099@racer.site
In-Reply-To: <479759EC.4010002@viscovery.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71546>

Hi,

On Wed, 23 Jan 2008, Johannes Sixt wrote:

> Try this in your favorite git repo:
> 
>     git clean -n /

That's an absolute path.  Like almost _all_ git commands, clean only 
takes relative ones.  You probably meant "git clean -n".

Hth,
Dscho
