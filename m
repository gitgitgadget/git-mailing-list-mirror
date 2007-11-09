From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: corrupt object on git-gc
Date: Fri, 09 Nov 2007 16:34:38 +0100
Message-ID: <47347E0E.1040205@viscovery.net>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>	 <473464A2.7080003@op5.se> <4fe79b4b0711090701g7a43cdfdi5e20e5ffb437d7bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Yossi Leybovich <sleybo@mellanox.co.il>
To: Yossi Leybovich <sleybo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqVst-0000qE-8o
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 16:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763002AbXKIPeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 10:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762907AbXKIPeo
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 10:34:44 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17942 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762789AbXKIPen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 10:34:43 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IqVs2-0000WD-4z; Fri, 09 Nov 2007 16:34:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E097B6C4; Fri,  9 Nov 2007 16:34:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <4fe79b4b0711090701g7a43cdfdi5e20e5ffb437d7bb@mail.gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64202>

Yossi Leybovich schrieb:
> [about corrupt loose object '4b9458b3786228369c63936db65827de3cc06200']

You can try to create a clone (after you have fixed up the artificial 
breakages that you made). If that goes well, then the bad object is 
referenced only from reflogs.

-- Hannes
