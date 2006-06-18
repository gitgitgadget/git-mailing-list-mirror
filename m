From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Sun, 18 Jun 2006 14:26:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606181417090.26803@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vpsh75lx1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 14:26:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrwM8-0000mq-SY
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 14:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWFRM0Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 08:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWFRM0Q
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 08:26:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:11226 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932199AbWFRM0P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 08:26:15 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 7FBDC2458;
	Sun, 18 Jun 2006 14:26:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 73C412457;
	Sun, 18 Jun 2006 14:26:14 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 561CB209F;
	Sun, 18 Jun 2006 14:26:14 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsh75lx1.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22075>

Hi,

On Sat, 17 Jun 2006, Junio C Hamano wrote:

>       Read configuration also from ~/.gitconfig
>       repo-config: learn the flag "--no-local"
> 
>    I see Pasky has proposed another config change (this time,
>    not "also from" but "alternatively from") -- I am not sure
>    which one is more appropriate.  Waiting for Johannes's
>    response to Pasky's message and hoping the list can agree on
>    a single patch series to apply to "next".

There is one thing I don't like about Pasky's approach: You can change the 
config file name to whatever you like, even if no program will read it. 
That is why I decided to have a flag instead of an option: to prevent 
pilot-errors.

But hey, that is just me.

I cobbled together a patch, which turned out to be rather messy, 
introducing "--config-file <file>" to git-repo-config. If people are 
interested, I'll clean it up and post it. But then, if you already know 
you want to use another config file, you are probably better of just 
exporting GIT_CONFIG_FILE and be done with it.

Note that this issue is orthogonal to the need for a user-specific config 
file. I still think that this one should go in.

Ciao,
Dscho
