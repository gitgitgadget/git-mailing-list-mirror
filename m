From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: undoing changes with git-checkout -f
Date: Tue, 10 Jan 2006 15:51:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601101549360.26054@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43C2D2C4.2010904@cc.jyu.fi> <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net>
 <20060110045533.GO18439@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 15:52:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwKqt-0005n9-Fq
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 15:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWAJOv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 09:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWAJOv4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 09:51:56 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48264 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751090AbWAJOvz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 09:51:55 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7A6C21412F8; Tue, 10 Jan 2006 15:51:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 6FACDFDF;
	Tue, 10 Jan 2006 15:51:52 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 4F20B9C2;
	Tue, 10 Jan 2006 15:51:52 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1938F1412F8; Tue, 10 Jan 2006 15:51:52 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20060110045533.GO18439@ca-server1.us.oracle.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14421>

Hi,

On Mon, 9 Jan 2006, Joel Becker wrote:

> On Mon, Jan 09, 2006 at 01:46:38PM -0800, Junio C Hamano wrote:
> > Please do not use rsync:// transport if possible (mvista might
> > only pubilsh via rsync:// and not git://, so it may not be your
> > fault).
> 
> 	Can we teach the git:// fetch program to use CONNECT over HTTP
> proxies?  rsync can do this, but git:// cannot, so firewalls that block
> 9418 mean we use rsync://

I think it is good and well with the proxy command support. Everybody can 
write a little script.

Otherwise, where would it end? If you include http_proxy functionality in 
git, why not also https_proxy functionality? And if that, why not 
IP-over-SMTP?

Hth,
Dscho
