From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on
 maxsize reached
Date: Mon, 10 Mar 2008 11:05:14 +0100
Message-ID: <47D507DA.1010802@viscovery.net>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <200803100959.43611.michal.rokos@nextsoft.cz> <47D4FF55.8020909@viscovery.net> <200803101047.47044.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Mon Mar 10 11:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYetH-0001La-06
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 11:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbYCJKFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 06:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbYCJKFS
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 06:05:18 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:36698 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYCJKFR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 06:05:17 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JYerw-00084J-6O; Mon, 10 Mar 2008 11:04:32 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 88986546; Mon, 10 Mar 2008 11:05:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200803101047.47044.michal.rokos@nextsoft.cz>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76712>

Michal Rokos schrieb:
> But - do we want to fix it now, when we don't even know that else would be 
> needed for Tru64 port? There's even no Tru64 paragraph in Makefile yet.
> 
> Michal
> 
> PS: I have no ambition to port git to Tru64 since that test machine is 
> accessible via friend of my friend - so I have to IM him the code and he 
> returns value :)

It's not your itch nor is it not mine. Someone else has to come along...

-- Hannes
