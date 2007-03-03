From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull fails to exit with non-zero status after fatal error
Date: Sat, 3 Mar 2007 23:49:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703032348570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45E9A641.8020002@lightspeed.com>
 <Pine.LNX.4.63.0703031913100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vabyu9hcp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703032210010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070303212348.GA17796@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Larry Streepy <larry@lightspeed.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 23:49:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNd2c-0001xr-Ex
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 23:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030554AbXCCWtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 17:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030619AbXCCWtW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 17:49:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:46325 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030554AbXCCWtV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 17:49:21 -0500
Received: (qmail invoked by alias); 03 Mar 2007 22:49:20 -0000
X-Provags-ID: V01U2FsdGVkX1/J18t9Dy7Jrz97ufj8vs2b4jmV0Ko+Z9bWuzcBhZ
	6g9n+wC7bb79i/
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070303212348.GA17796@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41336>

Hi,

On Sat, 3 Mar 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sat, 3 Mar 2007, Junio C Hamano wrote:
> > 
> > > -	finish "$new_head" "Fast forward"
> > > +	finish "$new_head" "Fast forward" || exit
> > 
> > Doesn't "exit" default to "exit 0"?
> 
> No, it carries the exit status of the prior failed command if the
> prior command failed.  ;-)

You live and learn, live and learn...

Thanks,
Dscho
