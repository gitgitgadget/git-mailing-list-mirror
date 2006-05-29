From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git commit --branch
Date: Mon, 29 May 2006 23:14:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605292310280.17412@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060529202851.GE14325@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 23:14:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkp4O-0003Ks-SF
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWE2VOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 17:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWE2VOe
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:14:34 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:7861 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751308AbWE2VOe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 17:14:34 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id A8316151A;
	Mon, 29 May 2006 23:14:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9BDFB1516;
	Mon, 29 May 2006 23:14:32 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 7317F1479;
	Mon, 29 May 2006 23:14:32 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060529202851.GE14325@admingilde.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20973>

Hi,

On Mon, 29 May 2006, Martin Waitz wrote:

> Sometimes it is neccessary to have some local modifications in the tree
> in order to test it and work with it.

Doesn't

$ git-update-index $(git-ls-files --modified)
$ git-checkout -b tempBranch
$ git-commit -m "to test"

work? It also avoids totally bogus parents (if I read your patch 
correctly, you take the current HEAD as the true parent, but record the 
current HEAD of the other branch as parent nevertheless).

Ciao,
Dscho
