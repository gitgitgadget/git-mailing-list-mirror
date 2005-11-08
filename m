From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fix t5000-tar-tree.sh when $TAR isn't set
Date: Tue, 8 Nov 2005 12:51:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511081250020.2649@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0511080245m12ed5fe0ha0ed98ca25e2f6e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 12:52:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZS1D-0002b3-SN
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 12:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVKHLvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 06:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbVKHLvz
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 06:51:55 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:20185 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965139AbVKHLvy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 06:51:54 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DA0CEDB48C; Tue,  8 Nov 2005 12:51:53 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BEC3AB50EE; Tue,  8 Nov 2005 12:51:53 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A302BB4FCA; Tue,  8 Nov 2005 12:51:53 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4C93DDB48C; Tue,  8 Nov 2005 12:51:53 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0511080245m12ed5fe0ha0ed98ca25e2f6e9@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11326>

Hi,

On Tue, 8 Nov 2005, Alex Riesen wrote:

> $TAR isn't set everywhere. Provide a default (tar)

You run "sh t5000*" in t/, right? Usually, TAR is set in t/Makefile (that 
is why it Just Works in the normal case). Note that you can -- instead of 
your patch -- run "TAR=tar sh t5000*".

Ciao,
Dscho
