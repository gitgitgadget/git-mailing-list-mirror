From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git push .git/branches shorthand
Date: Mon, 8 Aug 2005 11:10:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508081106580.26210@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7viryhgdo5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 11:12:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E23eg-0002fv-CF
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 11:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVHHJKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 05:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVHHJKn
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 05:10:43 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:716 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750783AbVHHJKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 05:10:43 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 06CF2E3306; Mon,  8 Aug 2005 11:10:40 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D39D29C7F4; Mon,  8 Aug 2005 11:10:39 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A9447990D0; Mon,  8 Aug 2005 11:10:39 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0A44AE32D5; Mon,  8 Aug 2005 11:10:39 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viryhgdo5.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 7 Aug 2005, Junio C Hamano wrote:

> I hear a lot of people mention $GIT_DIR/branches/ is confusing.
> Maybe we should rename it to $GIT_DIR/remote/ directory?

I'd prefer $GIT_DIR/remotes/. And I propose another extension: Since the 
files stored therein right now contain only one <remote> string, it should 
be possible to add the default head(s) to the file.

Ciao,
Dscho
