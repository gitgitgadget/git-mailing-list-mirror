From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to commit removed file?
Date: Tue, 2 Jan 2007 23:20:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701022318480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061231102444.GD26552@mellanox.co.il> <20070102201041.GB10451@mellanox.co.il>
 <Pine.LNX.4.63.0701022211100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfyatt8di.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Tue Jan 02 23:20:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1rzn-00013b-Ny
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 23:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbXABWUc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 17:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbXABWUc
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 17:20:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:55356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964913AbXABWUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 17:20:32 -0500
Received: (qmail invoked by alias); 02 Jan 2007 22:20:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 02 Jan 2007 23:20:30 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyatt8di.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35831>

Hi,

On Tue, 2 Jan 2007, Junio C Hamano wrote:

> The difference is Michael did "git rm" to explicitly tell git to forget 
> about that path, while you used the vanilla "/bin/rm".

Ah. In this case, it is enough to just say "git commit"...

> Personally I never saw the point of having "git rm".  Maybe we should 
> remove it to prevent this confusion from happening.

People seem so used to "cvs remove" that they had to have "git rm". Dunno. 
I never used it. (Except to verify that indeed even "--" does not work 
with Michael's example.)

Ciao,
Dscho
