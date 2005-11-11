From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: merge-recursive: include heapq?
Date: Fri, 11 Nov 2005 15:23:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511111520260.7575@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Nov 11 15:26:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaZoD-0003tg-7i
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 15:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVKKOXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 09:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVKKOXH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 09:23:07 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21409 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750792AbVKKOXF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 09:23:05 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id E4A4613F302
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 15:23:04 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id C3B46B5144
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 15:23:04 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 9D042B35C8
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 15:23:04 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 8992213F302
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 15:23:04 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11599>

Hi,

I get this when pulling:

-- snip --
Traceback (most recent call last):
  File "./git-merge-recursive", line 4, in ?
    from heapq import heappush, heappop
ImportError: No module named heapq
-- snap --

Okay, my python is *old*:

$ python -V
Python 2.2.1

Is it worthwhile to include heapq as we did with subprocess? Or should I 
upgrade...

Ciao,
Dscho
