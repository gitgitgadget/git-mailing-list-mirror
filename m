From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-filehistory (3rd try at detecting renames)
Date: Fri, 21 Oct 2005 01:32:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510210130480.10503@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4dd15d180510201423y5e200b68xec32bffec0f0cf84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 01:33:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESjtv-00086X-1m
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 01:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVJTXco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 19:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVJTXco
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 19:32:44 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:38801 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932208AbVJTXcn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 19:32:43 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E791813EA55; Fri, 21 Oct 2005 01:32:42 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CEF539EF58; Fri, 21 Oct 2005 01:32:42 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B9F4A9EDBD; Fri, 21 Oct 2005 01:32:42 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8558513EA55; Fri, 21 Oct 2005 01:32:42 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Ho <davidkwho@gmail.com>
In-Reply-To: <4dd15d180510201423y5e200b68xec32bffec0f0cf84@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10384>

Hi,

On Thu, 20 Oct 2005, David Ho wrote:

> Sorry, once again, this calls git-diff-tree once per commit.

How about detecting renames only when the tree does not have an object of 
the same name? You could even use the pathspec optimizations to track just 
that file through history, and do a git-diff-tree on the last commit 
containing that file.

Ciao,
Dscho
