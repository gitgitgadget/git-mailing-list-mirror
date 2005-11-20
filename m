From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Mon, 21 Nov 2005 00:58:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511210054260.24828@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org> <200511210026.30280.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 00:59:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edz4y-0001As-0n
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 00:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVKTX6g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 18:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVKTX6g
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 18:58:36 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47757 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932143AbVKTX6f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 18:58:35 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ED36A140167; Mon, 21 Nov 2005 00:58:34 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D61869F39C; Mon, 21 Nov 2005 00:58:34 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C3F8F9C78A; Mon, 21 Nov 2005 00:58:34 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A9E22140167; Mon, 21 Nov 2005 00:58:34 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511210026.30280.Josef.Weidendorfer@gmx.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12413>

Hi,

On Mon, 21 Nov 2005, Josef Weidendorfer wrote:

> On Sunday 20 November 2005 19:09, Linus Torvalds wrote:
> > 	[branches.origin]
> > 		url = master.kernel.org:/pub/scm/git/git.git
> > 		pull = master:origin
> 
> Two things:
> * base names are case insensitive. Repository shortcuts are case
> sensitive (and head names, too)
> * to get rid of .git/branches/XXX, XXX has to be allowed as
> base name. But XXX can contain anything a head name can (including ".").

Is it that important that nicks can be case sensitive or contain spaces or 
dots? I.e. is it sensible to make a difference between

	git pull Weidendorfer

and

	git pull weidendorfer
???

Also, I'd rather write

	git pull josef

than

	git pull "Josef Weidendorfer, III"

> Not really a problem. Use the ' for ' syntax:
> 
> [remotes]
> 	url = master.kernel.org:/pub/scm/git/git.git for origin
> 	pull = master:origin for origin
> 
> Not really nice. We can not have "for" as head name.

Not really nice. Looks ugly. Violates DRY. ("for blabla" would not need to 
be a problem; just enforce quotes around the name.)

Ciao,
Dscho
