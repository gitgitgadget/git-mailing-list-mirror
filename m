From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-rev-list --invert-match
Date: Thu, 20 Sep 2007 11:32:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709201132381.28395@racer.site>
References: <20070919202615.GK3076@jukie.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bart Trojanowski <bart@jukie.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 12:34:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYJMC-00086b-9P
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 12:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbXITKdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 06:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbXITKdq
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 06:33:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:40383 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752044AbXITKdp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 06:33:45 -0400
Received: (qmail invoked by alias); 20 Sep 2007 10:33:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 20 Sep 2007 12:33:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19y0lp+UmdynvNCURvH9q1eT5XRctYlwZzZFY3HQW
	rhA4EPxAsldlez
X-X-Sender: gene099@racer.site
In-Reply-To: <20070919202615.GK3076@jukie.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58766>

Hi,

On Wed, 19 Sep 2007, Bart Trojanowski wrote:

>   git log --invert-match --grep="uninteresting"

IMHO this is only half a solution.  Some of us want to say "git log 
--grep=this --but-not-(in-the-whole-message) --grep=that".

Your code would be obsoleted by such a method (since it cannot be 
extended), and further would also benefit git-grep, not only git-log.

Ciao,
Dscho
