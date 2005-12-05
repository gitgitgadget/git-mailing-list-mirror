From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Weirdness with port-update hook and local push
Date: Mon, 5 Dec 2005 21:40:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512052138560.6554@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0512051530560.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 21:42:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjN8E-0003t0-GG
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 21:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVLEUkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 15:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbVLEUkN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 15:40:13 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32205 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751437AbVLEUkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 15:40:12 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2DC1A13FAA9; Mon,  5 Dec 2005 21:40:11 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 159339F55D; Mon,  5 Dec 2005 21:40:11 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 015299DBC8; Mon,  5 Dec 2005 21:40:11 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B26B713FAA9; Mon,  5 Dec 2005 21:40:10 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0512051530560.25300@iabervon.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13228>

Hi,

On Mon, 5 Dec 2005, Daniel Barkalow wrote:

> I have the following post-update hook:
> 
> -----
> #!/bin/sh
> 
> unset GIT_DIR
> cd /home/barkalow/auto-working/web
> if ! git pull /home/barkalow/git/web.git/
> then
>   exit 1  
> fi
> make
> -----
> 
> >From that "git pull", I'm getting:
> 
> /home/barkalow/bin/git-pull: line 108: 30608 Broken pipe      git-merge $no_summary $no_commit $strategy_args "$merge_name" HEAD $merge_head
> 
> It works fine when pushing over ssh,

Maybe it runs as a different user? (Sorry if this sounds dumb, but that's 
exactly the kind of solution I usually find after *days*.)

Hth,
Dscho
