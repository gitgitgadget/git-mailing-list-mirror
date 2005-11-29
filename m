From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix typo in http-push.c
Date: Tue, 29 Nov 2005 17:40:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511291739090.12136@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051129005154.GA3076@pitr.home.jan>
 <Pine.LNX.4.63.0511290923390.16927@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051129133537.GA490@pitr.home.jan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 17:49:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh8WY-0006hX-JG
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 17:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVK2QkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 11:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVK2QkF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 11:40:05 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:60891 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932114AbVK2QkE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 11:40:04 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0689213F7D7; Tue, 29 Nov 2005 17:40:03 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E1B2A9F492; Tue, 29 Nov 2005 17:40:02 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CAD2B8365C; Tue, 29 Nov 2005 17:40:02 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AC05613F7D7; Tue, 29 Nov 2005 17:40:02 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jan Andres <jandres@gmx.net>
In-Reply-To: <20051129133537.GA490@pitr.home.jan>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12947>

Hi,

On Tue, 29 Nov 2005, Jan Andres wrote:

> [...]
>
> +				lock->token = xmalloc(strlen(ctx->cdata + 16) + 1);
> 
> so as to account for the trailing NUL?

Of course! That's why I wanted to write "strlen(ctx->cdata + 15)", but I 
fsck'ed up. Sorry.

Ciao,
Dscho
