From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Introduce ~/.gitconfig
Date: Thu, 8 Jun 2006 22:15:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606082212260.28323@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
 <1149775348.23938.236.camel@cashmere.sps.mot.com> <e69qev$nnl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 22:16:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoQv7-0006ed-O6
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 22:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWFHUPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 16:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWFHUPy
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 16:15:54 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15848 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964975AbWFHUPy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 16:15:54 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 17AC0D74;
	Thu,  8 Jun 2006 22:15:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0C301D69;
	Thu,  8 Jun 2006 22:15:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id D963CC7D;
	Thu,  8 Jun 2006 22:15:52 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e69qev$nnl$1@sea.gmane.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21508>

Hi,

On Thu, 8 Jun 2006, Jakub Narebski wrote:

> Jon Loeliger wrote:
> 
> > On Thu, 2006-06-08 at 06:30, Johannes Schindelin wrote:
> 
> >> - The --no-local flag [...]
> > 
> > Could we have multiple levels, and have names that call out
> > where it applies?  Perhaps something like:
> > 
> > --repo   into $GIT_DIR/.gitconfig  <- current default, right?
> > --home   into ~/.gitconfig
> > --site   into /etc/gitconfig
> > --share  into /usr/share/git/config
> 
> I like that too, wlthough --home might be named --user, and --share be 
> named --predefined or --library.

I am rather disinclined for the --share or --predefined flags, as these 
would only make sense for the administrator. And since this code was 
partly written by me, it eats small children.

Ciao,
Dscho
