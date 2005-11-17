From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 14:39:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511171436170.13358@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11322339372137-git-send-email-matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 14:41:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecjz5-0002PH-NY
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 14:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVKQNjZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 08:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVKQNjZ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 08:39:25 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:22762 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750820AbVKQNjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 08:39:24 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8D39313FAED; Thu, 17 Nov 2005 14:39:23 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 707E79F33C; Thu, 17 Nov 2005 14:39:23 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 43B6398FA6; Thu, 17 Nov 2005 14:39:23 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B2C6313FB46; Thu, 17 Nov 2005 14:39:21 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <11322339372137-git-send-email-matlads@dsmagic.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12113>

Hi,

On Thu, 17 Nov 2005, Martin Atukunda wrote:

> This patch series attempts to add .git/version support to init-db.c.

Wouldn't it make more sense to add the variable VERSION to git-var? After 
all, git is designed to be backwards compatible; newer versions are 
supposed to work with ancient repositories.

I think you are more interested in knowing which version the tools are at.

Ciao,
Dscho
