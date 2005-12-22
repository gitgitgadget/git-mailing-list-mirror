From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Add "write-index" hook
Date: Thu, 22 Dec 2005 01:35:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512220134170.14582@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512220055050.13515@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Dec 22 01:36:06 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpERA-00033g-Qb
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 01:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVLVAgB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 19:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVLVAgB
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 19:36:01 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27576 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964831AbVLVAgA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 19:36:00 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 79C7413F8CB
	for <git@vger.kernel.org>; Thu, 22 Dec 2005 01:35:59 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 60C029E2C1
	for <git@vger.kernel.org>; Thu, 22 Dec 2005 01:35:59 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 4C85D9E2B3
	for <git@vger.kernel.org>; Thu, 22 Dec 2005 01:35:59 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 3143D13F8CB
	for <git@vger.kernel.org>; Thu, 22 Dec 2005 01:35:59 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0512220055050.13515@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13925>

Hi,

there is an obvious bug in this patch: both calls to run_hook() have to 
have a final NULL argument.

Ciao,
Dscho

P.S.: The reason I did not find this earlier was that I had hooks 
installed, but they were not executable, and thus did not get executed. 
D'oh!
