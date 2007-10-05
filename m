From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] setup/rev-parse: allow HEAD to be spelled 'head'
Date: Fri, 5 Oct 2007 04:16:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710050415080.4174@racer.site>
References: <1191553750-25562-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Oct 05 05:16:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iddfz-0000Xx-Qc
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 05:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbXJEDQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 23:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbXJEDQX
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 23:16:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:59541 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755100AbXJEDQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 23:16:22 -0400
Received: (qmail invoked by alias); 05 Oct 2007 03:16:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 05 Oct 2007 05:16:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18s/SkhMxEsRS1Kvt45L+54zujK6F6Z4MYNY4lpYv
	XsAflZxNME8FJj
X-X-Sender: gene099@racer.site
In-Reply-To: <1191553750-25562-1-git-send-email-sam.vilain@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60034>

Hi,

On Fri, 5 Oct 2007, Sam Vilain wrote:

> If the repository got mangled by FAT capitalization rules, then a ref 
> such as "HEAD" will become "head" once it is back on a non-FAT FS.

Can we have that optionally, please?  I.e. triggered by something like 
"core.caseChallengedFS = true"?

Ciao,
Dscho
