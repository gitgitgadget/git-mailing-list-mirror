From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote information
 in the config
Date: Sun, 30 Apr 2006 17:52:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604301749130.3641@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
 <e32h0o$15n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 17:52:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaEDV-0007V7-Mr
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 17:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWD3PwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 11:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWD3PwK
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 11:52:10 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56985 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751156AbWD3PwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 11:52:09 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 076241B8E;
	Sun, 30 Apr 2006 17:52:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id EF87E1C8C;
	Sun, 30 Apr 2006 17:52:07 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id DCB241B8E;
	Sun, 30 Apr 2006 17:52:07 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e32h0o$15n$1@sea.gmane.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19343>

Hi,

On Sun, 30 Apr 2006, Jakub Narebski wrote:

> There was thread about storing somewhere default branch we merge to during
> pull, instead of using always surrent one. Different schemes were proposed,
> most of them depending on the remotes configuration being available [also]
> in config file.

I was not following that thread closely, since it became too confusing for 
me. However, I think that my patch could be a start in that direction.

> By the way: it would be nice to have command/script to trasform freely
> between 'remotes/' and config file.

If you set the environment variable GIT_REWRITE_REMOTES to "true", and 
call git-parse-remotes.sh, it will do the rewriting to the config file. 
Obviously, I did not test that part of the patch all that well.

> P.S. I wonder if it would be difficult to implement 'include <file>' for
> config file...

You really need that?

Ciao,
Dscho
