From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 1/2] Use remote information in .git/config
Date: Fri, 25 Nov 2005 02:08:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511250208110.28437@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511211452470.13775@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4q65sst3.fsf@assigned-by-dhcp.cox.net> <41D1FCC0-E031-48FB-82A2-6CFDA2E03AC0@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 25 02:09:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfS5R-0005B3-Ij
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 02:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbVKYBIv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 20:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbVKYBIv
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 20:08:51 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:43689 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932679AbVKYBIu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 20:08:50 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EFBE613FB98; Fri, 25 Nov 2005 02:08:46 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D7604B530D; Fri, 25 Nov 2005 02:08:46 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B38D4B52FB; Fri, 25 Nov 2005 02:08:46 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 46E6013FB98; Fri, 25 Nov 2005 02:08:46 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <41D1FCC0-E031-48FB-82A2-6CFDA2E03AC0@hawaga.org.uk>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12723>

Hi,

On Fri, 25 Nov 2005, Ben Clifford wrote:

> On 22 Nov 2005, at 05:29, Junio C Hamano wrote:
> 
> > Personally I do not mind moving remotes/branches information
> > there, except that I suspect the git-config-set interface makes
> > it cumbersome to (1) find out what remotes I defined (i.e. an
> > equivalent of "ls .git/remotes")
> 
> (1) is useful to be able to do in a very lightweight way when doing tab
> completion on remotes. Having heads, tags, remotes in nicely named separate
> files makes that pretty straightforward; I don't know if using a git-config-
> accessor would make this noticeably worse, though, as I haven't tried anything
> out there yet.

	 git-var -l | sed -n "s/^remote\.\([A-Za-z0-9]*\)\.url=.*$/\1/p"

Hth,
Dscho
