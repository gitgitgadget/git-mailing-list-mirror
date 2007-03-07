From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push failure over webdav if no trailing slash on URL
Date: Wed, 7 Mar 2007 23:01:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703072258330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <m33b4hylw3.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: James Cloos <cloos+vger-git@jhcloos.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 23:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP4DG-00019e-V3
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 23:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992462AbXCGWCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 17:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992458AbXCGWCJ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 17:02:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:39216 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992433AbXCGWBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 17:01:49 -0500
Received: (qmail invoked by alias); 07 Mar 2007 22:01:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 07 Mar 2007 23:01:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jY3wm5p6jxwhfxNECNrrxuZq5eCdTv6f+qRMAba
	oq13J3lKH3Td1y
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <m33b4hylw3.fsf@lugabout.jhcloos.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41697>

Hi,

On Wed, 7 Mar 2007, James Cloos wrote:

> If instead I ran:
> 
> git push http://NAME:PW@SITE/git/foo/bar/
> 
> (specifying that trailing slash) everything worked as expected.

It is vaguely described in 
Documentation/howto/setup-git-server-over-http.txt lines 211--

I also wanted to fix that behaviour, but since the trailing slash fixes 
push, never got around to do it.

Ciao,
Dscho
