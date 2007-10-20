From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Deduce exec_path also from calls to git with a relative
 path
Date: Sat, 20 Oct 2007 22:25:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710202224450.25221@racer.site>
References: <20071020064617.GC2237@srparish.net> <Pine.LNX.4.64.0710200818410.25221@racer.site>
 <20071020122516.GA23190@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott R Parish <srp@srparish.net>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 04:52:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjQvf-00037P-5C
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 04:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbXJUCw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 22:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbXJUCw2
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 22:52:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:39243 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750957AbXJUCw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 22:52:28 -0400
Received: (qmail invoked by alias); 20 Oct 2007 21:25:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 20 Oct 2007 23:25:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lQvNuzFwlrkDlHZo71X+42tGs+HQ+wLxuhsTbH0
	fuanNxzY7mHJER
X-X-Sender: gene099@racer.site
In-Reply-To: <20071020122516.GA23190@old.davidb.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61868>

Hi,

On Sat, 20 Oct 2007, David Brown wrote:

> On Sat, Oct 20, 2007 at 08:21:34AM +0100, Johannes Schindelin wrote:
> 
> > For example, when you call "../../hello/world/git", it will not turn 
> > "../../hello/world" into an absolute path, and use that.
> 
> Did you mean "it will turn..."?

Yes, I meant that.  I was in a hurry, since a car was waiting outside the 
door, taking me to the highlands.

Ciao,
Dscho
