From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: http push to WebDAV server fails (apache 2.2 under Win) - possible
 bug!?
Date: Fri, 13 Feb 2009 03:14:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902130314220.26370@racer>
References: <65B460DF-29D3-4651-93C9-794946DA8437@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Harald Weppner <harry.weppner@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 13 03:18:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXnd9-00019R-EY
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 03:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176AbZBMCPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 21:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbZBMCPG
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 21:15:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:59972 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752463AbZBMCPD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 21:15:03 -0500
Received: (qmail invoked by alias); 13 Feb 2009 02:15:01 -0000
Received: from pD9EB2452.dip0.t-ipconnect.de (EHLO noname) [217.235.36.82]
  by mail.gmx.net (mp036) with SMTP; 13 Feb 2009 03:15:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uLyBLiMsux0BJmjJ5mNOIEmJDU2mgYeuBsad7J+
	6SG/4uA9J5+85r
X-X-Sender: gene099@racer
In-Reply-To: <65B460DF-29D3-4651-93C9-794946DA8437@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109701>

Hi,

On Sun, 4 Jan 2009, Harald Weppner wrote:

> just trying to get started to host a remote repository on a WebDAV share 
> (served by apache2.2 on Windows). When I attempt to push from my local 
> repository it indicates a 405 failure on a PUT of a *opaquelocktoken:* 
> resource (cf. apache access log below). I don't know WebDAV in detail to 
> know what's going wrong here but the colon in the resource name looks 
> suspicious as it's not a permitted character under Windows. Could this 
> indeed be a problem of not escaping the resource name properly?

Could you try a recent 'next'?  We had a fix there which should solve your 
problem, too.

Ciao,
Dscho
