From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Don't fetch objects that exist in the local repository
Date: Sat, 8 Oct 2005 00:50:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510080047500.20922@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051007220151.GB4989@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 00:51:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO13U-0006e6-FG
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 00:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbVJGWvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 18:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbVJGWvF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 18:51:05 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34724 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030556AbVJGWvE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 18:51:04 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CE9BF13F002; Sat,  8 Oct 2005 00:51:00 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AFF759DD32; Sat,  8 Oct 2005 00:51:00 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 95E889A007; Sat,  8 Oct 2005 00:50:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3470C13F002; Sat,  8 Oct 2005 00:50:53 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051007220151.GB4989@reactrix.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9823>

Hi,

On Fri, 7 Oct 2005, Nick Hengeveld wrote:

> Be sure not to fetch objects that already exist in the local repository.

Really? I seem to recall a dispute I had with Linus that this is 
unacceptable. He seems worried about incomplete fetches.

Only objects which are descendants of refs are safe, since the refs are 
written only after the objects were fetched successfully.

Ciao,
Dscho
