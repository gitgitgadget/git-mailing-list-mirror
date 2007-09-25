From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git-tag's over-aggressive pipework fails badly on fresh Ubuntu,
 over NFS.
Date: Wed, 26 Sep 2007 00:01:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709260000340.28395@racer.site>
References: <87hclifk7i.wl@betelheise.deep.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Samium Gromoff <_deepfire@feelingofgreen.ru>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJQE-0007pP-W1
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 01:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbXIYXCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 19:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbXIYXCX
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 19:02:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:59327 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750780AbXIYXCX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 19:02:23 -0400
Received: (qmail invoked by alias); 25 Sep 2007 23:02:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 26 Sep 2007 01:02:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SMSguQDvSoWeF/DjBChiLmXaRpDwKaoUfq4OZk3
	xVRHXPRU8G4d3u
X-X-Sender: gene099@racer.site
In-Reply-To: <87hclifk7i.wl@betelheise.deep.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59189>

Hi,

On Wed, 26 Sep 2007, Samium Gromoff wrote:

> Without the following applied, git-tag -s gets zeroes into TAG_TMP
> in place of the .asc sig, resulting in an unsigned commit.

You'll be delighted to hear that it is no longer necessary to patch 
git-tag.sh (git-tag is not the right place), since git-tag is now a 
builtin (without much in the way of pipes...)

Ciao,
Dscho
