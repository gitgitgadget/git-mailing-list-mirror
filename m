From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push refspec problem
Date: Wed, 7 Nov 2007 15:11:46 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711071510480.4362@racer.site>
References: <7B37E361-9606-447C-B853-001182688AFA@nc.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: James <jtp@nc.rr.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:12:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmZd-0004o6-Es
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbXKGPLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbXKGPLv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:11:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:49078 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750819AbXKGPLu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:11:50 -0500
Received: (qmail invoked by alias); 07 Nov 2007 15:11:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 07 Nov 2007 16:11:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UD9dII3AU71YIMdPtjnt7bQQ1t6eUiDxNdILbvo
	Fv0f8vcFxv6+1n
X-X-Sender: gene099@racer.site
In-Reply-To: <7B37E361-9606-447C-B853-001182688AFA@nc.rr.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63818>

Hi,

On Wed, 7 Nov 2007, James wrote:

>        fetch = +refs/heads/*:refs/remotes/origin/*

This is a refspec.

>        push = ssh://james@my.server.com/home/james/scm/git/project.git/

This is a URL.  It does not specify any refs.  But "push =" expects a URL.

You probably want to setup a different remote if you want to push to a 
different URL than you are fetching from.

Hth,
Dscho
