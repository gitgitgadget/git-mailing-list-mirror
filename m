From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Add git-send-email-script - tool to send emails from
 git-format-patch-script
Date: Sun, 31 Jul 2005 12:25:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507311223240.16181@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <11227978451100@foobar.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 12:25:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzB0g-0008QR-TG
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 12:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVGaKZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 06:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbVGaKZY
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 06:25:24 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6609 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261398AbVGaKZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 06:25:22 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 95AD2E2093; Sun, 31 Jul 2005 12:25:21 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 74D87AAAA7; Sun, 31 Jul 2005 12:25:21 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 02A14AAA66; Sun, 31 Jul 2005 12:25:15 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 87FB7E2054; Sun, 31 Jul 2005 12:25:13 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <11227978451100@foobar.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

wouldn't it be a good idea to make $from and $to required parameters? At
least you could infer a sensible default of $from from GIT_* environment
variables, no? I am not quite comfortable with a hard coded sender in a
script possibly deployed into a multi-user environment.

Ciao,
Dscho
