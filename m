From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix typo in http-push.c
Date: Tue, 29 Nov 2005 09:24:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511290923390.16927@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051129005154.GA3076@pitr.home.jan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 11:20:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh0nH-00063r-HZ
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 09:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVK2IYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 03:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVK2IYw
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 03:24:52 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:53933 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750908AbVK2IYv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 03:24:51 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 60F1913FB94; Tue, 29 Nov 2005 09:24:48 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 40D59B5371; Tue, 29 Nov 2005 09:24:48 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 22441B536F; Tue, 29 Nov 2005 09:24:48 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D562F13FB94; Tue, 29 Nov 2005 09:24:47 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jan Andres <jandres@gmx.net>
In-Reply-To: <20051129005154.GA3076@pitr.home.jan>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12933>

Hi,

On Tue, 29 Nov 2005, Jan Andres wrote:

> -				lock->token = xmalloc(strlen(ctx->cdata - 15));
> +				lock->token = xmalloc(strlen(ctx->cdata) - 15);
>  				strcpy(lock->token, ctx->cdata + 16);

Why not

+				lock->token = xmalloc(strlen(ctx->cdata + 16));

Ciao,
Dscho
